//
//  ProfileViewController.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 16/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var client = GithubSDKCore()
    let cellId = "cellId"
    var avatarUrl = String()
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var repositories: [Repository]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRepository()
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backAction(_ sender: UIBarButtonItem) {
        self.repositories? = []
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setRepository() {
        self.repositories = repositoryArray
        getRepositories()
    }
    
    private func getRepositories() {
        let parseJson = client.getRequestInfosUser(userUrl)
        let user = User()
        user.name = parseJson["name"] as! String
        user.avatar = parseJson["avatar_url"] as! String
        
        setupUserData(user.name, user.avatar)
    }
    
    private func setupUserData(_ name: String,_ avatarUrl: String) {
        lblName.text! = name
        imgProfile.downloaded(from: avatarUrl)
        imgProfile.roundedImage()
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = repositories?.count {
            return count
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProfileCollectionViewCell
        
        if let repository = repositories?[indexPath.item] {
            cell.repository = repository
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}
