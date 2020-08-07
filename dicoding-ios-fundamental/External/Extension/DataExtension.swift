//
//  PreviewExtension.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 04/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

extension Game {
    static var defaultValue: Game {
        Game(id: 1, name: "GTA", description: "", rating: 8, backgroundImage: "", released: Date(), playtime: 80, genres: [Genre(id: 0, name: "Action", slug: "", gamesCount: 0, imageBackground: "")], clip: Clip(clip: "", video: "", preview: ""))
    }

    func getGenre() -> String {
        guard let genres = self.genres else { return "" }
        let genreNames: [String] = genres.map { $0.name ?? "" }

        return genreNames.joined(separator: ", ")
    }
}
