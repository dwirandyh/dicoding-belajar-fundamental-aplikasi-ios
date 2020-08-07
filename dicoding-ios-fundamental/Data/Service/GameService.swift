//
//  GameService.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

typealias gameResultCompletion = (Result<[Game], NetworkError>) -> Void
typealias gameDetailResultCompletion = (Result<Game, NetworkError>) -> Void

protocol GameService {
    func discoverGame(query: String?, completion: @escaping gameResultCompletion)
    func getDetail(id: Int, completion: @escaping gameDetailResultCompletion)
}

class GameServiceImpl: GameService {

    private let baseUrl: String = "https://api.rawg.io/api/"
    private let urlSession: URLSession = URLSession.shared

    func discoverGame(query: String?, completion: @escaping gameResultCompletion) {
        var components: URLComponents = URLComponents(string: self.baseUrl + "games")!
        if let searchQuery = query, !searchQuery.isEmpty {
            components.queryItems = [
                URLQueryItem(name: "search", value: query)
            ]
        }
        let request = URLRequest(url: components.url!)
        self.urlSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
            } else {
                do {
                    let result = try JSONDecoder().decode(GameListDao.self, from: data!)
                    if let gameList = result.results {
                        completion(.success(gameList))
                    } else {
                        completion(.failure(.notFound))
                    }
                }catch let error {
                    print(error)
                    completion(.failure(.networkError))
                }
            }
        }.resume()
    }

    func getDetail(id: Int, completion: @escaping gameDetailResultCompletion) {
        let request = URLRequest(url: URL(string: "\(self.baseUrl)games/\(id)")!)
        self.urlSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkError))
            } else {
                do {
                    let result = try JSONDecoder().decode(Game.self, from: data!)
                    completion(.success(result))
                } catch let error {
                    print(error)
                    completion(.failure(.networkError))
                }
            }
        }.resume()
    }
}
