//
//  PharmacistRegistrationView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct PharmacistRegistrationView: View {
    @ObservedObject var viewModel: AppViewModel
        @State private var name = ""
        @State private var address = ""
        @State private var location = ""
        @State private var openHours = ""
        @State private var certificate = ""
        @State private var password = ""
        @State private var showError = false
        @State private var errorMessage = ""
        @Environment(\.presentationMode) var presentation

        var body: some View {
            ScrollView {
                VStack(spacing: 25) {
                    VStack(spacing: 10) {
                        Image(systemName: "pills.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.green)

                        Text("Pharmacist Registration")
                            .font(.title2)
                            .fontWeight(.bold)
                    }

                    VStack(spacing: 16) {
                        if showError {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.subheadline)
                        }

                        TextField("Pharmacy Name", text: $name)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                        TextField("Address", text: $address)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                        TextField("Location (lat,long)", text: $location)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                        Button(action: {
                            // Simulate selecting current location (you could replace this with actual CoreLocation in production)
                            location = "7.2906, 80.6337" // Example: Kandy, Sri Lanka
                        }) {
                            Label("Use Current Location", systemImage: "location.fill")
                                .foregroundColor(.blue)
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                        }

                        TextField("Open Hours (e.g. 9AM - 5PM)", text: $openHours)
                            .keyboardType(.default)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)
                            .onChange(of: openHours) { newValue in
                                if !newValue.contains("-") || newValue.count < 5 {
                                    errorMessage = "Open hours format should be like '9AM - 5PM'."
                                    showError = true
                                } else {
                                    showError = false
                                }
                            }

                        TextField("Certificate", text: $certificate)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(10)

                        Button(action: {
                            let exists = MockDatabase.shared.pharmacists.contains { $0.pharmacyName == name }
                            if exists {
                                errorMessage = "A pharmacy with this name already exists."
                                showError = true
                            } else {
                                let pharmacist = Pharmacist(pharmacyName: name, address: address, location: location, openHours: openHours, certificate: certificate, password: password)
                                let securedPharmacist = Pharmacist(pharmacyName: pharmacist.pharmacyName, address: pharmacist.address, location: pharmacist.location, openHours: pharmacist.openHours, certificate: pharmacist.certificate, password: password)
                                viewModel.registerNewPharmacist(securedPharmacist)
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
                            .background((name.isEmpty || address.isEmpty || location.isEmpty || openHours.isEmpty || certificate.isEmpty || password.isEmpty) ? Color.gray : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(name.isEmpty || address.isEmpty || location.isEmpty || openHours.isEmpty || certificate.isEmpty || password.isEmpty)
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
