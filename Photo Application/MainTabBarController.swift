//
//  MainTabBarController.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 06.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoCollectionVC = PhotoCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let photoTableVC = PhotoTableViewController()
        
        viewControllers = [
            createNavigationController(
                rootViewController: photoCollectionVC,
                title: "Collection",
                image: UIImage(systemName: "photo.on.rectangle")!,
                selectedImage: UIImage(systemName: "photo.on.rectangle.fill")!
            ),
            createNavigationController(
                rootViewController: photoTableVC,
                title: "Table",
                image: UIImage(systemName: "text.below.photo")!,
                selectedImage: UIImage(systemName: "text.below.photo.fill")!
            )
        ]
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.selectedImage = selectedImage
        
        return navigationVC
    }
}
