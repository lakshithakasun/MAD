//
//  PharmacistLoginView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-03.
//

import SwiftUI

struct PharmacistLoginView: View {
    @ObservedObject var viewModel: AppViewModel
       @State private var pharmacyName = ""
       @State private var password = ""
       @State private var loginFailed = false
       @Environment(\.presentationMode) var presentation

       var body: some View {
           ScrollView {
               VStack(spacing: 25) {
                   VStack(spacing: 10) {
                       Image(systemName: "cross.case.fill")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 70, height: 70)
                           .foregroundColor(.green)

                       Text("Pharmacist Login")
                           .font(.title2)
                           .fontWeight(.bold)
                   }

                   VStack(spacing: 16) {
                       TextField("Pharmacy Name", text: $pharmacyName)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       SecureField("Password", text: $password)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       if loginFailed {
                           Text("Invalid credentials")
                               .foregroundColor(.red)
                               .font(.caption)
                       }

                       Button(action: {
                           if let pharmacist = MockDatabase.shared.pharmacists.first(where: {
                               $0.pharmacyName == pharmacyName && $0.password == password
                           }) {
                               viewModel.loggedInPharmacist = pharmacist
                               viewModel.isLoggedIn = true
                               loginFailed = false
                               presentation.wrappedValue.dismiss()
                           } else {
                               loginFailed = true
                           }
                       }) {
                           HStack {
                               Spacer()
                               Text("Login")
                                   .fontWeight(.semibold)
                                   .padding()
                               Spacer()
                           }
                           .background((pharmacyName.isEmpty || password.isEmpty) ? Color.gray : Color.green)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                       }
                       .disabled(pharmacyName.isEmpty || password.isEmpty)
                   }
                   .padding()
                   .background(Color.white)
                   .cornerRadius(15)
                   .shadow(radius: 4)
                   .padding(.horizontal, 20)
               }
               .padding()
           }
           .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
           .navigationTitle("")
           .navigationBarTitleDisplayMode(.inline)
       }
}
