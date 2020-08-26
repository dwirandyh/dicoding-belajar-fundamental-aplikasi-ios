//
//  ImageView.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 07/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct ImageView: View {

    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage?
    @State var isLoading: Bool = true


    init(url: String){
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        GeometryReader{ geo in
            VStack {
                if self.isLoading {
                    ActivityIndicator(isLoading: self.$isLoading, style: .medium)
                    Text("Loading image...")
                        .foregroundColor(.primaryText)
                } else {
                    Image(uiImage: self.image!)
                        .resizable()
                        .frame(width: geo.size.width)
                }
            }
            .onReceive(self.imageLoader.didChange) { (data) in
                self.isLoading = false
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://cdn.medcom.id/dynamic/content/2020/05/14/1143687/tqVJ6ybkcx.jpg?w=480")
    }
}
