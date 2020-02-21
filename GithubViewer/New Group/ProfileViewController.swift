//
//  ProfileViewController.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 21/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let cellId = "cellId"
    var search = SearchViewController()
    var repositories: [Repository]?
    let client = GithubSDKCore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callUser(repositories!)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        imgProfile.roundedImage()
    }
    
    private func callUser(_ data: [Repository]) {
        var urlUser = String()
        for item in data {
            urlUser = item.owner.userUrl
        }
        let dataJson = client.getCallAPI(urlUser, method: "GET", headers: ["Content-Type": "application/x-www-form-urlencoded"]) as! [String:AnyObject]
        
        lblName.text! = dataJson["name"] as! String
        imgProfile.downloaded(from: dataJson["avatar_url"] as! String)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = repositories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCollectionViewCell
        
        if let repository = repositories?[indexPath.item] {
            cell.repositories = repository
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
}
