//
//  AuthViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 10.12.2021.
//

import UIKit

class ViewController3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        
        titleLabel.text = "LOGIN"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor.systemBlue
        
        navigationItem.titleView = titleLabel
        navigationController?.hidesBarsOnSwipe = false
    }
    
}
