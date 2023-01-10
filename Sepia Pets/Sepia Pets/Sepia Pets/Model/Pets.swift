//
//  Pets.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import Foundation

struct PetsData: Decodable {
  var imageUrl: String
  var title: String
  var contentUrl: String
  var dateAdded: String
  
  private enum CodingKeys : String, CodingKey {
    case imageUrl = "image_url"
    case title
    case contentUrl = "content_url"
    case dateAdded = "date_added"
  }
}

struct Pets: Decodable {
  var pets: [PetsData]
}
