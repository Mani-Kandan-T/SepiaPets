//
//  PetsListViewController.swift
//  Sepia Pets
//
//  Created by Manikandan on 09/01/23.
//

import UIKit

protocol PetsListControllerDelegate {
  func reloadTableView()
}

class PetsListViewController: UIViewController, PetsListControllerDelegate {
  
  @IBOutlet weak var petsListTableView: UITableView!
  
  let viewModel = PetsListViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    registerListCell()
    loadViewModel()
  }
  
  func registerListCell() {
    petsListTableView.register(UINib(nibName: Constants.petsListCellNibName, bundle: nil),
                               forCellReuseIdentifier: Constants.petsListCellIdentifier)

    petsListTableView.delegate = self
    petsListTableView.dataSource = self
  }
  
  func loadViewModel() {
    viewModel.delegate = self
    viewModel.loadPetsListFromJson()
  }
  
  /// Mark: PetsListControllerDelegate
  func reloadTableView() {
    petsListTableView.reloadData()
  }
  
}

extension PetsListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.availablePets().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let petsListCell = tableView.dequeueReusableCell(withIdentifier: Constants.petsListCellIdentifier,
                                             for: indexPath) as? PetsListTableViewCell
    let petData: PetsData = viewModel.availablePets()[indexPath.row]
    petsListCell?.configureCellWithData(pets: petData)
    return petsListCell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let detailController = storyboard?.instantiateViewController(
      withIdentifier: Constants.petsDetailControllerIdentifier) as? PetsDetailViewController else {
      return
    }
    let petData: PetsData = viewModel.availablePets()[indexPath.row]
    detailController.selectedPet = petData
    navigationController?.pushViewController(detailController, animated: true)
  }
}
