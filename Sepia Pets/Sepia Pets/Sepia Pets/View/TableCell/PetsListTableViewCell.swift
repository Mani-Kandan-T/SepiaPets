//
//  PetsListTableViewCell.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit

class PetsListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var petTitleLabel: UILabel!
  @IBOutlet weak var petImage: UIImageView!
    
  override func awakeFromNib() {
    super.awakeFromNib()
    petImage.layer.cornerRadius = Constants.cellImageCornerRadius
  }
  
  func configureCellWithData(pets: PetsData) {
    petTitleLabel.text = pets.title
    if let imageURl = URL(string: pets.imageUrl) {
      petImage.downloadImageFrom(imageUrl: imageURl)
    }
  }
}
