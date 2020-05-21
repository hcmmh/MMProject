//
//  ViewController.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/10.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var list:[String]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.title = "MMProject"
        self.list = ["HUD","NSLayoutAnchor"]
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(HUDViewController(), animated: true)
        case 1:
            self.navigationController?.pushViewController(MMLayoutDemoViewController(), animated: true)
        default:
            print(indexPath.row)
        }
    }
}
extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = list![indexPath.row] 
        
        return cell!
    }
}
