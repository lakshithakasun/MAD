//
//  UploadPrescriptionView.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-01.
//

import PhotosUI
import SwiftUI

struct UploadPrescriptionView: View {
    @ObservedObject var viewModel: AppViewModel
        @State private var selectedImage: UIImage?
        @State private var imageItem: PhotosPickerItem?
        @Environment(\.presentationMode) var presentation

        var body: some View {
            ScrollView {
                VStack(spacing: 25) {
                    VStack(spacing: 10) {
                        Image(systemName: "doc.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.blue)

                        Text("Upload Prescription")
                            .font(.title2)
                            .fontWeight(.bold)
                    }

                    VStack(spacing: 16) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 200)
                                .overlay(Text("No Image Selected").foregroundColor(.gray))
                                .cornerRadius(10)
                        }

                        PhotosPicker("Select Prescription Image", selection: $imageItem, matching: .images)
                            .onChange(of: imageItem) { newItem in
                                Task {
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                    }
                                }
                            }

                        Button(action: {
                            if let image = selectedImage,
                               let data = image.jpegData(compressionQuality: 0.8) {
                                let filename = UUID().uuidString + ".jpg"
                                let url = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
                                try? data.write(to: url)

                                // Check for duplicate prescriptions (by filename)
                                let alreadyExists = MockDatabase.shared.prescriptions.contains(where: { $0.image == url.path })

                                if !alreadyExists {
                                    viewModel.uploadPrescription(image: url.path)
                                    presentation.wrappedValue.dismiss()
                                } else {
                                    print("Duplicate prescription not allowed")
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Upload")
                                    .fontWeight(.semibold)
                                    .padding()
                                Spacer()
                            }
                            .background(selectedImage == nil ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(selectedImage == nil)
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
            .navigationTitle("Upload Prescription")
            .navigationBarTitleDisplayMode(.inline)
        }
}




