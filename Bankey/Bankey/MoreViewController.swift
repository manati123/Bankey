//
//  MoreViewController.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class MoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension MoreViewController: Styled {
    func style() {
        view.backgroundColor = .blue
    }
    
    func layout() {
        
    }
}

