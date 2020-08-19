//
//  FavoritePage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 19/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct FavoritePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Favorite Page")
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
    }
}

struct FavoritePage_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePage()
    }
}
