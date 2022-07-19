//
//  ExploreViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit

class ExploreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemYellow
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }

}
