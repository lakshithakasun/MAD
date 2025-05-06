//
//  IncomingPrescriptionsView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct IncomingPrescriptionsView: View {
    @ObservedObject var viewModel: AppViewModel
    @State private var selectedPrescription: Prescription?
    @State private var showChat = false

    var body: some View {
        VStack {
            List(MockDatabase.shared.prescriptions.filter { !$0.responded && !(viewModel.loggedInPharmacist?.rejectedPrescriptionIDs.contains($0.id) ?? false) }) { prescription in
                VStack(alignment: .leading, spacing: 8) {
                    Text("Patient: \(prescription.patient.name)")
                    Text("Location: \(prescription.patient.location)").font(.caption)
                    Button("View Prescription") {
                        selectedPrescription = prescription
                    }
                }
                .padding(.vertical, 6)
            }

            if let prescription = selectedPrescription {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Selected Prescription for \(prescription.patient.name)")
                        .font(.headline)

                    if let image = UIImage(contentsOfFile: prescription.image) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 200)
                            .overlay(Text("Image Not Found"))
                    }

                    if !prescription.responded {
                        HStack(spacing: 10) {
                            Button("Accept Prescription") {
                                if let pharmacist = viewModel.loggedInPharmacist {
                                    viewModel.respondToPrescription(prescription: prescription, pharmacist: pharmacist, details: "Accepted")
viewModel.addChatMessageOnce(prescriptionID: prescription.id, sender: pharmacist.pharmacyName, message: "Hi, we've accepted your prescription. Let us know if you have any questions.")
selectedPrescription = MockDatabase.shared.prescriptions.first(where: { $0.id == prescription.id })
                                }
                            }
                            .disabled(prescription.responded)
                            .buttonStyle(.borderedProminent)

                            Button("Reject") {
                                if let pharmacistIndex = MockDatabase.shared.pharmacists.firstIndex(where: { $0.id == viewModel.loggedInPharmacist?.id }) {
                                    MockDatabase.shared.pharmacists[pharmacistIndex].rejectedPrescriptionIDs.append(prescription.id)
                                    selectedPrescription = nil
                                }
                            }
                            .foregroundColor(.red)
                            .buttonStyle(.bordered)
                        }
                    }

                    Button("Start Chat") {
                        showChat = true
                    }
                    .buttonStyle(.bordered)
                    .disabled(!prescription.responded)
                }
                .padding()
            }

            NavigationLink(destination: selectedPrescription.map { ChatView(viewModel: viewModel, prescription: $0) }, isActive: $showChat) {
                EmptyView()
            }
        }
        .navigationTitle("Incoming Prescriptions")
    }
}




