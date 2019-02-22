//
//  ViewController.swift
//  Blog App
// AIzaSyCR6Mjdcgu7MP_qOQWrH46rzfuDRrHR5PA
//  Created by IMCS2 on 2/21/19.
//  Copyright © 2019 IMCS2. All rights reserved.
// BLog key : AIzaSyB3Dfp5_PDnpccYneZkJY9o0k1i0TMgHO4

import UIKit
import CoreData

struct data : Decodable{
    let title : String
    let content : String
    
}

struct BlogData : Decodable{
    
    let kind : String
  
    let items :[data]

}

var blogsdata = [data]()

class ViewController: UIViewController {
    
    //let dispachGroup = DispatchGroup()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//
//        dispachGroup.notify(queue: .main) {
//
//        }
        
        getJSONData()
    }


}


extension ViewController : UITableViewDelegate,UITableViewDataSource   {
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) is selcted ")
        //self.performSegue(withIdentifier: "toBlogPost", sender: self)
        let view: BlogPostViewController = self.storyboard?.instantiateViewController(withIdentifier: "blogPost") as! BlogPostViewController
        
        self.navigationController?.pushViewController(view, animated: true)
        view.blogPostName = blogsdata[indexPath.row].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogsdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogCell")!
        
        cell.textLabel?.text = blogsdata[indexPath.row].title
        cell.detailTextLabel?.text = blogsdata[indexPath.row].content
        
        return cell
    }
    
    func getJSONData(){
        //let url = URL(string: "https://api.github.com/users/hadley/orgs")
        guard let url = URL(string: "https://www.googleapis.com/blogger/v3/blogs/6437211992029056170/posts?key=AIzaSyCR6Mjdcgu7MP_qOQWrH46rzfuDRrHR5PA") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let data = try JSONDecoder().decode(BlogData.self , from: dataResponse)
                print("ans :: ",data.items)
                print("this is bloh=gs data",blogsdata)
                for entry in data.items{
                    blogsdata.append(entry)
                    self.saveBlog(title: entry.title, content: entry.content)
                }
                print("this is after putting into blogs data \(blogsdata)")
            } catch let parsingError {
                print("Error", parsingError)
            }
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
           
        }
        task.resume()
    }
    
    func saveBlog(title:String , content:String){
        if title != nil && content != nil{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BlogDataPersistance", in: context)
        let newBlog = NSManagedObject(entity: entity!, insertInto: context)
        
        newBlog.setValue(title, forKey: "title")
        newBlog.setValue(content, forKey: "content")
        
        do {
            try context.save()
           print("Data Saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        }
        getData()
    }
    
    func getData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "BlogDataPersistance")
        
        //3
        do {
            let blog = try managedContext.fetch(fetchRequest)
            for eachBlog in blog{
                print("blog from persistance \(String(describing: eachBlog.value(forKey: "title")))")
            }
           
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}
