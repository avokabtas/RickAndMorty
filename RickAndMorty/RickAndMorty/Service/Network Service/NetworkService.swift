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
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "Invalid response or status code", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let apiResponse = try jsonDecoder.decode(APIResponse<T>.self, from: data)
                completion(.success(apiResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        fetchData(endpoint: .character, completion: completion)
    }
    
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void) {
        fetchData(endpoint: .location, completion: completion)
    }
    
    func fetchEpisodes(completion: @escaping (Result<[Episode], Error>) -> Void) {
        fetchData(endpoint: .episode, completion: completion)
    }
}
