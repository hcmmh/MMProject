//
//  MMLayoutYItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/15.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
import UIKit
class MMLayoutYItem{
    var anchor:NSLayoutYAxisAnchor {
        switch type {
        case .top:
            return (target?.topAnchor)!
        case .bottom:
            return (target?.bottomAnchor)!
        case .centerY:
            return (target?.centerYAnchor)!
        case .safeTop:
            return (target?.safeAreaLayoutGuide.topAnchor)!
        case .safeBottom:
            return (target?.safeAreaLayoutGuide.bottomAnchor)!
        default:
            return NSLayoutYAxisAnchor()
        }
    }
    weak var target: ConstraintView?
    internal var type:MMLayoutItemType
    init(target: ConstraintView?, type: MMLayoutItemType) {
        self.target = target
        self.type = type
    }
}
