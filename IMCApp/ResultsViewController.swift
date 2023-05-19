//
//  ResultsViewController.swift
//  IMCApp
//
//  Created by Lidiane Ferreira on 18/05/23.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var imcValue: String?
    var imcCategory: String?
    var imcAdvice: String?
    var imcColor: UIColor?
    
    let resultView: UIView = {
        let view = UIView()
        var scrollTarget: UIButton?
        let halfHeight = view.bounds.height / 2
        view.frame = CGRect(x: 0, y: halfHeight, width: view.bounds.width, height: 100)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let imcLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let adviceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(resultView)
        view.backgroundColor = .clear
        resultView.backgroundColor = imcColor
        applySubviews()
        applyConstraints()
        imcLabel.text = imcValue
        categoryLabel.text = imcCategory
        adviceLabel.text = imcAdvice
    }
    
    private func applySubviews() {
        resultView.addSubview(imcLabel)
        resultView.addSubview(categoryLabel)
        resultView.addSubview(adviceLabel)
    
    }
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            resultView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
            imcLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 30),
            imcLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 30),
            categoryLabel.topAnchor.constraint(equalTo: imcLabel.lastBaselineAnchor, constant: 20),
            adviceLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 30),
            adviceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            adviceLabel.topAnchor.constraint(equalTo: categoryLabel.lastBaselineAnchor, constant: 15)
            

        ])
    }

    @objc private func recalculateButtonTapped()  {
        dismiss(animated: true, completion: nil)
    }
}
