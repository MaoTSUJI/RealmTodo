//
//  ViewController.swift
//  RalmTodo
//
//  Created by 辻真緒 on 2019/07/30.
//  Copyright © 2019 辻真緒. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didClickAddBtn(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toNext", sender: nil)
        
    }
    
}

