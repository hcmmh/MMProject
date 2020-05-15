//
//  MMLayoutItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/14.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif
open class MMLayoutSizeItem{
    var width:NSLayoutDimension {
        return (target?.widthAnchor)!
    }
    var height:NSLayoutDimension {
        return (target?.heightAnchor)!
    }
    weak var target: ConstraintView?
    internal var type:MMLayoutItemType
    init(target: ConstraintView?, type: MMLayoutItemType) {
        self.target = target
        self.type = type
    }
}
enum MMLayoutItemType:Int {
    case left = 3001
    case right = 3002
    case top = 3003
    case bottom = 3004
    case width = 3005
    case height = 3006
    case size = 3007
    case leading = 3008
    case trailing = 3009
    case centerX = 3010
    case centerY = 3011
    case safeTop = 3012
    case safeBottom = 3013
    case safeLeft = 3014
    case safeRight = 3015
    case edges = 3016
}
