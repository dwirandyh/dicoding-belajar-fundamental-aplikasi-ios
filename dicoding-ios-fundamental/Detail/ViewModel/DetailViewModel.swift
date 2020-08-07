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

    @Published var isLoading: Bool = true
    @Published var game: Game?

    init(service: GameService = GameServiceImpl()) {
        self.service = service
    }

    func getDetailGame(id: Int){
        self.isLoading = true
        
        self.service.getDetail(id: id) { (result) in
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
        }
    }
}
