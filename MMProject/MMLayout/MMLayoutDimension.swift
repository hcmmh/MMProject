//
//  MMLayoutDimension.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/15.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
import UIKit
open class MMLayoutDimension{
    var dimension:NSLayoutDimension {
        if type == .width {return (self.target?.widthAnchor)!}
        if type == .height {return (self.target?.heightAnchor)!}
        return NSLayoutDimension()
    }
    weak var target: ConstraintView?
    internal var type:MMLayoutItemType
    init(target: ConstraintView?, type: MMLayoutItemType) {
        self.target = target
        self.type = type
    }
}


