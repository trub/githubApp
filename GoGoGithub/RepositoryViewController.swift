//
//  RepositoryViewController.swift
//  GoGoGithub
//
//  Created by Matthew Weintrub on 11/11/15.
//  Copyright © 2015 matthew weintrub. All rights reserved.
//

import UIKit

class RepositoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var repositories = [Repository]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadRepositories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: setup functions
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(repositories.count)

        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath:  indexPath) as UITableViewCell
//        let repository = repositories[indexPath.row]
//        cell.textLabel?.text = repository.userSummary

        
        return customCell
    }

    
    func setUpView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.redColor()
    }
    
    func loadRepositories () {
        
        GithubAPIService.fetchRepositories { (success, repositories) -> () in
            //
        }
     
    }
   
    @IBAction func postRepository(sender: AnyObject) {
    }
    
}
