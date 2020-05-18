//
//  ViewController.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/10.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var list:[Any]?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.title = "MMProject"
        self.list = ["Loading","Text","Progress","RoundProgress","Custom","MMLayout"]
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hud = MMProgressHUD.showHUDonView(view: self.view, animated: true)
        switch indexPath.row {
        case 0:
            hud.model = .Loading
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (t) in
                MMProgressHUD.hideHUD(view: self.view, animated: true)
                t.invalidate()
            }
        case 1:
            hud.model = .Text
            hud.title = "那就这样吧"
            hud.hideHUD(view: self.view, delay: 2)
        case 2:
            hud.model = .Progress
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
                hud.progress = hud.progress+0.01
                if hud.progress>=1.0{
                    MMProgressHUD.hideHUD(view: self.view, animated: true)
                    t.invalidate()
                }
            }
        case 3:
            hud.model = .RoundProgress
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
                hud.progress = hud.progress+0.01
                if hud.progress>=1.0{
                    MMProgressHUD.hideHUD(view: self.view, animated: true)
                     t.invalidate()
                }
            }
        case 4:
            hud.model = .Custom
            let c = UIView()
            c.backgroundColor = UIColor.red
            hud.customView = c 
            hud.title = "提交成功"
            hud.hideHUD(view: self.view, delay: 2)
        case 5:
            MMProgressHUD.hideHUD(view: self.view, animated: true)
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
        cell?.textLabel?.text = (list![indexPath.row] as! String)
        
        return cell!
    }
}
