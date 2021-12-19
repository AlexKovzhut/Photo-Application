//
//  TitlePhotosViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ViewController1: UIViewController {
    var networker = NetworkService.shared
    var photos = [PhotoData]()
     
    private let backgroundView = UIView()
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumInteritemSpacing = 1.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCell1.self, forCellWithReuseIdentifier: CollectionCell1.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupNavigationBar()
        setStyle()
        
        networker.fetchPhotos(query: "Popular") { [weak self] photos, error in
            if let error = error {
                print("error = ", error)
                return
            }
            
            self?.photos = photos!
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLayout()
    }
    
    @objc private func aboutPhotoGallaryButtonPressed() {
        let aboutVC = AboutViewController()
        aboutVC.modalPresentationStyle = .pageSheet
        aboutVC.modalTransitionStyle = .coverVertical
        present(aboutVC, animated: true, completion: nil)
    }
    
    @objc private func didPressedPhoto() {
        let photoVC = PhotoViewController()
        navigationController?.pushViewController(photoVC, animated: true)
    }
}

//MARK: - Configure UI

extension ViewController1 {
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(aboutPhotoGallaryButtonPressed))
        
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
        print("Did Select")
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
        
        let photo = photos[indexPath.row]
        
        cell.label.text = photo.user.name
        cell.button.addTarget(self, action: #selector(didPressedPhoto), for: .touchUpInside)
        
        networker.image(photo: photo) { data, error in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...2) ) {
                    cell.imageView.image = image
                }
            }
        }

        return cell
    }
}

// MARK: - CHTCollectionViewDelegateWaterfallLayout

extension ViewController1: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth = photos[indexPath.row].width
            let itemHeight = photos[indexPath.row].height
            return CGSize(width: itemWidth, height: itemHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, columnCountFor section: Int) -> Int {
            return 1
        }
}
