//
//  TransactionsViewController.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    var viewModel: TransactionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = CoreDataManager.shared.getMainAccount()?.name
    }
}
