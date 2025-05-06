//
//  LoginView.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-01.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AppViewModel
        @State private var mobile = ""
        @State private var password = ""
        @State private var loginSuccess = false
        @State private var loginFailed = false
        @Environment(\.presentationMode) var presentation

        var body: some View {
            VStack(spacing: 25) {
                VStack(spacing: 10) {
                    Image(systemName: "person.crop.circle.fill.badge.checkmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.blue)

                    Text("Patient Login")
                        .font(.title2)
                        .fontWeight(.bold)
                }

                VStack(spacing: 16) {
                    TextField("Mobile Number", text: $mobile)
                        .keyboardType(.phonePad)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)

                    if loginFailed {
                        Text("Invalid mobile number or password")
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: {
                        if let patient = MockDatabase.shared.patients.first(where: { $0.mobile == mobile && $0.password == password }) {
                            viewModel.patient = patient
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
                        .background((mobile.isEmpty || password.isEmpty) ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(mobile.isEmpty || password.isEmpty)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 4)
                .padding(.horizontal, 20)
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
        }
}
