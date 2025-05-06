//
//  ChatView.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: AppViewModel
    var prescription: Prescription
    @State private var newMessage = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(MockDatabase.shared.chatMessages.filter { $0.prescriptionID == prescription.id }) { chat in
                        VStack(alignment: .leading) {
                            Text("\(chat.sender):")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(chat.message)
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }

            HStack {
                TextField("Type a message", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    viewModel.addChatMessage(prescriptionID: prescription.id, sender: viewModel.loggedInPharmacist?.pharmacyName ?? viewModel.patient.name, message: newMessage)
                    newMessage = ""
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
    }
}

