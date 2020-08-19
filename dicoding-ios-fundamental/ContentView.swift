//
//  ContentView.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 19/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomePage()
                .tabItem {
                    Image.home
                    Text("Home")
            }

            FavoritePage()
                .tabItem{
                    Image.favorit
                    Text("Favorite")
            }

            AboutPage()
                .tabItem{
                    Image.about
                    Text("About")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
