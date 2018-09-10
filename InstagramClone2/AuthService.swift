//
//  AuthService.swift
//  InstagramClone2
//
//  Created by Ari Munandar on 29/08/18.
//  Copyright © 2018 Azmi. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class AuthService {

    static func signIn(email: String, password: String, onSuccsesc: @escaping () -> Void, onError: @escaping (_ errorMassege: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccsesc()
        }

    }
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccsesc: @escaping () -> Void, onError: @escaping (_ errorMassege: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error: Error?) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            let uid = user?.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid!)
            
                storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
                    if error != nil {
                        return
                    }
                    let profileImageUrl = metaData?.downloadURL()?.absoluteString
                    
                    self.setUserInformation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid!, onSuccsesc: onSuccsesc)
                })
        }
        
    }
    
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccsesc: @escaping () -> Void) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users")
        let newUserReference = usersReference.child(uid)
        newUserReference.setValue(["username": username, "email": email, "profileImageUrl": profileImageUrl])
        onSuccsesc()
    }
}

