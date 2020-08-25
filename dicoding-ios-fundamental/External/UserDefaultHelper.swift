//
//  Preference.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 25/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation

class UserDefaultHelper {
    enum Keys: String, CaseIterable {
        case isFirstLoad
        case name
        case role
        case github
        case website
        case dicodingProfile
    }

    static func save<T>(value: T, forKey: UserDefaultHelper.Keys) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: forKey.rawValue)
    }

    static func load<T>(forKey: UserDefaultHelper.Keys) -> T? {
        let defaults = UserDefaults.standard
        let value = defaults.object(forKey: forKey.rawValue) as? T
        return value
    }

    static func delete(key: UserDefaultHelper.Keys) {
       let defaults = UserDefaults.standard
       defaults.removeObject(forKey: key.rawValue)
    }
}
