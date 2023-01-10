//
//  PetsDetailViewController.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit
import WebKit

class PetsDetailViewController: UIViewController {
  
  @IBOutlet weak var headerImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var lastModifiedDateLabel: UILabel!
  @IBOutlet weak var contentWebview: WKWebView!
  
  @IBOutlet weak var contentWebviewHeightContraint: NSLayoutConstraint!
  var selectedPet: PetsData?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    renderHeaderImageWithTitle()
    loadContentInWebView()
  }
  
  func renderHeaderImageWithTitle() {
    guard let selectedPet = selectedPet else {
      return
    }
    
    if let imageURl = URL(string: selectedPet.imageUrl) {
      headerImageView.downloadImageFrom(imageUrl: imageURl)
    }
    titleLabel.text = selectedPet.title
    lastModifiedDateLabel.text = DateHelper.shared
      .lastModifiedDateWithTime(dateStr: selectedPet.dateAdded)
  }
  
  func loadContentInWebView() {
    contentWebview.navigationDelegate = self
    
    guard let contentUrlString = selectedPet?.contentUrl,
    let contentUrl = URL(string: contentUrlString) else {
      return
    }
    let request = URLRequest(url: contentUrl)
    contentWebview.load(request)
  }
}

extension PetsDetailViewController: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    showAlert(title: Constants.contentUrlNotLoaded, message: error.localizedDescription)
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    self.contentWebview.evaluateJavaScript("document.readyState") { (complete, error) in
      if complete != nil {
        DispatchQueue.main.async {
          self.contentWebview.evaluateJavaScript("document.body.scrollHeight") { (height, error) in
            if let height = height as? CGFloat {
              self.contentWebviewHeightContraint.constant = height
            }
          }
        }
      }
    }
  }
}
