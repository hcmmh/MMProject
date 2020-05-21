//
//  MMConstraintDescription.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
public class MMConstraintDescription {
     let item: MMLayoutConstraintItem
     var attributes: MMConstraintAttributes
    // MARK: Initialization
    private init(item: MMLayoutConstraintItem, attributes: MMConstraintAttributes) {
        self.item = item
        self.attributes = attributes
    }
     static func description(item: MMLayoutConstraintItem, attributes: MMConstraintAttributes)->MMConstraintDescription{
        if let view = item as? ConstraintView {
            let desc = objc_getAssociatedObject(view, Unmanaged.passUnretained(view).toOpaque().advanced(by: Int(attributes.rawValue)+10020)) as? MMConstraintDescription
            if desc == nil{
                let temp = MMConstraintDescription(item: item, attributes: attributes)
                objc_setAssociatedObject(view, Unmanaged.passUnretained(view).toOpaque().advanced(by: Int(attributes.rawValue)+10020),temp, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return temp
            }else{
                return desc!
            }
        }else{
            let view = item as? MMConstraintLayoutGuide
            let desc = objc_getAssociatedObject(view as Any, Unmanaged.passUnretained(view!).toOpaque().advanced(by: Int(attributes.rawValue)+10030)) as? MMConstraintDescription
            if desc == nil{
                let temp = MMConstraintDescription(item: item, attributes: attributes)
                objc_setAssociatedObject(view as Any, Unmanaged.passUnretained(view!).toOpaque().advanced(by: Int(attributes.rawValue)+10030),temp, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return temp
            }else{
                return desc!
            }
        }
        
    }
}
