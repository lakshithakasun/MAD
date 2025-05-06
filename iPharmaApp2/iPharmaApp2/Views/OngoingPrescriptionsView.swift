//
//  OngoingPrescriptionsView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-06.
//

import SwiftUI

struct OngoingPrescriptionsView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        List(MockDatabase.shared.prescriptions.filter { prescription in
            prescription.selectedPharmacy?.id == viewModel.loggedInPharmacist?.id && prescription.responded
        }) { prescription in
            NavigationLink(destination: PrescriptionDetailView(prescription: prescription, viewModel: viewModel)) {
                VStack(alignment: .leading) {
                    Text("Patient: \(prescription.patient.name)")
                        .font(.headline)
                    Text("Status: \(prescription.orderConfirmed ? "Confirmed" : "Awaiting Confirmation")")
                        .font(.subheadline)
                    if let pin = prescription.orderPin {
                        Text("PIN: \(pin)")
                            .font(.caption)
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Ongoing Orders")
    }
}
