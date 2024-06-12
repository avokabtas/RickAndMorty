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
    
    private func fetchData<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(endpoint)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.custom(error.localizedDescription)))
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
                completion(.success(apiResponse.results))
            } catch {
                completion(.failure(NetworkError.invalidJSON))
            }
        }.resume()
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
        fetchData(endpoint: .character) { [weak self] (result: Result<[Character], Error>) in
            switch result {
            case .success(let characters):
                self?.downloadImages(for: characters, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        fetchData(endpoint: .location, completion: completion)
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        fetchData(endpoint: .episode, completion: completion)
    }
}
