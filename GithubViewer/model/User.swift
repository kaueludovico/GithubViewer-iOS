//
//  User.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 21/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation

struct User: Codable, CustomStringConvertible {
    var name: String?
    var avatarUrl: String?
    var reposUrl: String?
    
    var description: String {
        return """
        name = \(name ?? defString)
        avatar = \(avatarUrl ?? defString)
        repository = \(reposUrl ?? defString)
        """
    }
}
