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
    @State var image: UIImage = UIImage()


    init(url: String){
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        GeometryReader{ geo in
            Image(uiImage: self.image)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width)
                .onReceive(self.imageLoader.didChange) { (data) in
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
