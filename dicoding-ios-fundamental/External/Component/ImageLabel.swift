//
//  ImageLabel.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 29/07/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct ImageLabel: View {
    var image: Image
    @State var color: Color = .primaryText
    var text: String
    var body: some View {
        HStack(alignment: .center, spacing: .spacingSmall) {
            self.image
                .foregroundColor(self.color)
                .frame(width: 16, height: 16, alignment: .center)
            Text(text)
                .foregroundColor(self.color)
                .font(.system(size: 10))
        }
    }

    mutating func color(color: Color) -> ImageLabel {
        self.color = color
        return self
    }
}

struct ImageLabel_Previews: PreviewProvider {
    static var previews: some View {
        ImageLabel(image: .calendar, text: "19 Maret 2020").previewLayout(.sizeThatFits)
    }
}
