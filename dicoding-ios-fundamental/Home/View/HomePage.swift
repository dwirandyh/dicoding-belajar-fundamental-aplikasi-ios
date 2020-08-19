//
//  HomePage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 30/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct HomePage: View {

    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: .spacingLarge) {
                HomeSearchView(query: self.$viewModel.query)
                    .padding([.leading, .trailing, .top], .spacingLarge)

                if !viewModel.isLoading {
                    if viewModel.games.count > 0 {
                        HomeGameList(games: self.viewModel.games)
                    } else {
                        Text("Data not found, try other keyword")
                    }
                } else {
                    Spacer()
                    VStack {
                        ActivityIndicator(isLoading: self.$viewModel.isLoading, style: .large)
                        Text("Loading, please wait")
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
                .onAppear {
                    self.viewModel.discover()
            }
        }.accentColor(.black)
    }
}

struct HomeGameList: View {

    var games: [Game] = []

    var body: some View {
        List(self.games) { game in
            ZStack {
                GameItem(game: game)

                NavigationLink(destination: DetailPage(id: game.id ?? 0)) {
                    EmptyView()
                }.frame(width: 0, height: 0, alignment: .center)
                    .hidden()
            }
        }
    }
}

struct HomeSearchView: View {
    @Binding var query: String
    var body: some View {
        HStack {
            Image
                .search
                .foregroundColor(.gray80)
            TextField("Search Games", text: $query)
                .foregroundColor(.gray80)
        }
        .padding(.spacingNormal)
        .background(Color.gray20)
        .cornerRadius(.spacingSmall)
    }
}

struct HomePage_Previews: PreviewProvider {
    @State static var queryValue = ""

    static var previews: some View {
        Group {
            HomePage()
            HomeSearchView(query: $queryValue).previewLayout(.sizeThatFits)
            HomeGameList(games: [Game.defaultValue]).previewLayout(.sizeThatFits)

        }
    }
}
