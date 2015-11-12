//
//  Repository.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/11/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import Foundation

class Repository {
    
    let repoName: String
    let repoSummary: String?
    let repoOwner: [String:AnyObject]
    
    init(repoName:String, repoSummary: String?, repoOwner: [String:AnyObject]) {
        self.repoName = repoName
        self.repoSummary = repoSummary
        self.repoOwner = repoOwner

    }
}

