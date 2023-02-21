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
    let loginViewControllerContainer = LoginViewController()
    let onboardingViewControllerContainer = OnboardingContainerViewController()
    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewControllerContainer.delegate = self
        onboardingViewControllerContainer.delegate = self
        dummyViewController.delegate = self
        window?.rootViewController = AccountSummaryViewController()
        
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate, LogoutDelegate {
    func didLogin() {
        UserDefaultsService.instance.onboarded == true ?
        changeCurrentViewController(dummyViewController) : changeCurrentViewController(onboardingViewControllerContainer)
    }
    
    func didLogout() {
        changeCurrentViewController(loginViewControllerContainer)
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        changeCurrentViewController(dummyViewController)
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
