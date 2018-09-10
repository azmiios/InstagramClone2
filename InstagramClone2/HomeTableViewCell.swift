//
//  HomeTableViewCell.swift
//  InstagramClone2
//
//  Created by Ari Munandar on 06/09/18.
//  Copyright © 2018 Azmi. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var likeCountButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    
    var post: Post? {
        didSet {
            print(post?.caption)
            updateView()
        }
    }
    
    func updateView() {
        captionLabel.text = post?.caption
        profileImageView.image = UIImage(named: "photo1.jpeg")
        nameLabel.text = "Stave"
        if let photoUrlString = post?.photoUrl {
            let photoUrl = URL(string: photoUrlString)
            postImageView.sd_setImage(with: photoUrl)
    }

}
}
