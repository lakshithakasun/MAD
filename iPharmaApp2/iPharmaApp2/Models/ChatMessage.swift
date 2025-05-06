//
//  File.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
//

import Foundation


struct ChatMessage: Identifiable, Codable {
    let id = UUID()
    var prescriptionID: UUID
    var sender: String
    var message: String
    var timestamp: Date
}
