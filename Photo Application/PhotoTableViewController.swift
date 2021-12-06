//
//  PhotoTableViewController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonPressed))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(ActionBarButtonPressed))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        setupSearchBar()
    }
    
    // MARK: - NavigationItems action
    
    @objc private func addBarButtonPressed() {
        
    }
    
    @objc private func ActionBarButtonPressed() {
        
    }
    
    // MARK: - Setup UI Elements
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "PHOTO TABLE"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textColor = UIColor.systemBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        
        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource and UIViewCollectionDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension PhotoTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
