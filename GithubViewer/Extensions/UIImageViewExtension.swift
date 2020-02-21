//
//  UIImageViewExtension.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 20/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func roundedImage() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
}

