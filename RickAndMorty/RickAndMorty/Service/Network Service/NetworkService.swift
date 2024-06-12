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
    
    private func fetchData<T: Decodable>(endpoint: Endpoint,
                                         totalPages: Page,
                                         completion: @escaping (Result<[T], Error>) -> Void) {
        var allResults = [T]()
        let group = DispatchGroup()
        var errors: [Error] = []
        
        for page in 1...totalPages.rawValue {
            group.enter()
            guard let url = URL(string: "\(baseURL)/\(endpoint)?page=\(page)") else {
                group.leave()
                continue
            }
            
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    errors.append(error)
                    group.leave()
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    errors.append(NetworkError.invalidResponse)
                    group.leave()
                    return
                }
                
                guard let data = data else {
                    errors.append(NetworkError.noData)
                    group.leave()
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let apiResponse = try jsonDecoder.decode(APIResponse<T>.self, from: data)
                    allResults.append(contentsOf: apiResponse.results)
                    group.leave()
                } catch {
                    errors.append(NetworkError.invalidJSON)
                    group.leave()
                }
            }.resume()
        }
        
        group.notify(queue: .main) {
            if let error = errors.first {
                completion(.failure(error))
            } else {
                completion(.success(allResults))
            }
        }
    }
    
    private func downloadImages(for characters: [Character], completion: @escaping (Result<[Character], Error>) -> Void) {
        let group = DispatchGroup()
        var updatedCharacters = characters
        
        for (index, character) in characters.enumerated() {
            group.enter()
            guard let url = URL(string: character.image) else {
                group.leave()
                continue
            }
            
            session.dataTask(with: url) { data, response, error in
                if let data = data {
                    updatedCharacters[index].imageData = data
                }
                group.leave()
            }.resume()
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
        fetchData(endpoint: .location, totalPages: .allLocatios, completion: completion)
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        fetchData(endpoint: .episode, totalPages: .allEpisodes, completion: completion)
    }
}
