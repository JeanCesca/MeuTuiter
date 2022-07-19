//
//  FeedViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    var user: User? {
        didSet {
            print("Did set user in feed controller")
        }
    }
    
    private func configureNavigationBar() {
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitter_logo_blue")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
        
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        profileImageView.backgroundColor = .red
        profileImageView.layer.cornerRadius = 32/2
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
}
