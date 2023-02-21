//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 13.02.2023.
//

import UIKit

struct OnboardingSlideModel {
    let heroImageName: String
    let titleText: String
}

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    var currentViewController: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentViewController) else { return }
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !nextButton.isHidden
        }
    }
    
    
    let closeButton: UIButton = .init(type: .system)
    let nextButton: UIButton = .init(type: .system)
    let backButton: UIButton = .init(type: .system)
    let doneButton: UIButton = .init(type: .system)
    
    let slides: [OnboardingSlideModel] = [
        OnboardingSlideModel(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you feel like you are back in the 80s."),
        OnboardingSlideModel(heroImageName: "world", titleText: "Move your money around the world quickly and securely."),
        OnboardingSlideModel(heroImageName: "thumbs", titleText: "Learn more at www.bankey.com.")
    ]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        for slide in slides {
            pages.append(OnboardingViewController(slideData: slide))
        }
        
        currentViewController = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentViewController = pages.first!
    }
}

extension OnboardingContainerViewController: Styled {
    func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(doneButton)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 4),
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4)
        ])
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        self.currentViewController = pages[index - 1]
        return pages[index - 1]
    }
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        self.currentViewController = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentViewController) ?? 0
    }
}


//MARK: - Actions
extension OnboardingContainerViewController {
    @objc func nextTapped(_ sender: UIButton) {
        guard let nextViewController = getNextViewController(from: currentViewController) else { return }
        pageViewController.setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func backTapped(_ sender: UIButton) {
        guard let previousViewController = getPreviousViewController(from: currentViewController) else { return }
        pageViewController.setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
    }
    
    @objc func closeTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func doneTapped(_ sender: UIButton) {
        UserDefaultsService.instance.onboarded = true
        delegate?.didFinishOnboarding()
    }
}
