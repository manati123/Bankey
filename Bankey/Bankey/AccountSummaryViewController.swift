//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension AccountSummaryViewController: Styled {
    func style() {
        view.backgroundColor = .red
    }
    
    func layout() {
        
    }
}
