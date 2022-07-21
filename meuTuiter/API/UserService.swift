//
//  UserService.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import Foundation
import Firebase

struct UserService {
    static let shared = UserService()

    func fetchUser(uid: String, completion: @escaping(User) -> Void) {

        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            //Snapshot contém todas as infos. Transformando a 'data' dele em dicionário
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

            let user = User(uid: uid, dictionary: dictionary)

            completion(user)
        }
    }
}
