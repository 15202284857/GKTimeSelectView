//
//  ViewController.swift
//  demo
//
//  Created by Apple on 2017/12/24.
//  Copyright © 2017年 郭凯. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let rect = CGRect(x: 100, y: 100, width: 180, height: 40)
        
        let timeView = GKTimeItemView(frame:rect , startTime: 1510196895, endTime: 1514196895)
        timeView.backgroundColor = UIColor.purple
        
        view.addSubview(timeView)

        
        
    }


}

