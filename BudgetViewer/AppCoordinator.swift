//
//  AppCoordinator.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let transactionsViewController = TransactionsViewController()
        let transactionsViewModel = TransactionsViewModel()
        transactionsViewController.viewModel = transactionsViewModel
        navigationController.pushViewController(transactionsViewController, animated: true)
    }
}
