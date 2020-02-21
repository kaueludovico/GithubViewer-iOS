//
//  GithubSDKCore.swift
//  GithubViewer
//
//  Created by Kaue Ludovico on 21/02/2020.
//  Copyright © 2020 Kaue Ludovico. All rights reserved.
//

import Foundation

class GithubSDKCore: NSObject {
    
    func getCallAPI(_ url: String?, method: String?, headers: [String:String]?) -> Any {
        let semaphore = DispatchSemaphore (value: 0)
        var request = URLRequest(url: URL(string: url!)!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        var json: Any!
        
        let task = session.dataTask(with: request) { (data, response, error) in
            do {
                let parseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                json = parseJson
            } catch {
                print(error)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return json
    }
}
