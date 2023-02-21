//
//  MoveMoneyViewController.swift
//  Bankey
//
//  Created by Silviu Preoteasa on 21.02.2023.
//

import UIKit

class MoveMoneyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
}

extension MoveMoneyViewController: Styled {
    func style() {
        view.backgroundColor = .yellow
    }
    
    func layout() {
        
    }
}
