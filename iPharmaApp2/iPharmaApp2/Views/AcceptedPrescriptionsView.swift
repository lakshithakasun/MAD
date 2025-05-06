//
//  AcceptedPrescriptionsView.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-05.
//

import SwiftUI

struct AcceptedPrescriptionsView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        List(MockDatabase.shared.prescriptions.filter { $0.patient.id == viewModel.patient.id && $0.responded }, id: \.id) { prescription in
            VStack(alignment: .leading, spacing: 10) {
                Text("Pharmacy: \(prescription.selectedPharmacy?.pharmacyName ?? "N/A")")
                    .font(.headline)
                Text("Response: \(prescription.responseDetails ?? "No details")")

                if !prescription.orderConfirmed {
                    HStack {
                        Button("Confirm Order") {
                            if let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.id == prescription.id }) {
                                MockDatabase.shared.prescriptions[index].orderConfirmed = true
                                MockDatabase.shared.prescriptions[index].status = .confirmed
                                viewModel.confirmOrder(prescription: MockDatabase.shared.prescriptions[index])
                            }
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Reject") {
                            if let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.id == prescription.id }) {
                                MockDatabase.shared.prescriptions[index].status = .cancelled
                                MockDatabase.shared.prescriptions.remove(at: index)
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                    }
                } else if let pin = prescription.orderPin {
                    Text("Your Pickup PIN: \(pin)")
                        .font(.headline)
                        .foregroundColor(.green)
                }

                NavigationLink("Chat with Pharmacy") {
                    ChatView(viewModel: viewModel, prescription: prescription)
                }
                .buttonStyle(.bordered)
            }
            .padding(.vertical, 6)
        }
        .navigationTitle("Accepted Prescriptions")
    }
}

