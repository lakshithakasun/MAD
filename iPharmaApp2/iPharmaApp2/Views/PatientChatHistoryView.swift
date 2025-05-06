//
//  PatientChatHistoryView.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-02.
//

import SwiftUI

struct PatientChatHistoryView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        List {
            ForEach(MockDatabase.shared.prescriptions.filter { $0.patient.id == viewModel.patient.id }) { prescription in
                Section(header: Text("Prescription: \(prescription.id.uuidString.prefix(6))")) {
                    ForEach(MockDatabase.shared.chatMessages.filter { $0.prescriptionID == prescription.id }) { message in
                        if message.sender == viewModel.patient.name {
                            HStack {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("You:")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(message.message)
                                        .padding(6)
                                        .background(Color.blue.opacity(0.1))
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
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("My Chat History")
    }
    }

