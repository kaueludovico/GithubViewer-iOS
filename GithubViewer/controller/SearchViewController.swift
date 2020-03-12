//
//  ViewController.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 16/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import UIKit

let baseUrl = "https://api.github.com/"

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    let rest = RestManager()
    public var calledRepositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.text = "kaueludovico"
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        callSearch(txtSearch.text ?? defString)
    }
    
    private func navigationToNextViewController(_ paramsUser: User) {
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        profileViewController?.userData = paramsUser
        present(profileViewController!, animated: true)
    }
    
    private func callSearch(_ userName: String) {
        guard let url = URL(string: "\(baseUrl)users/\(userName)") else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { (results) in
            if let data = results.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(User.self, from: data) else { return }
                DispatchQueue.main.async(execute: {
                    self.navigationToNextViewController(userData)
                })
            }
        }
    }
}
