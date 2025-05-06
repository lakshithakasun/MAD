//
//  File.swift
//  iPharmaApp2
//
//  Created by LakshithaS on 2025-05-02.
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
