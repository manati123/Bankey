//
//  DummyViewController.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 17.02.2023.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView: UIStackView = .init()
    let labelView: UILabel = .init()
    let logoutButton: UIButton = .init()
    weak var delegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }
    
    @objc func logoutButtonTapped(_ sender: UIButton) {
        delegate?.didLogout()
    }
}

extension DummyViewController: Styled {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.font = UIFont.preferredFont(forTextStyle: .title1)
        labelView.text = "Welcome!"
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("Logout", for: [])
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        stackView.addArrangedSubview(labelView)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
}
