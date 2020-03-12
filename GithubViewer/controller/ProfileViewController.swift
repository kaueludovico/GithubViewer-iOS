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
    var userData = User()
    var rest = RestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        imgProfile.roundedImage()
        setupData()
    }
    
    private func setupData() {
        if let name = userData.name, let avatar = userData.avatarUrl {
            lblName.text = name
            imgProfile.downloaded(from: avatar)
        }
        callRepositories(userData)
    }
    
    private func callRepositories(_ userData: User) {
        guard let url = URL(string: userData.reposUrl ?? defString) else { return }
        var repository = [Repository]()
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let reposData = try? decoder.decode(Array<Repository>.self, from: data) else { return }
                for repos in reposData {
                    repository.append(repos)
                }
                self.repositories = repository
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            }
        }
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
