//
//  OAuthClient.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//



import UIKit
import Security

class OAuthClient {
    
    static let shared = OAuthClient()
    
    //MARK: request oAuth from github
    func requestOAuthFromGithub(parameterValue : String) {
        let scopeValue = "&scope=\(parameterValue)"
        let clientIDValue = "client_id=\(kGithubClientID)"
        
        if let requestURL = NSURL(string: "\(kGithubURLBaseString)\(clientIDValue)\(scopeValue)") {
            UIApplication.sharedApplication().openURL(requestURL)
            print(requestURL)
        }

        
    }
    
    //MARK: return url from github
    func returnCodeFromGithub(url : NSURL, completion: () -> ()) {
        if let codeValue = url.query{
            let clientIDValue = "&client_id=\(kGithubClientID)"
            let clientSecretValue = "&client_secret=\(kGithubClientSecret)"
            
            let request = NSMutableURLRequest(URL: NSURL(string: "\(kGithubURLTokenString)\(codeValue)\(clientIDValue)\(clientSecretValue)")!)
        
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 && data != nil {
                        
                        do {
                            
                            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject] {
                                guard let token = rootObject["access_token"] as? String else {return}
                                
                                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                    KeychainService.save(token)
                                    completion()
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
        guard let token = KeychainService.loadFromKeychain() else {return nil}
        return token as String
    }
    
    
    
}









