//
//  FeedViewController.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import UIKit
import SDWebImage

class FeedViewController: UICollectionViewController {
    
    private var tweets: [Tweet] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        fetchTweets()
        configureCell()
    }
    
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
    }
    
    private func configureNavigationBar() {
        
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "twitter_logo_blue")
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        middleView.addSubview(logoImageView)
        navigationItem.titleView = middleView
    
    }
    
    private func configureLeftBarButton() {
        
        guard let user = user else { return }
        
        let profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 32/2
        profileImageView.layer.masksToBounds = true
        
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    private func configureCell() {
        collectionView.register(TweetCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TweetCollectionViewCell else { return UICollectionViewCell() }
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
}
