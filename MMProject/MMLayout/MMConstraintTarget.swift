//
//  MMConstraintTarget.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
public protocol MMConstraintTarget {}

extension Int:MMConstraintTarget{}
extension CGFloat:MMConstraintTarget{}
extension Double:MMConstraintTarget{}
extension Float:MMConstraintTarget{}
extension CGSize:MMConstraintTarget{}
extension CGPoint:MMConstraintTarget{}

extension MMLayoutItem:MMConstraintTarget{}
extension ConstraintView:MMConstraintTarget{}
extension MMConstraintTarget{
    var constant:CGFloat{
        if let value = self as? CGFloat {
            return value
        }
        if let value = self as? Int {
            return CGFloat(value)
        }
        if let value = self as? Double {
            return CGFloat(value)
        }
        if let value = self as? Float {
            return CGFloat(value)
        }
        return 0.0
    }
}
