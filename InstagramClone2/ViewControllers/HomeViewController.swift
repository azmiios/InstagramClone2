//
//  HomeViewController.swift
//  InstagramClone2
//
//  Created by Ari Munandar on 24/08/18.
//  Copyright © 2018 Azmi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 521
        
        tableView.dataSource = self
        loadPosts()
    }
    
    func loadPosts() {
    Database.database().reference().child("posts").observe(.childAdded) { (snapshot: DataSnapshot) in
        print(Thread.isMainThread)
        if let dict = snapshot.value as? [String: Any] {
            let newPost = Post.transformPostPhoto(dict: dict)
            self.posts.append(newPost)
            self.tableView.reloadData()
            }
        }
    }
    @IBAction func logout_TouchUpInside(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let sigInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(sigInVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        //return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! HomeTableViewCell
        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
        }
    }



















