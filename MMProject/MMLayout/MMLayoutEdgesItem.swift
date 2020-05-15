//
//  MMLayoutEdgesItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/15.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
class MMLayoutEdgesItem {
    weak var target: ConstraintView?
    internal var type:MMLayoutItemType
    init(target: ConstraintView?, type: MMLayoutItemType) {
        self.target = target
        self.type = type
    }
}
