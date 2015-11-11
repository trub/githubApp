//
//  OAuthClient.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//


let kTokenKey = "kTokenKey"

import UIKit
import Security

class OAuthClient {
    
    let kGithubURLBaseString = "https://github.com/login/oauth/authorize?"
    let kGithubURLTokenString = "https://github.com/login/oauth/access_token?"
    let kGithubClientID = "89ff9ed5a8817dbcee57"
    let kGithubClientSecret = "f5543ef09830eec4857f7a65d1c18fc00f829ccc"
    
    static let shared = OAuthClient()
    
    //MARK: request oAuth from github
    func requestOAuthFromGithub(parameterValue : String) {
        // String constructor.
        let scopeValue = "&scope=\(parameterValue)"
        let clientIDValue = "client_id=\(kGithubClientID)"
        // URL constructor.
        if let requestURL = NSURL(string: "\(kGithubURLBaseString)\(clientIDValue)\(scopeValue)") {
            UIApplication.sharedApplication().openURL(requestURL)
            print(requestURL)
        }

        
    }
    

    
    //MARK: return url from github
    func returnCodeFromGithub(url : NSURL) {
        if let codeValue = url.query{
            
            // String constructor.
            let clientIDValue = "&client_id=\(kGithubClientID)"
            let clientSecretValue = "&client_secret=\(kGithubClientSecret)"
            
            let request = NSMutableURLRequest(URL: NSURL(string: "\(kGithubURLTokenString)\(codeValue)\(clientIDValue)\(clientSecretValue)")!)
            print(request)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 && data != nil {
                        
                        do {
                            
                            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject] {
                                guard let token = rootObject["access_token"] as? String else {return}
                                
                                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: kTokenKey)
                                    NSUserDefaults.standardUserDefaults().synchronize()
                                })
                            }
                            
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
            }).resume()
        }
    }
    
    func token() -> String? {
        guard let token = NSUserDefaults.standardUserDefaults().stringForKey(kTokenKey) else {return nil}
        
        return token
    }
    
    
    
}









