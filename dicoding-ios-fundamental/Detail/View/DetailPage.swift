//
//  DetailPage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 05/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct DetailPage: View {

    @ObservedObject var viewModel: DetailViewModel = DetailViewModel()

    var id: Int

    init(id: Int){
        self.id = id
    }

    var body: some View {
        VStack {
            if self.viewModel.game != nil {
                DetailGame(game: self.viewModel.game!)
            } else {
                VStack {
                    ActivityIndicator(isLoading: self.$viewModel.isLoading, style: .large)
                    Text("Loading, please wait")
                }
            }
        }
        .onAppear(perform: {
            self.viewModel.getDetailGame(id: self.id)
        })
            .navigationBarTitle("Detail", displayMode: .inline)
    }
}

struct DetailGame: View {

    var game: Game

    private func openTrailer(){
        if let url = URL(string: "https://www.youtube.com/watch?v=\(self.game.clip?.video ?? "")") {
            UIApplication.shared.open(url)
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                if self.game.backgroundImage != nil {
                    ImageView(url: self.game.backgroundImage!)
                        .frame(height: 200)
                }

                VStack(alignment: .leading, spacing: .spacingLarge) {
                    HStack(alignment: .center, spacing: .spacingLarge) {
                        ImageLabel(image: .calendar, text: self.game.released?.convertToString(format: "dd MMMM yyyy") ?? "-")

                        ImageLabel(image: .timer, text: "\(self.game.playtime ?? 0) min")

                        ImageLabel(image: .starFill, text: "\(self.game.rating ?? 0)")

                        Spacer()
                    }

                    Text(self.game.name ?? "")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .italic()
                        .foregroundColor(.primaryText)


                    Text(self.game.description ?? "")
                        .font(.system(size: 12))
                        .foregroundColor(.primaryText)

                    Button(action: {
                        self.openTrailer()
                    }){
                        Text("Watch Trailer")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                    }.modifier(ButtonModifier())
                }
                .padding([.leading, .trailing], .spacingLarge)
                .padding([.top, .bottom], .spacingNormal)

                Spacer()
            }
        }
    }
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(id: 1)
    }
}
