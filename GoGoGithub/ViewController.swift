//
//  ViewController.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import UIKit
import Security

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myToken = KeychainService.loadFromKeychain()
        print(myToken)
        
        //Get respositiories from github
        GithubService.GETRepositories { (success, json) -> () in
            print(json)
        }
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    func setupAppearance() {
        self.loginButton.layer.cornerRadius = 5.0

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    

    @IBAction func authenticButtonPressed(sender: AnyObject) {
        OAuthClient.shared.requestOAuthFromGithub("user,repo")
    }

    @IBAction func printTokenButton(sender: AnyObject) {
        print(OAuthClient.shared.token())
        
        
    }
}

