//
//  MainTabControllerViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {

    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedViewController else { return }
            feed.user = user
        }
    }
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .systemCyan
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        return button
        
    }()
    
    private func configureConstraints() {
        let plusButtonConstraints = [
            plusButton.heightAnchor.constraint(equalToConstant: 56),
            plusButton.widthAnchor.constraint(equalToConstant: 56),
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        NSLayoutConstraint.activate(plusButtonConstraints)
    }
    
    private func actions() {
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc func plusButtonTapped() {
        print("Nice")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(plusButton)
        
        authenticateUser()
//        logUserOut()
    }
    
    func fetchUser() {
        UserService.shared.fetchUser { user in
            self.user = user
        }
    }

    func configureViewControllers() {
        
        let vc1 = UINavigationController(rootViewController: FeedViewController())
        let vc2 = UINavigationController(rootViewController: ExploreViewController())
        let vc3 = UINavigationController(rootViewController: NotificationViewController())
        let vc4 = UINavigationController(rootViewController: ConversationViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        vc3.tabBarItem.image = UIImage(systemName: "bell")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        
        vc4.tabBarItem.image = UIImage(systemName: "envelope")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser == nil { //if user is not logged in:
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginViewController())
                nav.modalPresentationStyle = .overFullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureConstraints()
            actions()
        }
    }

    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Failed to sign out. Erro: \(error.localizedDescription)")
        }
    }
}
