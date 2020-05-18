//
//  Demo1ViewController.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/13.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

class MMLayoutDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = false
        self.title = "MMLayout布局"
        let edgesView = self.edgesUI()
        let subview = UIView()
        self.view.addSubview(subview)
        subview.backgroundColor = UIColor.green
        subview.mm.makeConstraints({
            $0.center.equalToSuperView()
            $0.size.lessThanOrEqualTo(edgesView,cons:-25)
        })
        self.bisection()
    }
    func edgesUI()->UIView{
        let edgesView=UIView()
        self.view.addSubview(edgesView)
        edgesView.backgroundColor = UIColor.red
        edgesView.mm.makeConstraints { (make) in
            make.top.equalTo(view.mm.safeTop, cons: 120)
            make.centerX.equalToSuperView()
            make.width.equalTo(self.view, multiplier: 0.7)
            make.height.equalTo(100)
        }
        let subview = UIView()
        edgesView.addSubview(subview)
        subview.backgroundColor = UIColor.cyan
        subview.mm.makeConstraints({
            $0.edges.equalTo(10)
        })
        return edgesView
    }
    
    // 等分
    func bisection(){
        let sectionView = UIView()
        self.view.addSubview(sectionView)
        sectionView.mm.makeConstraints({
            $0.top.equalTo(view.mm.safeTop)
            $0.left.right.equalTo(15)
            $0.height.equalTo(100)
        })
        sectionView.backgroundColor = UIColor.blue
        var temp:UIView?
        for i in 0...3 {
            let subview = UIView()
            sectionView.addSubview(subview)
            subview.backgroundColor = UIColor.black
            subview.mm.makeConstraints({
                $0.centerY.equalToSuperView()
                $0.height.equalTo(sectionView, multiplier: 0.5)
                if temp == nil{
                    $0.leading.equalTo(15)
                }else{
                    $0.width.equalTo(temp)
                    $0.leading.equalTo(temp?.mm.trailing, cons: 20)
                }
                if i == 3{
                    $0.trailing.equalTo(15)
                }
            })
            temp = subview
        }
    }
    @objc func click(){
        self.dismiss(animated: true) {
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.description
    }
    deinit {
        print("MMLayoutDemoViewController deinit")
    }

}
