//
//  AuthService.swift
//  meuTuiter
//
//  Created by Jean Ricardo Cesca on 19/07/22.
//

import Foundation
import Firebase

struct AuthService {
    
    static let shared = AuthService()
    
    //LOGANDO O USUÁRIO
    func logUserIn(withEmail email: String, password: String, handler: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    //REGISTRANDO O USUÁRIO
    func registerUser(credentials: AuthData, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username

        //Cria-se o nome da referência onde será armazenada a Imagem.
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        //transformando a imagem em Data, a fim de manipulá-la
        guard let imageData = credentials.profileImageURL.jpegData(compressionQuality: 0.3) else { return }
        
        //adiciona a imagem ao banco de imagens do Firebase (Storage)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { url, error in
                guard let profileImageURL = url?.absoluteString else { return }
                
                //Autentificação do usuário (email e senha)
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        print("Error is \(error.localizedDescription)")
                        return
                    }
                    guard let userUID = result?.user.uid else { return }
                    
                    let values = ["email": email,
                                  "username": username,
                                  "fullname": fullname,
                                  "profileImageURL": profileImageURL]
                    
                    REF_USERS.child(userUID).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
}

