//
//  MMConstraintItem.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
public final class MMConstraintItem {
    internal weak var target: AnyObject?
    internal let attributes: MMConstraintAttributes
    internal init(target: AnyObject?, attributes:MMConstraintAttributes) {
        self.target = target
        self.attributes = attributes
    }
    internal var layoutConstraintItem: MMLayoutConstraintItem? {
        return self.target as? MMLayoutConstraintItem
    }
}
