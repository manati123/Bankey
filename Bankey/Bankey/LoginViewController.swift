//
//  LoginViewController.swift
//  Bankey
//
//  Created by Preoteasa Ioan-Silviu on 13.02.2023.
//

import UIKit

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView: LoginView = .init()
    let titleAndSubtitleView: TitleAndSubtitleView = .init()
    
    weak var delegate: LoginViewControllerDelegate?
    
    let bottomStackView: UIStackView = .init()
    let signInButton: UIButton = .init(type: .system)
    let errorLabel: UILabel = .init()
    let activityIndicatorView: UIActivityIndicatorView = .init(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}


extension LoginViewController: Styled {
    
    func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textAlignment = .center
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.isHidden = true
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 8
        
        titleAndSubtitleView.translatesAutoresizingMaskIntoConstraints = false
        titleAndSubtitleView.titleLabel.text = "Bankey"
        titleAndSubtitleView.subtitleLabel.text = "Your premium source for all things banking!"
    }
    
    func layout() {
        view.addSubview(titleAndSubtitleView)
        view.addSubview(bottomStackView)
        view.addSubview(signInButton)
        
//        bottomStackView.addArrangedSubview(titleAndSubtitleView)
        bottomStackView.addArrangedSubview(loginView)
        bottomStackView.addArrangedSubview(signInButton)
        bottomStackView.addArrangedSubview(errorLabel)
        bottomStackView.addArrangedSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            titleAndSubtitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            titleAndSubtitleView.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -20),
            titleAndSubtitleView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: titleAndSubtitleView.trailingAnchor, multiplier: 1),
            bottomStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1),
            bottomStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: bottomStackView.trailingAnchor, multiplier: 1)
        ])
    }
}

//MARK: - Actions
extension LoginViewController {
    @objc
    func signInTapped() {
        login()
    }
    
    private func login() {
        activityIndicatorView.startAnimating()
        signInButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if self?.loginView.validateTextFieldsNotEmpty() == false {
                self?.errorLabel.text = "Username / password cannot be blank!"
                self?.errorLabel.isHidden = false
            } else {
                self?.errorLabel.isHidden = true
                self?.delegate?.didLogin()
                self?.loginView.emptyFields()
            }
            self?.signInButton.isEnabled = true
            self?.activityIndicatorView.stopAnimating()
        }
    }
}
