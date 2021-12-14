//
//  PhotoViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 14.12.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setStyle()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLayout()
    }
}

//MARK: - Configure UI

extension PhotoViewController {
    private func setup() {
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setStyle() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 3),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 6),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
