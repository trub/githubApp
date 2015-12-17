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
    
    class func fetchRepositories(completion: (success: Bool, repositories: [Repository]?) -> ()) {
        if let token = OAuthClient.shared.token() {
            if let url = NSURL(string: "https://api.github.com/user/repos?access_token=\(token)") {
                
                let request = NSMutableURLRequest(URL: url)
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    
                    if let error = error {
                        print(error)
                    }
                    
                    if let data = data {
                        do {
                            
                            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [[String : AnyObject]] {
                                
                                var repositories = [Repository]()
                                
                                for repo in json {
                                    
                                    
                                    if let repo = self.repositoriesFromJSON(repo) {
                                        repositories.append(repo)
                                    }
                                    
                                    
                                }
                                
                                completion(success: true, repositories: repositories)
                                
                                
                            }
                            
                            
                        } catch let error {
                            print(error)
                        }
                    }
                    
                }).resume()
            }
        }
    }
    
    
    private class func repositoriesFromJSON(json: [String:AnyObject]) -> Repository? {
        if let repoName = json["name"] as? String, repoSummary = json["description"] as? String, repoOwner = json["owner"] as? [String: AnyObject] {
            return Repository(repoName: repoName, repoSummary: repoSummary, repoOwner: repoOwner)
        }
        
        return nil
    }
    
    class func searchWithTerm(term: String, completion: (success: Bool, json: [AnyObject]) -> ()) {
        
        // This is the official URL, use it. This will work.
        // https://api.github.com/search/repositories?q=term
        
    }
    
    
    
    //MARK: POST Request functions

}