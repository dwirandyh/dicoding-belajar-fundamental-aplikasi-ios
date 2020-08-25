//
//  FavoriteViewModel.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 25/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

class FavoriteViewModel: ObservableObject {

    private var provider: GameProvider

    @Published var games: [Game] = []

    init(provider: GameProvider = GameProviderImpl()) {
        self.provider = provider
    }

    func getFavoriteGame(){
        self.provider.getAllFavorite { (games) in
            DispatchQueue.main.async {
                self.games = games
            }
        }
    }
}
