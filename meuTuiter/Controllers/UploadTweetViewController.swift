//
//  UploadTweetViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 20/07/22.
//

import UIKit

class UploadTweetViewController: UIViewController {
    
    private var user: User
    
    private let tweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "twittercolor")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.frame = .init(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 32/2
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 48/2
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "What's happening?"
        textView.textColor = UIColor.lightGray
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    private func configureConstraints() {
        
        let profileImageViewConstraints = [
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        let textViewConstraints = [
            textView.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(textViewConstraints)
    }
    
    private func actions() {
        tweetButton.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = textView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, reference in
            if let error = error {
                print("Failed to upload tweet with error \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI(){
        configureNavigationBar()
        actions()
        
        textView.delegate = self
        
        view.addSubview(profileImageView)
        view.addSubview(textView)
        configureConstraints()
        
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
    }
    
    private func configureNavigationBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }

}

extension UploadTweetViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's happening?"
            textView.textColor = UIColor.lightGray
        }
    }
}
