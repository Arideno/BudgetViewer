//
//  AddTransactionViewController.swift
//  BudgetViewer
//
//  Created by  Andrii Moisol on 05.03.2021.
//

import UIKit

class AddTransactionViewController: UIViewController {
    
    var viewModel: AddTransactionViewModel!
    
    let amountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enter amount:"
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var amountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Amount"
        tf.keyboardType = .numbersAndPunctuation
        tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Pick category:"
        lbl.font = .preferredFont(forTextStyle: .body)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var categoryPickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    lazy var addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add", for: .normal)
        btn.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
        navigationItem.title = "Add transaction"
    }
    
    private func setupViews() {
        view.addSubview(amountLabel)
        view.addSubview(amountTextField)
        view.addSubview(categoryLabel)
        view.addSubview(categoryPickerView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            amountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            amountTextField.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            amountTextField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            amountTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            categoryLabel.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            
            categoryPickerView.leadingAnchor.constraint(equalTo: amountTextField.leadingAnchor),
            categoryPickerView.trailingAnchor.constraint(equalTo: amountTextField.trailingAnchor),
            categoryPickerView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 8),
            categoryPickerView.heightAnchor.constraint(equalToConstant: 150),
            
            addButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: categoryPickerView.bottomAnchor, constant: 8)
        ])
    }
    
    private func setupViewModel() {
        viewModel.transactionCreated = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func addButtonTapped() {
        viewModel.createTransaction()
    }
}

extension AddTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            let str = (text as NSString).replacingCharacters(in: range, with: string)
            if isValidAmount(str) {
                viewModel.changeAmount(Double(str)!)
                return true
            }
        }
        
        return false
    }
}

extension AddTransactionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.pickCategory(categories[row])
    }
}
