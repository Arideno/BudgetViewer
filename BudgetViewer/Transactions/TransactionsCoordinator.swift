//
//  TransactionsCoordinator.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class TransactionsCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var transactionsViewModel: TransactionsViewModel!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let transactionsViewController = TransactionsViewController()
        transactionsViewModel = TransactionsViewModel()
        transactionsViewModel.coordinator = self
        transactionsViewController.viewModel = transactionsViewModel
        navigationController.pushViewController(transactionsViewController, animated: true)
    }
    
    func addTransaction() {
        let addTransactionCoordinator = AddTransactionCoordinator(navigationController: navigationController)
        childCoordinators.append(addTransactionCoordinator)
        addTransactionCoordinator.start()
    }
}

extension TransactionsCoordinator: UINavigationControllerDelegate {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let addTransactionViewController = fromViewController as? AddTransactionViewController {
            transactionsViewModel.loadTransactions(isPure: true)
            childDidFinish(addTransactionViewController.viewModel.coordinator)
        }
    }
}
