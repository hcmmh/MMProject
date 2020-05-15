//
//  MMLayoutXItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/15.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
import UIKit
class MMLayoutXItem{
    var anchor:NSLayoutXAxisAnchor {
        switch type {
        case .left:
            return (target?.leftAnchor)!
        case .right:
            return (target?.rightAnchor)!
        case .centerX:
            return (target?.centerXAnchor)!
        case .leading:
            return (target?.leadingAnchor)!
        case .trailing:
            return (target?.trailingAnchor)!
        default:
            return NSLayoutXAxisAnchor()
        }
    }
    weak var target: ConstraintView?
    internal var type:MMLayoutItemType
    init(target: ConstraintView?, type: MMLayoutItemType) {
        self.target = target
        self.type = type
    }
}
