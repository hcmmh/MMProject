//
//  Demo1ViewController.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/13.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

class Demo1ViewController: UIViewController {
    let v = UIView()
    let v2 = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        v.isUserInteractionEnabled = true
        v.backgroundColor = UIColor.red
        self.view.addSubview(v)
        v.mm.makeConstraints { (make) in
            make.leading.equalTo(25)
            make.top.equalTo(view.mm.safeTop)
            make.height.equalTo(100)
        }
        self.view.addSubview(v2)
        v2.backgroundColor = UIColor.blue
        v2.mm.makeConstraints { (make) in
            make.top.height.width.equalTo(v)
            make.leading.equalTo(v.mm.trailing, cons: 25)
            make.trailing.equalTo(-25)
        }
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(click))
        v.addGestureRecognizer(tgr)
    }
    @objc func click(){
        self.dismiss(animated: true) {
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    deinit {
        print("demo1 deinit")
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
