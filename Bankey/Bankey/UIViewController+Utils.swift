//
//  UIViewController+Utils.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = appColor
        UINavigationBar().standardAppearance = appearance;
        UINavigationBar().scrollEdgeAppearance = UINavigationBar().standardAppearance
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
