//
//  TweetService.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 20/07/22.


import Foundation
import Firebase

struct TweetService {
    
    static let shared = TweetService()
    
    //JOGANDO OS DADOS PARA O DATABASE (FIREBASE)
    func uploadTweet(caption: String, completion: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption]
        as [String: Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    //PUXANDO OS DADOS DO DATABASE (FIREBASE) PARA UM OBJETO (TWEET)
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweets: [Tweet] = []
        
        REF_TWEETS.observeSingleEvent(of: .childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
