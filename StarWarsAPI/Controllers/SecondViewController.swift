//
//  SecondViewController.swift
//  StarWarsAPI
//
//  Created by Chetan Dhowlaghar on 9/16/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    var name: String?
    var result: Result?
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = name
        nameLabel.text = result?.name
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
