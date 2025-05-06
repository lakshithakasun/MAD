//
//  NearByPharmacyView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct NearbyPharmaciesView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        VStack {
            List(viewModel.pharmacists) { pharmacist in
                Button(pharmacist.pharmacyName) {
                    print("Selected pharmacy: \(pharmacist.pharmacyName)")
                    if let lastPrescription = viewModel.prescriptions.last {
                        viewModel.placeOrder(for: lastPrescription, at: pharmacist)
                    }
                }
            }
        }
        .navigationTitle("Nearby Pharmacies")
    }
}
