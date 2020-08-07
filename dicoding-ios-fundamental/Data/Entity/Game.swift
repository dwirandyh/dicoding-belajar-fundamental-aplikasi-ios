//
//  Game.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct Game: Codable, Identifiable {
    var id: Int?
    var name: String?
    var description: String?
    var rating: Float?
    var backgroundImage: String?
    var released: Date?
    var playtime: Int?
    var genres: [Genre]?
    var clip: Clip?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case rating
        case backgroundImage = "background_image"
        case released
        case playtime
        case genres
        case clip
    }

    init(id: Int?, name: String?, description: String?, rating: Float?, backgroundImage: String?, released: Date?, playtime: Int?, genres: [Genre]?, clip: Clip?) {
        self.id = id
        self.name = name
        self.description = description
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.released = released
        self.playtime = playtime
        self.genres = genres
        self.clip = clip
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dateString = try? container.decode(String.self, forKey: .released)

        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        rating = try? container.decode(Float.self, forKey: .rating)
        backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        released = dateString?.convertToDate()
        playtime = try? container.decode(Int.self, forKey: .playtime)
        genres = try? container.decode([Genre].self, forKey: .genres)
        clip = try? container.decode(Clip.self, forKey: .clip)
    }
}
