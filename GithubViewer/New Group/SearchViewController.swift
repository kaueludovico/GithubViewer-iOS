//
//  ViewController.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 16/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import UIKit

let baseUrl = "https://api.github.com"

enum CompletionsUrl: String{
    case repository = "/repos"
    case users = "/users"
    case email = "/emails"
}

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    let client = GithubSDKCore()
    public var calledRepositories = [Repository]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.text! = "akhena1"
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        callSearch(txtSearch.text!)
        navigationToNextViewController()
    }
    
    private func navigationToNextViewController() {
        let profileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        profileViewController?.repositories = calledRepositories
        present(profileViewController!, animated: true)
    }
    
    private func callSearch(_ userName: String?) {
        let urlResquest = formatUrl(baseUrl, textField: userName!, completions: CompletionsUrl.users.rawValue, CompletionsUrl.repository.rawValue)
        
        let dataJson = client.getCallAPI(urlResquest, method: "GET", headers: ["Content-Type": "application/x-www-form-urlencoded"]) as! [[String:AnyObject]]
        
        for item in dataJson {
            let owner = Owner()
            owner.userUrl = (item["owner"]!["url"]!)! as! String
            owner.htmlUrl = (item["owner"]!["html_url"]!)! as! String
            
            let repository = Repository()
            repository.name = item["name"]!.debugDescription
            repository.language = item["language"]!.debugDescription
            repository.owner = owner
            
            calledRepositories.append(repository)
        }
    }
    
    func sharedData() -> [Repository] {
        return calledRepositories
    }
    
    private func formatUrl(_ url: String, textField: String, completions: String...) -> String {
        let formattedUrl = "\(url)\(completions[0])/\(textField)\(completions[1])"
        return formattedUrl
    }
}
