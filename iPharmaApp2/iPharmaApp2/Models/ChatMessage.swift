//
//  File.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-01.
//

import Foundation


struct ChatMessage: Identifiable, Codable {
    let id = UUID()
    var prescriptionID: UUID
    var sender: String
    var message: String
    var timestamp: Date
}
