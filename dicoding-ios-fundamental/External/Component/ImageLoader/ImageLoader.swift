//
//  ImageLoader.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 07/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(url: String){
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }

        task.resume()
    }
}
