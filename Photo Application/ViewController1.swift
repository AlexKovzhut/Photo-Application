//
//  TitlePhotosViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import SDWebImage

class ViewController1: UIViewController {
    var networkService = NetworkService()
    var photos = [PhotoModel]()
    
    private let backgroundView = UIView()
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCell1.self, forCellWithReuseIdentifier: CollectionCell1.identifier)
        
        return collectionView
    }()
    
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
    
    @objc private func barButtonPressed() {
            
    }
}

//MARK: - Configure UI

extension ViewController1 {
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        networkService.delegate = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(barButtonPressed))
        
        titleLabel.text = "PHOTO GALLERY"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor.white
        
        barButtonItem.tintColor = .white
        
        navigationItem.leftBarButtonItem = barButtonItem
        navigationItem.titleView = titleLabel
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .black
    }
    
    private func setStyle() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
        ])
    }
}

//MARK: - UICollectionViewDelegate

extension ViewController1: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController1: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell1.identifier, for: indexPath) as? CollectionCell1 else { fatalError() }

        cell.imageView.image = UIImage(systemName: photos[indexPath.row].url)
        cell.label.text = photos[indexPath.row].author

        return cell
    }
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension ViewController1: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.height/2)
    }
}

//

extension ViewController1: PhotoServiceDelegate {
    func didFetchModel(_ service: NetworkService, _ model: PhotoModel) {
        
    }
    
    func didFailWithError(_ service: NetworkService, _ error: ServiceError) {
        let message: String

        switch error {
        case .network(statusCode: let statusCode):
            message = "Networking error. Status code: \(statusCode)"
        case .parsing:
            message = "JSON data could not be parsed"
        case .general(reason: let reason):
            message = reason
        }
        showErrorAlert(with: message)
    }
    

    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error fetching data", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
