//
//  AppDelegate.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 13.02.2023.
//

import UIKit
let appColor: UIColor = .systemTeal
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        
        let viewController = mainViewController
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = appColor
        window?.rootViewController = viewController
        
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate, LogoutDelegate {
    func didLogin() {
        UserDefaultsService.instance.onboarded == true ?
        changeCurrentViewController(mainViewController) : changeCurrentViewController(onboardingViewController)
    }
    
    func didLogout() {
        changeCurrentViewController(loginViewController)
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        UserDefaultsService.instance.onboarded = true
        changeCurrentViewController(loginViewController)
    }
}

extension AppDelegate {
    func changeCurrentViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
}
