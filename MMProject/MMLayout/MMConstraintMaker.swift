//
//  MMConstraintMaker.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
typealias makeClosure = (_ make: MMConstraintMaker) -> Void
class MMConstraintMaker {
    private let item:MMLayoutConstraintItem
    private var descriptions = [MMConstraintDescription]()
    init(item:MMLayoutConstraintItem) {
        self.item = item
        self.item.prepare()
    }
    internal func makeExtendableWithAttributes(_ attributes: MMConstraintAttributes) -> MMMakerExtendable {
        let description = MMConstraintDescription.description(item: self.item, attributes: attributes)
        self.descriptions.append(description)
        return MMMakerExtendable(description)
    }
    static func prepareConstraints(item:MMLayoutConstraintItem,closure:makeClosure){
        let make = MMConstraintMaker(item: item)
        closure(make)
    }
    static func makeConstraints(item:MMLayoutConstraintItem,closure:makeClosure){
        guard item.superview != nil else {
            print("无法设置约束,因为superview为 nil")
            return
        }
        prepareConstraints(item: item, closure: closure)
    }
    static func remakeConstraints(item:MMLayoutConstraintItem,closure:makeClosure){
        guard item.superview != nil else {
            print("无法设置约束,因为superview为 nil")
            return
        }
        removeConstraints(item: item)
        prepareConstraints(item: item, closure: closure)
    }
    static func removeConstraints(item:MMLayoutConstraintItem){
        guard let view = item as? ConstraintView else {
            return
        }
        NSLayoutConstraint.deactivate(view.mmLayoutItems)
        view.mmLayoutItems.removeAll()
    }
    var left:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.left)
    }
    var top:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.top)
    }
    var right:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.right)
    }
    var bottom:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.bottom)
    }
    var width:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.width)
    }
    var height:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.height)
    }
    var leading:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.leading)
    }
    var trailing:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.trailing)
    }
    var centerX:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.centerX)
    }
    var centerY:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.centerY)
    }
    var edges:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.edges)
    }
    var size:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.size)
    }
    var center:MMMakerExtendable{
        return self.makeExtendableWithAttributes(.center)
    }
}
