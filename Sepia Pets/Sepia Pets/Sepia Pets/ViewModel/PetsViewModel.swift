//
//  PetsViewModel.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import Foundation

protocol PetsListModelDelegate {
  func loadPetsListFromJson()
}

class PetsListViewModel: PetsListModelDelegate {
  
  var delegate: PetsListControllerDelegate?
  private var pets : [PetsData] = []
  
  func loadPetsListFromJson() {
    let fileName = Constants.petsJsonFileName
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: Constants.fileType) {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let petsData = try decoder.decode(Pets.self, from: data)
        self.pets = petsData.pets
        delegate?.reloadTableView()
      } catch {
        print("error:\(error)")
      }
    }
  }
  
  func availablePets() -> [PetsData] {
    return pets
  }
  
  
}
