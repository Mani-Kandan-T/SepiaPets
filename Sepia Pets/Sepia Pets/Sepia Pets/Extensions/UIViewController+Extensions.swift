//
//  UIViewController+Extensions.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction( UIAlertAction(title: Constants.okButtonText, style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
