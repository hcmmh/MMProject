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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
       
        v.isUserInteractionEnabled = true
        v.backgroundColor = UIColor.red
        self.view.addSubview(v)
        v.mm.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalTo(100)
            make.left.equalTo(self.view.mm.left)
            make.top.equalTo(self.view.mm.top)
            self.pir()
        }
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(click))
        v.addGestureRecognizer(tgr)
    }
    func pir() {
        print(22222)
    }
    @objc func click(){
        self.dismiss(animated: true) {
            
        }
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
