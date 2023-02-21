//
//  MainViewController.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        //here we are setting up the view controllers
        let summaryViewController = AccountSummaryViewController()
        let moveMoneyViewController = MoveMoneyViewController()
        let moreViewController = MoreViewController()
        
        summaryViewController.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moveMoneyViewController.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreViewController.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        let summaryNavigationController = UINavigationController(rootViewController: summaryViewController)
        let moveMoneyNavigationController = UINavigationController(rootViewController: moveMoneyViewController)
        let moreNavigationController = UINavigationController(rootViewController: moreViewController)
        
        summaryNavigationController.navigationBar.barTintColor = appColor
        hideNavigationBarLine(summaryNavigationController.navigationBar)
        
        let tabBarList = [summaryNavigationController, moveMoneyNavigationController, moreNavigationController]
        
        viewControllers = tabBarList
    }
    
    func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
    }
    
    private func setupTabBar() {
        tabBar.tintColor = appColor
        tabBar.isTranslucent = false
    }
}
