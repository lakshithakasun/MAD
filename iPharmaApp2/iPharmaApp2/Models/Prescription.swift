//
//  File.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation


struct Prescription: Identifiable, Codable {
    let id: UUID
    var patient: Patient
    var image: String
    var responded: Bool
    var responseDetails: String?
    var selectedPharmacy: Pharmacist?
    var orderConfirmed: Bool
    var orderPin: String?
    var status: PrescriptionStatus = .uploaded
}

enum PrescriptionStatus: String, Codable {
    case uploaded
    case accepted
    case confirmed
    case cancelled
    case completed
}

