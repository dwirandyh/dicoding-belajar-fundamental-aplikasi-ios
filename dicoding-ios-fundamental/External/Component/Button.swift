//
//  Button.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 06/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(10)
            .foregroundColor(.white)
            .background(Color.red80)
            .cornerRadius(16)

    }
}

struct ButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {

        }){
            Text("Text")
        }.modifier(ButtonModifier()).padding()
    }
}
