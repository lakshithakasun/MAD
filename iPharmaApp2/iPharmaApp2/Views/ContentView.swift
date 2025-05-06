//
//  ContentView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = AppViewModel()
        var prescription: Prescription?

        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("💊 Welcome to iPharma")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.top, 30)

                        Divider()

                        VStack(spacing: 20) {
                            if viewModel.isLoggedIn {
                                HStack {
                                    Text("Hello, \(viewModel.loggedInPharmacist?.pharmacyName ?? viewModel.patient.name)")
                                        .font(.headline)
                                    Spacer()
                                    Button {
                                        viewModel.isLoggedIn = false
                                        viewModel.loggedInPharmacist = nil
                                        viewModel.patient = Patient(name: "", address: "", location: "", mobile: "", password: "")
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            if let window = UIApplication.shared.windows.first {
                                                window.rootViewController = UIHostingController(rootView: ContentView(prescription: nil))
                                                window.makeKeyAndVisible()
                                            }
                                        }
                                    } label: {
                                        Label("Logout", systemImage: "arrow.backward.circle")
                                            .foregroundColor(.red)
                                            .padding(8)
                                            .background(Color.red.opacity(0.1))
                                            .cornerRadius(8)
                                    }
                                }

                                if viewModel.loggedInPharmacist != nil {
                                    Group {
                                        NavigationLink(destination: IncomingPrescriptionsView(viewModel: viewModel)) {
                                            menuItem(title: "Pharmacist Inbox", icon: "tray.full")
                                        }
                                        NavigationLink(destination: OngoingPrescriptionsView(viewModel: viewModel)) {
                                            menuItem(title: "Ongoing Orders", icon: "clock")
                                        }
                                        NavigationLink(destination: PharmacistChatHistoryView(pharmacist: viewModel.loggedInPharmacist!)) {
                                            menuItem(title: "Pharmacy Chat History", icon: "bubble.left.and.bubble.right")
                                        }
                                    }
                                } else {
                                    Group {
                                        NavigationLink(destination: UploadPrescriptionView(viewModel: viewModel)) {
                                            menuItem(title: "Upload Prescription", icon: "doc.fill")
                                        }
                                        NavigationLink(destination: AcceptedPrescriptionsView(viewModel: viewModel)) {
                                            menuItem(title: "Accepted Prescriptions", icon: "doc.fill")
                                        }
                                        NavigationLink(destination: NearbyPharmaciesView(viewModel: viewModel)) {
                                            menuItem(title: "Nearby Pharmacies", icon: "location.circle")
                                        }
                                        NavigationLink(destination: PatientChatHistoryView(viewModel: viewModel)) {
                                            menuItem(title: "View My Chat History", icon: "message.fill")
                                        }
                                    }
                                }
                            } else {
                                Group {
                                    NavigationLink(destination: LoginView(viewModel: viewModel)) {
                                        menuItem(title: "Login as Patient", icon: "person")
                                    }
                                    NavigationLink(destination: PharmacistLoginView(viewModel: viewModel)) {
                                        menuItem(title: "Login as Pharmacist", icon: "cross.case")
                                    }
                                    NavigationLink(destination: PatientRegistrationView(viewModel: viewModel)) {
                                        menuItem(title: "Register as Patient", icon: "person.badge.plus")
                                    }
                                    NavigationLink(destination: PharmacistRegistrationView(viewModel: viewModel)) {
                                        menuItem(title: "Register as Pharmacist", icon: "pills")
                                    }
                                }

                                Text("Please login to access features.")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, 20)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(15)
                        .shadow(radius: 4)
                    }
                    .padding()
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }
        }

        private func menuItem(title: String, icon: String) -> some View {
            HStack {
                Label(title, systemImage: icon)
                    .padding()
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
        }
}





