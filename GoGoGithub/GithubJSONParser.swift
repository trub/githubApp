//
//  GithubJSONParser.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/11/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import UIKit


class GithubJSONParser {
 
    class func parseRepositories(completion: (success: Bool, repositories: [Repository]?) -> ()) {
    
//        GithubAPIService.fetchRepositories { (success, json) -> () in
//            var repositories = [Repository]()
//            for userRepository in json {
//                if let
//                    repoName = userRepository["repoName"] as? String,
//                    repoSummary = userRepository["repoSummary"] as? String,
//                    repoOwner = userRepository["repoOwner"] as? [String: AnyObject]
//                {
//                    let repository = Repository(repoName: repoName, repoSummary: repoSummary, repoOwner: repoOwner)
//                    repositories.append(repository)
//                }
//            }
//            print(repositories)
//            completion(success: true, repositories: repositories)
//        }
    }
}



