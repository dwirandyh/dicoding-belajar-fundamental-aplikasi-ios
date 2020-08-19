//
//  Button.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 06/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI


struct ButtonModifier: ViewModifier {

    enum ButtonStyle {
        case filled
        case unfilled
    }

    var style: ButtonModifier.ButtonStyle
    
    func body(content: Content) -> some View {
        switch self.style {
        case .filled:
            return AnyView(content
                .frame(maxWidth: .infinity)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.red80)
                .cornerRadius(16))
        default:
            return AnyView(content
                .frame(maxWidth: .infinity)
                .padding(10)
                .foregroundColor(Color.red80)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.red80, lineWidth: 1)
            ))
        }
    }
}

struct ButtonModifier_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {

        }){
            Text("Text")
        }.modifier(ButtonModifier(style: .unfilled)).padding()
    }
}
