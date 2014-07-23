//
//  MasterViewController.swift
//  nanapiSwift
//
//  Created by shuichi.wada on 2014/07/18.
//  Copyright (c) 2014年 shuichi.wada. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var recipes = NSMutableArray()
    let api_url: String = "http://api.nanapi.jp/v1/recipeSearchDetails/?key=4b542e23e43f6&format=json"


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let recipe = recipes[indexPath.row] as NSDictionary
        cell.textLabel.text       = recipe["title"] as NSString
        cell.detailTextLabel.text = recipe["body"]  as NSString

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "showDetail") {
            let detailViewController :DetailViewController = segue.destinationViewController as DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let recipe = recipes[indexPath.row] as NSDictionary
            detailViewController.url         = recipe["url"] as NSString!
            detailViewController.page_title  = recipe["title"] as NSString!
        }
    }
    
    func fetchAPI() -> Void{
        let data: NSData = self.getJSON(self.api_url)
        let result: NSDictionary = self.parseJSON(data)
        let api_result_tmp: NSDictionary   = result["response"] as NSDictionary
        self.recipes = api_result_tmp["recipes"] as NSMutableArray
    }
    
    func getJSON(urlToRequest: String) -> NSData {
        return NSData(contentsOfURL: NSURL(string: urlToRequest))
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary {
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        return boardsDictionary
    }
    
}

