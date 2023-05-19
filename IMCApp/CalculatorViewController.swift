//
//  CalculatorViewController.swift
//  IMCApp
//
//  Created by Lidiane Ferreira on 17/05/23.
//

import UIKit
//model
class CalculatorViewController: UIViewController {
    
    var imcCalculator = IMCCalculator()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculadora IMC"
        label.font = UIFont.systemFont(ofSize: 25, weight: .black)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Altura (cm)"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let weightLabel: UILabel = {
        let label = UILabel()
        label.text = "Peso (Kg)"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Digite um número"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Digite um número"
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .line
        textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Calcular", for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var recalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Recalcular", for: .normal)
        button.tintColor = .black
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGray6
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var resultView: UIView = {
        let view = UIView()
        var scrollTarget: UIButton?
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        applySubviews()
        applyConstraints()
        weightTextField.delegate = self
        heightTextField.delegate = self
        self.calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        recalculateButton.isHidden = true
        self.recalculateButton.addTarget(self, action: #selector(recalculateButtonTapped), for: .touchUpInside)
    }
    
    private func applySubviews() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(heightLabel)
        contentStackView.addArrangedSubview(heightTextField)
        contentStackView.addArrangedSubview(weightLabel)
        contentStackView.addArrangedSubview(weightTextField)
        contentStackView.addArrangedSubview(calculateButton)
        contentStackView.addArrangedSubview(recalculateButton)
        
        
    }
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            heightLabel.heightAnchor.constraint(equalToConstant: 20),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            heightTextField.heightAnchor.constraint(equalToConstant: 40),
            weightTextField.heightAnchor.constraint(equalToConstant: 40),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            calculateButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 100),
            calculateButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -100),
            recalculateButton.heightAnchor.constraint(equalToConstant: 40),
            recalculateButton.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 100),
            recalculateButton.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -100),
            
        ])
    }
    
    private func clearFields() {
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    private func heightValue() -> Float? {
        if let heightString = heightTextField.text, let height = Float(heightString) {
            return height
        } else {
            print("A conversão falhou")
            return nil
        }
    }
    private func weightValue () -> Float? {
        if let weightString = weightTextField.text, let weight = Float(weightString) {
            return weight
        } else {
            print("A conversão falhou")
            return nil
        }
    }
    
    @objc private func calculateButtonTapped() {
        guard let heightValue = heightValue(), let weightValue = weightValue() else {
            return
        }
        imcCalculator.calculateIMC(height: heightValue, weight: weightValue)
        let resultsViewController = ResultsViewController()
        resultsViewController.imcValue = imcCalculator.getImcValue()
        resultsViewController.imcCategory = imcCalculator.getImcCategory()
        resultsViewController.imcAdvice = imcCalculator.getAdvice()
        resultsViewController.imcColor = imcCalculator.getColor()
        
        resultsViewController.modalPresentationStyle = .overCurrentContext
        self.present(resultsViewController, animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.5) {
            self.resultView.alpha = 1.0
            self.resultView.transform = CGAffineTransform(translationX: 0, y: -self.resultView.bounds.height)
        }
        calculateButton.isHidden = true
        recalculateButton.isHidden = false
    }
    
    @objc private func recalculateButtonTapped()  {
        if recalculateButton.isTouchInside == true {
            dismiss(animated: true)
            calculateButton.isHidden = false
            calculateButtonTapped()
        }
        calculateButtonTapped()
        clearFields()
        resultView.alpha = 0
        resultView.transform = CGAffineTransform(translationX: 0, y: resultView.bounds.height)
        recalculateButton.isHidden = true
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        heightTextField.clearsOnBeginEditing = true
        weightTextField.clearsOnBeginEditing = true
    return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        heightTextField.endEditing(true)
        weightTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Digite um número válido"
            return false
        }
    }
    
}
