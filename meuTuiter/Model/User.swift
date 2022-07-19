//
//  User.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import Foundation
import UIKit

struct User {
    let email: String
    let fullname: String
    let username: String
    let profileImageURL: String
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageURL = dictionary["profileImage"] as? String ?? ""
    }
}
