//
//  ViewController.swift
//  movies
//
//  Created by grace kim  on 2022/10/08.
//

import UIKit

import UIKit


class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    //for creating animations: //https://betterprogramming.pub/how-to-build-an-animated-custom-tab-bar-for-ios-application-5eb3a72e07a8
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        self.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.25)
        self.view.layer.cornerRadius = 30
        
        // Create Tab one
        let tab1 = UINavigationController(rootViewController: HomeViewController())
        let tab2 = UINavigationController(rootViewController: FavoritesViewController())
        
        
        let tab1_BarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house"), selectedImage:  UIImage(systemName: "house.fill"))
        
        tab1.tabBarItem = tab1_BarItem
        tab1.tabBarItem.badgeColor = .white
        
       
        let tab2_BarItem = UITabBarItem(title: "Favs", image: UIImage(systemName: "heart"), selectedImage:  UIImage(systemName: "heart.fill"))
        
        tab2.tabBarItem = tab2_BarItem
        tab2.tabBarItem.badgeColor = .white
        
        self.viewControllers = [tab1, tab2]
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        //print("Selected \(viewController.title!)")
    }
}
