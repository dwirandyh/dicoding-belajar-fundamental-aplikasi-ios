//
//  MovieItem.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct GameItem: View {

    var game: Game

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingNormal) {

            if self.game.backgroundImage != nil {
                ImageView(url: self.game.backgroundImage!).frame(height: 200)
                    .cornerRadius(8)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text(self.game.name ?? "-")
                        .fontWeight(.medium)
                        .foregroundColor(.primaryText)
                        .font(.system(size: 18))

                    if game.genres != nil {
                        Text(self.game.getGenre())
                            .fontWeight(.light)
                            .foregroundColor(.primaryText)
                            .font(.system(size: 10))
                    }

                    HStack(alignment: .center, spacing: .spacingLarge) {
                        ImageLabel(image: .calendar, text: self.game.released?.convertToString(format: "dd MMMM yyyy") ?? "-")

                        ImageLabel(image: .timer, text: "\(self.game.playtime ?? 0) min")

                        Spacer()
                    }

                }
                

                HStack(alignment: .center, spacing: .spacingSmall) {
                    Image.starFill
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(.gray80)
                    Text("\(String(format: "%.1f", self.game.rating ?? 0))")
                        .foregroundColor(.primaryText)
                        .font(.system(size: 14))
                }
                .frame(maxWidth: 50)
            }
        }
    }
}

#if DEBUG
struct GameItem_Previews: PreviewProvider {
    static var previews: some View {
        GameItem(game: Game.defaultValue)
            .padding(16)
            .previewLayout(.sizeThatFits)
    }
}
#endif
