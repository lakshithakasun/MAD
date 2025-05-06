//
//  PrescriptionDetailView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI


struct PrescriptionDetailView: View {
    var prescription: Prescription
    @ObservedObject var viewModel: AppViewModel
    @State private var pharmacistResponse = ""
    @State private var showChat = false

    var body: some View {
        VStack(spacing: 15) {
            Image(prescription.image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            if prescription.responded {
                Text("Response: \(prescription.responseDetails ?? "No details") from \(prescription.selectedPharmacy?.pharmacyName ?? "N/A")")

                if !prescription.orderConfirmed {
                    Button("Confirm Order") {
                        viewModel.confirmOrder(prescription: prescription)
                    }
                } else {
                    Text("Order Confirmed! PIN: \(prescription.orderPin ?? "0000")")
                }

                Button("Chat with Patient") {
                    showChat = true
                }
                .buttonStyle(.borderedProminent)
            } else {
                TextField("Enter response details", text: $pharmacistResponse)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack(spacing: 16) {
                    Button("Accept & Enable Chat") {
                        if let pharmacy = viewModel.pharmacists.first {
                            viewModel.respondToPrescription(prescription: prescription, pharmacist: pharmacy, details: pharmacistResponse)
                            showChat = true
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Reject") {
                        if let pharmacistIndex = MockDatabase.shared.pharmacists.firstIndex(where: { $0.id == viewModel.loggedInPharmacist?.id }) {
                            MockDatabase.shared.pharmacists[pharmacistIndex].rejectedPrescriptionIDs.append(prescription.id)
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
            }

            NavigationLink(destination: ChatView(viewModel: viewModel, prescription: prescription), isActive: $showChat) {
                EmptyView()
            }
        }
        .padding()
    }
}







