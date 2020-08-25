//
//  EditProfilePage.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 25/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import SwiftUI

struct EditProfilePage: View {

    @ObservedObject var viewModel: AboutViewModel = AboutViewModel()

    @Environment(\.presentationMode) var presentation

    var body: some View {
        Form {
            Section(header: Text("PROFILE")) {
                TextField("Nama", text: self.$viewModel.name)
                TextField("Pekerjaan", text: self.$viewModel.role)
            }
            Section(header: Text("PORTFOLIO")) {
                TextField("Github", text: self.$viewModel.github)
                TextField("Website", text: self.$viewModel.website)
                TextField("Dicoding Profile", text: self.$viewModel.dicodingProfile)
            }

            Section {
                Button(action: {
                    self.viewModel.saveData()
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Simpan Data")
                }
            }
        }
        .navigationBarTitle("Edit Profile", displayMode: .inline)
        .onAppear {
            self.viewModel.loadData()
        }
    }
}

struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePage()
    }
}
