//
//  PharmacistChatHistoryView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-03.
//

import SwiftUI

struct PharmacistChatHistoryView: View {
    var pharmacist: Pharmacist

    var body: some View {
        List {
            ForEach(MockDatabase.shared.prescriptions.filter { $0.selectedPharmacy?.id == pharmacist.id }) { prescription in
                Section(header: Text("Prescription: \(prescription.id.uuidString.prefix(6))")) {
                    ForEach(MockDatabase.shared.chatMessages.filter { $0.prescriptionID == prescription.id }) { message in
                        if message.sender == pharmacist.pharmacyName {
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("You:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(message.message)
                                        .padding(6)
                                        .background(Color.green.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                        } else {
                            VStack(alignment: .leading) {
                                Text(message.sender)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(message.message)
                                    .padding(6)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Pharmacy Chat History")
    }
}
