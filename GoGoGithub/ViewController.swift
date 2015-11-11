//
//  ViewController.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func authenticButtonPressed(sender: AnyObject) {
        print("make call to github")
        OAuthClient.shared.requestOAuthFromGithub("user")
    }

    @IBAction func printTokenButton(sender: AnyObject) {
        print(OAuthClient.shared.token())
        
    }
}

