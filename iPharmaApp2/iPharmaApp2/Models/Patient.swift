//
//  File.swift
//  iPharmaApp2
//
//  Created by Hasanthi on 2025-05-01.
//

import Foundation


struct Patient: Identifiable, Codable {
    let id = UUID()
    var name: String
    var address: String
    var location: String
    var mobile: String
    var password: String
}
