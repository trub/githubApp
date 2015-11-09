//
//  OAuthClient.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

let kGithubURLBaseString = "https://github.com/login/oauth/authorize?"

import UIKit

class OAuthClient {
    
    let githubClientID = "89ff9ed5a8817dbcee57"
    let githubClientSecret = "f5543ef09830eec4857f7a65d1c18fc00f829ccc"
    
    static let shared = OAuthClient()
    
    func requestOAuthFromGithub(parameterValue : String) {
        
        // String constructor.
        let scopeValue = "&scope=\(parameterValue)"
        let clientIDValue = "client_id=\(self.githubClientID)"
        // URL constructor.
        if let requestURL = NSURL(string: "\(kGithubURLBaseString)\(clientIDValue)\(scopeValue)") {
            UIApplication.sharedApplication().openURL(requestURL)
            print(requestURL)
        }
        
    }
    
}


