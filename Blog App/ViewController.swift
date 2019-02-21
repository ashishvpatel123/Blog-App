//
//  ViewController.swift
//  Blog App
//
//  Created by IMCS2 on 2/21/19.
//  Copyright © 2019 IMCS2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    

}


extension ViewController : UITableViewDelegate,UITableViewDataSource   {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogCell")!
        
        cell.textLabel?.text = "Ashish"
        cell.detailTextLabel?.text = "sub details"
        
        return cell
    }
    
    
}
