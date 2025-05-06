//
//  AppViewModel.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var patient = Patient(name: "", address: "", location: "", mobile: "", password: "")
    @Published var loggedInPharmacist: Pharmacist? = nil
    @Published var isLoggedIn = false
    @Published var pharmacists: [Pharmacist] = []
    @Published var prescriptions: [Prescription] = []
    @Published var chatMessages: [ChatMessage] = []
    
    private static var sentAcceptanceMessages: Set<UUID> = []

    func registerPatient(patient: Patient) {
        MockRestService.shared.registerPatient(patient: patient) { success in
            if success {
                self.patient = patient
            }
        }
    }

    func registerPharmacist(pharmacist: Pharmacist) {
        MockRestService.shared.registerPharmacist(pharmacist: pharmacist) { success in
            if success {
                self.pharmacists.append(pharmacist)
            }
        }
    }

    func uploadPrescription(image: String) {
        let prescription = Prescription(
            id: UUID(),
            patient: patient,
            image: image,
            responded: false,
            responseDetails: nil,
            selectedPharmacy: nil,
            orderConfirmed: false,
            orderPin: String(Int.random(in: 1000...9999)),
            status: .uploaded
        )
        MockRestService.shared.uploadPrescription(prescription: prescription) { success in
            if success {
                self.prescriptions.append(prescription)
                self.fetchNearbyPharmacies()
            }
        }
    }

    func fetchNearbyPharmacies() {
            MockRestService.shared.fetchNearbyPharmacies(location: patient.location) { pharmacies in
                self.pharmacists = pharmacies
            }
        }

    func addChatMessage(prescriptionID: UUID, sender: String, message: String) {
        let chat = ChatMessage(prescriptionID: prescriptionID, sender: sender, message: message, timestamp: Date())
        MockDatabase.shared.chatMessages.append(chat)
    }

    
    func confirmOrder(prescription: Prescription) {
        if let index = prescriptions.firstIndex(where: { $0.id == prescription.id }) {
            prescriptions[index].orderConfirmed = true
        }
    }

    func respondToPrescription(prescription: Prescription, pharmacist: Pharmacist, details: String) {
           if let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.id == prescription.id }) {
               MockDatabase.shared.prescriptions[index].responded = true
               MockDatabase.shared.prescriptions[index].responseDetails = details
               MockDatabase.shared.prescriptions[index].selectedPharmacy = pharmacist
           }
       }
        func placeOrder(for prescription: Prescription, at pharmacy: Pharmacist) {
            guard let pin = prescription.orderPin else { return }
            MockRestService.shared.createOrder(prescription: prescription, pharmacy: pharmacy, pin: pin) { success in
                if success {
                    print("Order created and stored in mock database")
                }
            }
        }
        
        func registerNewPatient(_ patient: Patient) {
            MockRestService.shared.registerPatient(patient: patient) { success in
                if success {
                    self.patient = patient
                }
            }
        }
        
        func registerNewPharmacist(_ pharmacist: Pharmacist) {
            MockRestService.shared.registerPharmacist(pharmacist: pharmacist) { success in
                if success {
                    self.pharmacists.append(pharmacist)
                }
            }
        }
    
    func addChatMessageOnce(prescriptionID: UUID, sender: String, message: String) {
        if !AppViewModel.sentAcceptanceMessages.contains(prescriptionID) {
            let chat = ChatMessage(prescriptionID: prescriptionID, sender: sender, message: message, timestamp: Date())
            MockDatabase.shared.chatMessages.append(chat)
            AppViewModel.sentAcceptanceMessages.insert(prescriptionID)
        }
    }
    func updatePrescriptionStatus(prescription: Prescription, to status: PrescriptionStatus) {
            if let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.id == prescription.id }) {
                MockDatabase.shared.prescriptions[index].status = status
            }
        }
     
    
    }


