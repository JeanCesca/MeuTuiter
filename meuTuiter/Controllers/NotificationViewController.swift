//
//  NotificationViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit

class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
    }

}
