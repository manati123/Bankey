//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 13.02.2023.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView: UIStackView = .init()
    let heroImageView: UIImageView = .init()
    let titleLabel: UILabel = .init()
    
    let slideData: OnboardingSlideModel
    
    init(slideData: OnboardingSlideModel) {
        self.slideData = slideData
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - not using storyboards")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension OnboardingViewController: Styled {
    func style() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.contentMode = .scaleAspectFit
        heroImageView.image = UIImage(named: slideData.heroImageName)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 0
        titleLabel.text = slideData.titleText
    }
    
    func layout() {
        stackView.addArrangedSubview(heroImageView)
        stackView.addArrangedSubview(titleLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
        ])
    }
    
    
}
