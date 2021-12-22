//
//  PhotoViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 14.12.2021.
//

import UIKit

class PhotoViewController: UIViewController {
    
    let imageView = UIImageView()
    let activityindicatorView = UIActivityIndicatorView()
    
    var networker = NetworkService.shared
    
    private var image: UIImage? {
        didSet {
            imageView.image = image
            activityindicatorView.stopAnimating()
            activityindicatorView.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setStyle()
        setLayout()
        downloadData()
    }
    
    deinit {
        print("Controller Dismissed")
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
        
        activityindicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityindicatorView.isHidden = false
    }
    
    private func setLayout() {
        view.addSubview(imageView)
        view.addSubview(activityindicatorView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 3),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 6),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activityindicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityindicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func downloadData() {
    }
}
