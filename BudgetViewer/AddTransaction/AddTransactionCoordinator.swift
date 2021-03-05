//
//  AddTransactionCoordinator.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class AddTransactionCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addTransactionsViewController = AddTransactionViewController()
        let addTransactionsViewModel = AddTransactionViewModel()
        addTransactionsViewModel.coordinator = self
        addTransactionsViewController.viewModel = addTransactionsViewModel
        navigationController.pushViewController(addTransactionsViewController, animated: true)
    }
}
