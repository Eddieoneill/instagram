//
//  MainTabBarController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [firstVC, secondVC, thirdVC]
        
    }
    
    private lazy var firstVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: FeedController())
        vc.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "message.fill"), tag: 0)
        
        return vc
    }()
    
    private lazy var secondVC: UINavigationController = {
        let vc = UINavigationController(rootViewController: PostController())
        vc.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus.bubble"), tag: 1)
        
        return vc
    }()
    
    
    private lazy var thirdVC: UIViewController = {
        let vc = UINavigationController(rootViewController: ProfileController())
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)
        return vc
    }()
    
}
