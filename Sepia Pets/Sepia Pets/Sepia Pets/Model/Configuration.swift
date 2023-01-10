//
//  Configuration.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import Foundation

struct AppSettings: Decodable {
  var settings: WorkHours
}

struct WorkHours: Decodable {
  var workHours: String
}
