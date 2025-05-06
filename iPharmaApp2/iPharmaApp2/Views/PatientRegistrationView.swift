//
//  PatientRegistrationView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct PatientRegistrationView: View {
    @ObservedObject var viewModel: AppViewModel
       @State private var name = ""
       @State private var address = ""
       @State private var location = ""
       @State private var mobile = ""
       @State private var password = ""
       @State private var showError = false
       @State private var errorMessage = ""
       @Environment(\.presentationMode) var presentation

       var body: some View {
           ScrollView {
               VStack(spacing: 25) {
                   VStack(spacing: 10) {
                       Image(systemName: "person.badge.plus")
                           .resizable()
                           .scaledToFit()
                           .frame(width: 70, height: 70)
                           .foregroundColor(.blue)

                       Text("Register as Patient")
                           .font(.title2)
                           .fontWeight(.bold)
                   }

                   VStack(spacing: 16) {
                       if showError {
                           Text(errorMessage)
                               .foregroundColor(.red)
                               .font(.subheadline)
                       }

                       TextField("Full Name", text: $name)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       TextField("Address", text: $address)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       VStack(alignment: .leading, spacing: 8) {
                           TextField("Location (lat,long)", text: $location)
                               .padding()
                               .background(Color(UIColor.secondarySystemBackground))
                               .cornerRadius(10)

                           Button(action: {
                               location = "7.2906, 80.6337"
                           }) {
                               Label("Use Current Location", systemImage: "location.fill")
                                   .foregroundColor(.blue)
                                   .padding(8)
                                   .frame(maxWidth: .infinity)
                                   .background(Color(UIColor.systemGray6))
                                   .cornerRadius(8)
                           }
                       }

                       TextField("Mobile Number", text: $mobile)
                           .keyboardType(.phonePad)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       SecureField("Password", text: $password)
                           .padding()
                           .background(Color(UIColor.secondarySystemBackground))
                           .cornerRadius(10)

                       Button(action: {
                           let exists = MockDatabase.shared.patients.contains { $0.mobile == mobile }
                           if exists {
                               errorMessage = "A patient with this mobile number already exists."
                               showError = true
                           } else {
                               let patient = Patient(name: name, address: address, location: location, mobile: mobile, password: password)
                               viewModel.registerNewPatient(patient)
                               showError = false
                               presentation.wrappedValue.dismiss()
                           }
                       }) {
                           HStack {
                               Spacer()
                               Text("Register")
                                   .fontWeight(.semibold)
                                   .padding()
                               Spacer()
                           }
                           .background((name.isEmpty || address.isEmpty || location.isEmpty || mobile.isEmpty || password.isEmpty) ? Color.gray : Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                       }
                       .disabled(name.isEmpty || address.isEmpty || location.isEmpty || mobile.isEmpty || password.isEmpty)
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
           .navigationTitle("Patient Registration")
           .navigationBarTitleDisplayMode(.inline)
       }
}
