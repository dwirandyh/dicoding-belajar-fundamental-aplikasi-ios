//
//  Clip.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 07/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

struct Clip: Codable {
    var clip: String?
    var video: String?
    var preview: String?

    init(clip: String, video: String, preview: String){
        self.clip = clip
        self.video = video
        self.preview = preview
    }
}
