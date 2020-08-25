//
//  DetailViewModel.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 07/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

class DetailViewModel: ObservableObject {
    private let service: GameService
    private let gameProvider: GameProvider

    @Published var isFavorite: Bool = false
    @Published var isLoading: Bool = true
    @Published var game: Game?

    init(service: GameService = GameServiceImpl(), provider: GameProvider = GameProviderImpl()) {
        self.service = service
        self.gameProvider = provider
    }

    func getDetailGame(id: Int) {
        self.isLoading = true
        
        self.service.getDetail(id: id) { [weak self] (result) in
            guard let self = self else { return }
            var gameResult: Game?
            switch result {
            case .success(let game):
                gameResult = game
            case .failure(let error):
                print(error.localizedDescription)
            }

            DispatchQueue.main.async {
                self.game = gameResult
                self.isLoading = false
            }

            self.findGame(id: gameResult?.id ?? 0)
        }
    }

    func findGame(id: Int){
        self.gameProvider.findData(gameId: id) { (isExist) in
            DispatchQueue.main.async {
                self.isFavorite = isExist
            }
        }
    }

    func addToFavoriteList(game: Game) {
        self.gameProvider.addFavorite(game: game) {
            DispatchQueue.main.async {
                self.isFavorite = true
            }
        }
    }

    func removeFavorite(gameId: Int) {
        self.gameProvider.removeFavorite(gameId: gameId) {
            DispatchQueue.main.async {
                self.isFavorite = false
            }
        }
    }
}
