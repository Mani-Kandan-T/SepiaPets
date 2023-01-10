//
//  UIImageView+Extensions.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit

extension UIImageView {
  func downloadImageFrom(imageUrl: URL) {
    DispatchQueue.main.async {
      let placeHolderImage = UIImage(named: "placeholderImage")
      self.image = placeHolderImage
    }
    
    URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
      DispatchQueue.main.async {
        guard let data = data else { return }
        self.image = UIImage(data: data)
      }
    }.resume()
  }
  
  public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
    let shape = CAShapeLayer()
    shape.path = maskPath.cgPath
    layer.mask = shape
  }
}
