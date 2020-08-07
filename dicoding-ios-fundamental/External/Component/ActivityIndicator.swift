//
//  ActivityIndicator.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 05/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI
import Foundation

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isLoading: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: self.style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.isLoading {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }


}
