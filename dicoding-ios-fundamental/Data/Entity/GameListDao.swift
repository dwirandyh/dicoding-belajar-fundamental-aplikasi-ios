//
//  GameListDao.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

struct GameListDao: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [Game]?
}
