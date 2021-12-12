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
        
        let firstVC = ViewController1()
        let secondVC = ViewController2()
        let thirdVC = ViewController3()
        
        viewControllers = [
            createNavigationController(
                rootViewController: firstVC,
                title: "Title",
                image: UIImage(systemName: "photo.circle")!,
                selectedImage: UIImage(systemName: "photo.circle.fill")!
            ),
            createNavigationController(
                rootViewController: secondVC,
                title: "Search",
                image: UIImage(systemName: "magnifyingglass.circle")!,
                selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!
            ),
            createNavigationController(
                rootViewController: thirdVC,
                title: "User",
                image: UIImage(systemName: "person.crop.circle")!,
                selectedImage: UIImage(systemName: "person.crop.circle.fill")!
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
