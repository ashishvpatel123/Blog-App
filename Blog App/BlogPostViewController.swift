//
//  BlogPostViewController.swift
//  Blog App
//
//  Created by IMCS2 on 2/21/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit
import WebKit

class BlogPostViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var blogPostName : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blogName = blogPostName.replacingOccurrences(of: " ", with: "-")

        let url = URL(string: "https://codermash797.blogspot.com/2019/02/\(blogName.lowercased()).html")
        
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
        print("in second blog\(url!)")
        // Do any additional setup after loading the view.
    }
    

}
