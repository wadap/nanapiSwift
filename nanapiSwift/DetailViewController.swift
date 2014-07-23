//
//  DetailViewController.swift
//  nanapiSwift
//
//  Created by shuichi.wada on 2014/07/18.
//  Copyright (c) 2014年 shuichi.wada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var url :NSString?
    var page_title :NSString?
    var webview: UIWebView = UIWebView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webview.frame = self.view.bounds
        self.webview.delegate = self
        self.view.addSubview(self.webview)
        
        let recipeURL: NSURL = NSURL.URLWithString(self.url)
        let urlRequest: NSURLRequest = NSURLRequest(URL: recipeURL)

        self.title = self.page_title
        self.webview.loadRequest(urlRequest)
    }
    
    func webView(webView: UIWebView!, shouldStartLoadWithRequest request: NSURLRequest!, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

