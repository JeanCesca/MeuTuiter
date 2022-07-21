//
//  TweetCollectionViewCell.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 20/07/22.
//

import UIKit

class TweetCollectionViewCell: UICollectionViewCell {
    
    var tweet: Tweet? {
        didSet { configure () }
    }
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 48/2
        imageView.backgroundColor = .blue
        
        return imageView
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Jean Cesca"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Digitar o tweet Digitar o tweet"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let replyButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let retweetButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let likeButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    private let shareButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()

    private func configureConstraints() {
        
        let profileImageViewConstraints = [
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.widthAnchor.constraint(equalToConstant: 48),
            profileImageView.heightAnchor.constraint(equalToConstant: 48)
        ]
        
        let userLabelConstraints = [
            userLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            userLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        ]

        let textLabelConstraints = [
            textLabel.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 4),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ]
        
        let replyButtonConstraints = [
            replyButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 12),
            replyButton.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
        ]
        
        let retweetButtonConstraints = [
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: 55),
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor)
        ]
        
        let likeButtonConstraints = [
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: 55),
            likeButton.centerYAnchor.constraint(equalTo: retweetButton.centerYAnchor)
        ]
        
        let shareButtonConstraints = [
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 55),
            shareButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(profileImageViewConstraints)
        NSLayoutConstraint.activate(textLabelConstraints)
        NSLayoutConstraint.activate(userLabelConstraints)
        
        NSLayoutConstraint.activate(replyButtonConstraints)
        NSLayoutConstraint.activate(retweetButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
    }
    
    private func actions() {
        replyButton.addTarget(self, action: #selector(handleReplyButton), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(handleRetweetButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
    }
    
    @objc func handleReplyButton() {
        
    }
    
    @objc func handleRetweetButton() {
        
    }
    
    @objc func handleLikeButton() {
        
    }
    
    @objc func handleShareButton() {
        
    }
    
    func configure() {
        guard let tweet = tweet else { return }
        
        DispatchQueue.main.async {
            self.profileImageView.sd_setImage(with: tweet.user.profileImageURL)
            self.textLabel.text = tweet.caption
            self.userLabel.text = tweet.user.username
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        addSubview(textLabel)
        addSubview(userLabel)
        
        addSubview(replyButton)
        addSubview(retweetButton)
        addSubview(likeButton)
        addSubview(shareButton)
        
        configureConstraints()
        configure()
        actions()
    
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
