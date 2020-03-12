//
//  File.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 21/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation

let defString = String(stringLiteral: "")

class Repository: Codable, CustomStringConvertible {
    var name: String?
    var language: String?
    
    var description: String {
        return """
        name = \(name ?? defString)
        language = \(language ?? defString)
        """
    }
}
