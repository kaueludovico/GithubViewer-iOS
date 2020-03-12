//
//  ProfileCollectionViewCell.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 21/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation
import UIKit

class ProfileCollectionViewCell: BaseCell {
    
    var repositories: Repository? {
        didSet {
            titleRepository.text = repositories?.name
            languageRepository.text = repositories?.language
        }
    }
    
    lazy var titleRepository: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.tintColor = .black
        return label
    }()
    
    lazy var languageRepository: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .gray
        return label
    }()
    
    override func setupView() {
        setupContainer()
    }
    
    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .white
        
        addSubview(container)
        
        container.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        contentContainer(container)
    }
    
    private func contentContainer(_ view: UIView) {
        view.addSubview(titleRepository)
        view.addSubview(languageRepository)
        
        titleRepository.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 280, height: 25))
        
        languageRepository.anchor(top: titleRepository.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 100, height: 25))
    }
}
