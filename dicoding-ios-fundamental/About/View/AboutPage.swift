//
//  AboutPage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 07/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct AboutPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            AboutProfile()

            VStack(alignment: .leading, spacing: 24) {
                AboutLink(name: "Github", link: "https://github.com/dwirandyh")
                AboutLink(name: "Website", link: "https:://dwirandyh.com")
                AboutLink(name: "Dicoding Profile", link: "https://dicoding.com")
            }
            .padding([.leading, .trailing], .spacingLarge)

            Spacer()

//            HStack {
//                Spacer()
//                Spacer()
//            }
        }
        .navigationBarTitle("Profile")
    }
}

struct AboutLink: View {
    var name: String
    var link: String

    init(name: String, link: String){
        self.name = name
        self.link = link
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .spacingSmall) {
            Text(name)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.primaryText)

            Text(link)
                .font(.system(size: 13))
                .fontWeight(.regular)
                .foregroundColor(.primaryText)
        }
    }
}

struct AboutProfile: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Image.background
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: 200)

                HStack(alignment: .center, spacing: .spacingNormal) {
                    Image.profile
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                    VStack(alignment: .leading) {
                        Text("Dwi Randy H")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                        Text("iOS Engineer")
                            .font(.system(size: 14))
                            .foregroundColor(.primaryText)
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding([.top], 45)
            }
        }.frame(height: 200)
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutPage()
            AboutLink(name: "Github", link: "https://github.com/dwirandyh").previewLayout(.sizeThatFits)
            AboutProfile().previewLayout(.sizeThatFits)
        }
    }
}
