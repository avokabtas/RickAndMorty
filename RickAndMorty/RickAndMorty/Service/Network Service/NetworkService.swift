//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

protocol INetworkService {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void)
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void)
}

final class NetworkService: INetworkService {
    private let baseURL = "https://rickandmortyapi.com/api"
    private let session = URLSession.shared
    private let imageCache = NSCache<NSString, NSData>()
    
    /// Последовательная загрузка данных по страницам API.
    /// - Parameters:
    ///   - endpoint: Точка API, с которой мы хотим загрузить данные (character, location, episode).
    ///   - totalPages: Общее количество страниц, которые нужно загрузить.
    ///   - page: Текущая страница, которую мы загружаем. По умолчанию, это 1.
    ///   - allResults: Массив, в который собираем результаты загрузки данных с каждой страницы. По умолчанию, пустой.
    ///   - completion: Замыкание, которое передает либо успешный результат с массивом данных, либо ошибку.
    private func fetchData<T: Decodable>(endpoint: Endpoint,
                                         totalPages: Page,
                                         page: Int = 1, 
                                         allResults: [T] = [],
                                         completion: @escaping (Result<[T], Error>) -> Void) {
        
        guard page <= totalPages.rawValue else {
            completion(.success(allResults))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/\(endpoint)?page=\(page)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try jsonDecoder.decode(APIResponse<T>.self, from: data)
                let newResults = allResults + apiResponse.results
                self?.fetchData(endpoint: endpoint, totalPages: totalPages, page: page + 1, allResults: newResults, completion: completion)
            } catch {
                completion(.failure(NetworkError.invalidJSON))
            }
        }.resume()
    }
    
    /// Загрузка изображений персонажей
    private func downloadImages(for characters: [Character],
                                completion: @escaping (Result<[Character], Error>) -> Void) {
        let group = DispatchGroup()
        var updatedCharacters = characters
        
        for (index, character) in characters.enumerated() {
            group.enter()
            if let cachedData = imageCache.object(forKey: NSString(string: character.image)) {
                updatedCharacters[index].imageData = cachedData as Data
                group.leave()
            } else {
                guard let url = URL(string: character.image) else {
                    group.leave()
                    continue
                }
                
                session.dataTask(with: url) { [weak self] data, response, error in
                    if let data = data {
                        self?.imageCache.setObject(data as NSData, forKey: NSString(string: character.image))
                        updatedCharacters[index].imageData = data
                    }
                    group.leave()
                }.resume()
            }
        }
        
        group.notify(queue: .main) {
            completion(.success(updatedCharacters))
        }
    }

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        fetchData(endpoint: .character, totalPages: .allCharacters) { [weak self] (result: Result<[Character], Error>) in
            switch result {
            case .success(let characters):
                self?.downloadImages(for: characters, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        fetchData(endpoint: .location, totalPages: .allLocations, completion: completion)
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        fetchData(endpoint: .episode, totalPages: .allEpisodes, completion: completion)
    }
}
