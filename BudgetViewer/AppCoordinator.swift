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
        let transactionsCoordinator = TransactionsCoordinator(navigationController: navigationController)
        childCoordinators.append(transactionsCoordinator)
        transactionsCoordinator.start()
    }
}
