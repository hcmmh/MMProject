//
//  MMLayoutConstraintItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
public typealias MMConstraintLayoutGuide = UILayoutGuide
public protocol MMLayoutConstraintItem{}
extension ConstraintView:MMLayoutConstraintItem{}
extension MMConstraintLayoutGuide:MMLayoutConstraintItem{}
extension MMLayoutConstraintItem{
     func prepare(){
        if let view = self as? ConstraintView{
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
     var superview:ConstraintView?{
        if let view = self as? ConstraintView{
            return view.superview
        }
        if let guide = self as? MMConstraintLayoutGuide {
            return guide.owningView
        }
        return nil
    }
}
