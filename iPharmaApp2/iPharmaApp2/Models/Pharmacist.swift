//
//  File.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation


struct Pharmacist: Identifiable, Codable {
    let id = UUID()
    var pharmacyName: String
    var address: String
    var location: String
    var openHours: String
    var certificate: String
    var password: String
    var rejectedPrescriptionIDs: [UUID] = []
}
