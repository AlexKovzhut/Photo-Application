//
//  TitlePhotosViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class TitlePhotosViewController: UIViewController {

    var networkDataFetcher = NetworkDataFetcher()
    private var photos = [UnsplashPhoto]()
    
    private let collectionView = UICollectionView()
    private let layout = CHTCollectionViewWaterfallLayout()

    private let aboutBarButtonItem = UIBarButtonItem()
    private let spinner = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setStyle()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - UI

extension TitlePhotosViewController {
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTO GALLARY"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor.systemBlue
        navigationItem.leftBarButtonItem = aboutBarButtonItem
        aboutBarButtonItem.isEnabled = false
    }
    
    private func setStyle() {
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 1
        
        collectionView.frame = .zero
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(TitleViewCell.self, forCellWithReuseIdentifier: TitleViewCell.identifier)
        //collectionView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.allowsMultipleSelection = false
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension TitlePhotosViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension TitlePhotosViewController: UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleViewCell.identifier,
            for: indexPath
        ) as! TitleViewCell
         
        let unsplashPhoto = photos[indexPath.item]
        
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]

        return CGSize(width: view.frame.width, height: CGFloat(photo.height))
    }
}
