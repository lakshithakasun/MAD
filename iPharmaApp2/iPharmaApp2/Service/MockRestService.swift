//
//  MockRestService.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation


class MockRestService {
    static let shared = MockRestService()

    func registerPatient(patient: Patient, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            MockDatabase.shared.patients.append(patient)
            completion(true)
        }
    }

    func registerPharmacist(pharmacist: Pharmacist, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            MockDatabase.shared.pharmacists.append(pharmacist)
            completion(true)
        }
    }

    func uploadPrescription(prescription: Prescription, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            MockDatabase.shared.prescriptions.append(prescription)
            completion(true)
        }
    }

    func fetchNearbyPharmacies(location: String, completion: @escaping ([Pharmacist]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(MockDatabase.shared.pharmacists)
        }
    }
    func createOrder(prescription: Prescription, pharmacy: Pharmacist, pin: String, completion: @escaping (Bool) -> Void) {
            let order = Order(prescription: prescription, pharmacy: pharmacy, pin: pin, isCompleted: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                MockDatabase.shared.orders.append(order)
                completion(true)
            }
        }
}


