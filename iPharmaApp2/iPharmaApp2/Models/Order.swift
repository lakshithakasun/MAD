//
//  Order.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation


struct Order: Identifiable, Codable {
    let id = UUID()
    var prescription: Prescription
    var pharmacy: Pharmacist
    var pin: String
    var isCompleted: Bool
}
