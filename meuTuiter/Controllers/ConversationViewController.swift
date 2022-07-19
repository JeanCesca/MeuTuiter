//
//  ConversationViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        configureNavigationBar()

    }
    
    private func configureNavigationBar() {
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }

}

