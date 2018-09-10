//
//  Post.swift
//  InstagramClone2
//
//  Created by Ari Munandar on 04/09/18.
//  Copyright © 2018 Azmi. All rights reserved.
//

import Foundation
class Post {
    var caption: String?
    var photoUrl: String?
    var uid: String?
}

extension Post {
    static func transformPostPhoto(dict: [String: Any]) -> Post {
        let post = Post()
        
        post.caption = dict["caption"] as? String
        post.photoUrl = dict["photoUrl"] as? String
        return post
    }
    static func transformPostVideo() {
        
    }
}















