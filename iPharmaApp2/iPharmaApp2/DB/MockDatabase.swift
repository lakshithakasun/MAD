//
//  MockDatabase.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation

class MockDatabase {
    static var shared = MockDatabase()

    // Track session here to fix reference issue
    var loggedInPharmacist: Pharmacist? = nil

    var patients: [Patient] = [
        Patient(name: "Jane Doe", address: "123 Main St", location: "7.2906, 80.6337", mobile: "0718407133", password: "123"),
        Patient(name: "John Smith", address: "456 Park Ave", location: "6.9271, 79.8612", mobile: "0718117881", password: "456")
    ]
    var pharmacists: [Pharmacist] = [
        // Each pharmacist can track their rejected prescriptions
        Pharmacist(pharmacyName: "HealthPlus", address: "456 Elm St", location: "37.7750,-122.4195", openHours: "9 AM - 9 PM", certificate: "ABC123", password: "123", rejectedPrescriptionIDs: []),
        Pharmacist(pharmacyName: "MediCare", address: "789 Oak St", location: "37.7760,-122.4185", openHours: "8 AM - 8 PM", certificate: "XYZ456", password: "123", rejectedPrescriptionIDs: [])
    ]
    var prescriptions: [Prescription] {
            get {
                if let pharmacist = loggedInPharmacist {
                    return allPrescriptions.filter { !pharmacist.rejectedPrescriptionIDs.contains($0.id) }
                }
                return allPrescriptions
        }
               
            
            set {
                allPrescriptions = newValue
            }
        }
        
           

    var allPrescriptions: [Prescription] = []
    var chatMessages: [ChatMessage] = []
    var orders: [Order] = []
}
