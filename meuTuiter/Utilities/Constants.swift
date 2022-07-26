//
//  Constants.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import Foundation
import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_TWEETS = DB_REF.child("tweets")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let reuseIdentifier = "TweetCell"

