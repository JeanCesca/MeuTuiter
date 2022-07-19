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
    
    func fetchUser(completion: @escaping(User) -> Void) {
        //Puxando o ID do usuário do Database (O ID contém todas as infos)
        guard let user_UID = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(user_UID).observeSingleEvent(of: .value) { snapshot in
            //Snapshot contém todas as infos. Transformando a 'data' dele em dicionário
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: user_UID, dictionary: dictionary)
            completion(user)
            
        }
    }
}
