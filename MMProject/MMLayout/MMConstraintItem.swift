//
//  MMConstraintItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
public final class MMConstraintItem {
     weak var target: AnyObject?
     let attributes: MMConstraintAttributes
     init(target: AnyObject?, attributes:MMConstraintAttributes) {
        self.target = target
        self.attributes = attributes
    }
     var layoutConstraintItem: MMLayoutConstraintItem? {
        return self.target as? MMLayoutConstraintItem
    }
}
