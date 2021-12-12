//
//  SearchPhotosViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ViewController2: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CollectionCell1.self, forCellWithReuseIdentifier: CollectionCell1.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupNavigationBar()
        setStyle()
        setLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLayout()
    }
    
    private func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationController?.hidesBarsOnSwipe = false
        
    }
}

//MARK: - Configure UI

extension ViewController2 {
    private func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setStyle() {
        
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

//MARK: - UISearchBarDelegate

extension ViewController2: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

//MARK: - UICollectionViewDelegate

extension ViewController2: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

// MARK: - UICollectionViewDataSource

extension ViewController2: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell1.identifier, for: indexPath) as? CollectionCell1 else { fatalError() }
        
        return cell
    }
}

//MARK: - CHTCollectionViewDelegateWaterfallLayout

extension ViewController2: CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.height/2)
    }
}
