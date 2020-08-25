//
//  FavoritePage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 19/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct FavoritePage: View {

    @ObservedObject var viewModel: FavoriteViewModel = FavoriteViewModel()

    var body: some View {
        NavigationView {
            List(self.viewModel.games) { game in
                ZStack {
                    GameItem(game: game)

                    NavigationLink(destination: DetailPage(id: game.id ?? 0)) {
                        EmptyView()
                    }.frame(width: 0, height: 0, alignment: .center)
                        .hidden()
                }
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
        .onAppear {
            self.viewModel.getFavoriteGame()
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
