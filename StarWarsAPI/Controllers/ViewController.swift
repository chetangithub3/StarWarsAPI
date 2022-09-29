//
//  ViewController.swift
//  StarWarsAPI
//
//  Created by Chetan Dhowlaghar on 9/11/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate     {

    @IBOutlet weak var myTable: UITableView!
    
    
    
    
    var tableManager = TableManager()
    var refreshControl = UIRefreshControl()
    
    var secondVCName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            self.myTable.delegate = self
            self.myTable.dataSource = self
        refreshControl.addTarget(self, action: #selector(fetch), for: UIControl.Event.valueChanged)
        myTable.addSubview(refreshControl)
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableManager.fetchData()
        
        
        let observer: Void = NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("Reload"), object: nil)
        
    }
    
    @objc func fetch(){
                self.tableManager.fetchData()
    }

    
    @objc func reload(){
            DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                    self.myTable.reloadData()
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
            NotificationCenter.default.removeObserver(self)
        
            NotificationCenter.default.removeObserver(self, name: Notification.Name("Reload"), object: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableManager.tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = myTable.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
            cell.nameLabel.text = tableManager.tableList[indexPath.row].name
            cell.heightLabel.text = tableManager.tableList[indexPath.row].height
            cell.genderLabel.text = tableManager.tableList[indexPath.row].gender?.rawValue
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        secondVCName = tableManager.tableList[indexPath.row].name!
        //performSegue(withIdentifier: "go", sender: self)
        
        let secondVC: SecondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        
        secondVC.result = tableManager.tableList[indexPath.row]
        
        self.present(secondVC, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "go" {
//            let secondVC = segue.destination as! SecondViewController
//            secondVC.name = secondVCName
//        }
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if (position > scrollView.contentSize.height - 100 - scrollView.frame.size.height){
            
            self.tableManager.fetchData()
            let observer: Void = NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("Reload"), object: nil)
            
        }
        
        
    }
    
    
}

