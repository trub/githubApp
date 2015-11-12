//
//  AppDelegate.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/9/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginViewController: ViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        checkForToken()
        return true
    }

    
    func checkForToken() {
        if let _ = KeychainService.loadFromKeychain(){
            print("I have token")
            return
        } else {
            presentViewController()
        }
    }
    
    func presentViewController() {
        if let repositoryViewController = self.window?.rootViewController as? RepositoryViewController, storyboard = repositoryViewController.storyboard {
            if let viewController = storyboard.instantiateViewControllerWithIdentifier(kViewControllerValue) as? ViewController {
                repositoryViewController.addChildViewController(viewController)
                repositoryViewController.view.addSubview(viewController.view)
                viewController.didMoveToParentViewController(repositoryViewController)
                self.loginViewController = viewController
            }
        }
    
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        OAuthClient.shared.returnCodeFromGithub(url) { () -> () in
            guard let loginViewController = self.loginViewController else {return}
            loginViewController.view.removeFromSuperview()
            loginViewController.removeFromParentViewController()
        }
        return true
    }
    

   
}

