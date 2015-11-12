//
//  GithubAPIService.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/10/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import Foundation
import Security


class GithubAPIService {
    

    //MARK: GET Request functions
    class func fetchRepositories(completion: (success: Bool, json: [[String:AnyObject]]?) -> ()) {
        do {
            guard let token = OAuthClient.shared.token() else {
                return completion(success: false, json: nil)
            }
            print("found...\(token)")
            
            guard let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") else {
                return completion(success: false, json: nil)
            }
            
            let request = NSMutableURLRequest(URL: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    print(error)
                    return completion(success: false, json: nil)
                }
                if let data = data {
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
                        print(json)
                        guard let result = json as? [[String:AnyObject]] else {
                            return completion(success: false, json: nil)
                        }
                        return completion(success: true, json: result )
                        
                    } catch _ {
                        return completion(success: false, json: nil)
                    }
                } else {
                    return completion(success: false, json: nil)

                    
                }
            }).resume()
        }
        
    }
    
    
    class func searchWithTerm(term: String, completion: (success: Bool, json: [AnyObject]) -> ()) {
        
        // This is the official URL, use it. This will work.
        // https://api.github.com/search/repositories?q=term
        
    }
    
    
    
    //MARK: POST Request functions

}