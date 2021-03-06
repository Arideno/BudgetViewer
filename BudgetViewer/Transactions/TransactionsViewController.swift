//
//  TransactionsViewController.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class TransactionsViewController: UIViewController {
    
    var viewModel: TransactionsViewModel!
    
    let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.minimumFractionDigits = 2
        f.maximumFractionDigits = 6
        return f
    }()
    
    let balanceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var increaseBalanceButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        btn.tintColor = .green
        btn.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var addTransactionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add transaction", for: .normal)
        btn.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupViews()
        setupViewModel()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupViews() {
        view.addSubview(balanceLabel)
        view.addSubview(increaseBalanceButton)
        view.addSubview(addTransactionButton)
        
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            balanceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: increaseBalanceButton.leadingAnchor, constant: -16),
            
            increaseBalanceButton.widthAnchor.constraint(equalToConstant: 40),
            increaseBalanceButton.heightAnchor.constraint(equalToConstant: 40),
            increaseBalanceButton.centerYAnchor.constraint(equalTo: balanceLabel.centerYAnchor),
            increaseBalanceButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            addTransactionButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            addTransactionButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.accountChanged = { [unowned self] in
            navigationItem.title = viewModel.account.name
            balanceLabel.text = "Balance: \(numberFormatter.string(from: viewModel.account.balance ?? 0)!) BTC"
        }
        
        viewModel.rateChanged = { [unowned self] rate in
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: rate, style: .plain, target: nil, action: nil)
        }
        
        viewModel.showBalanceIncrease = { [unowned self] in
            let alert = UIAlertController(title: "Increase balance", message: "Enter amount to increase", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.placeholder = "Amount"
                textField.keyboardType = .numbersAndPunctuation
            }

            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                if let doubleValue = Double(alert.textFields![0].text ?? "") {
                    viewModel.increaseBalance(amount: doubleValue)
                    alert.dismiss(animated: true, completion: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        }
        
        viewModel.loadData()
    }
    
    // MARK: Actions
    
    @objc private func increaseButtonTapped() {
        viewModel.goToIcreaseBalance()
    }
    
    @objc private func addTransactionButtonTapped() {
        viewModel.goToAddTransaction()
    }
}
