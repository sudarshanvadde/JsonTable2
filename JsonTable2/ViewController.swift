//
//  ViewController.swift
//  JsonTable2
//
//  Created by Sundir Talari on 29/03/18.
//  Copyright © 2018 Sundir Talari. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var table: UITableView!
    
    var sampleArray = [EmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        table.delegate = self
        table.dataSource = self
        
        let url = URL(string: "http://jsonplaceholder.typicode.com/todos")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data else {return}
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: []) as![Any]
                print(json)
                
                for (_, element) in json.enumerated() {
                    
                    let completedFromServer = (element as![String: Any])["completed"] as! Bool
                    let idFromServer = (element as![String: Any])["id"] as! Int
                    let titleFromServer = (element as![String: Any])["title"] as! String
                    let userIdFromServer = (element as![String: Any])["userId"] as! Int
                    
                    let employeeModelObj = EmployeeModel()
                    employeeModelObj.completed = completedFromServer
                    employeeModelObj.id = idFromServer
                    employeeModelObj.title = titleFromServer
                    employeeModelObj.userId = userIdFromServer
                    
                    self.sampleArray.append(employeeModelObj)
                
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
                
            }catch {
                
                print("json error: \(error.localizedDescription)")
            }
            
            
        }.resume()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")
        let employeeModelObj = sampleArray[indexPath.row]
        cell?.textLabel?.text = "Title: \(employeeModelObj.title), Id status: \(employeeModelObj.id),user Id: \(employeeModelObj.userId),completed\(employeeModelObj.completed) "
        return cell!
    }

}

