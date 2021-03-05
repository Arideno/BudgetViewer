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
        view.backgroundColor = .red
        
        view.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(testAction)))
    }
    
    @objc private func testAction() {
        viewModel.goToAddTransaction()
    }
}