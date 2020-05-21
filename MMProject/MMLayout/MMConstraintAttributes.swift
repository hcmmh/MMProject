//
//  MMConstraintAttributes.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
 struct MMConstraintAttributes:OptionSet,ExpressibleByIntegerLiteral{
    typealias IntegerLiteralType = UInt
    
     init(rawValue: UInt) {
        self.rawValue = rawValue
    }
     init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
     init(nilLiteral: ()) {
        self.rawValue = 0
    }
     init(integerLiteral rawValue: IntegerLiteralType) {
        self.init(rawValue: rawValue)
    }
     private(set) var rawValue: UInt
    // normal
     static var none: MMConstraintAttributes { return 0 }
     static var left: MMConstraintAttributes { return 1 }
     static var top: MMConstraintAttributes {  return 2 }
     static var right: MMConstraintAttributes { return 4 }
     static var bottom: MMConstraintAttributes { return 8 }
     static var leading: MMConstraintAttributes { return 16 }
     static var trailing: MMConstraintAttributes { return 32 }
     static var width: MMConstraintAttributes { return 64}
     static var height: MMConstraintAttributes { return 128 }
     static var centerX: MMConstraintAttributes { return 256 }
     static var centerY: MMConstraintAttributes { return 512 }
     static var safeTop: MMConstraintAttributes { return 1024 }
     static var safeBottom: MMConstraintAttributes { return 2048 }
     static var firstBaseline: MMConstraintAttributes { return 4096 }
     static var lastBaseline: MMConstraintAttributes { return 8192 }
    // aggregates
     static var edges: MMConstraintAttributes { return 15 }
     static var size: MMConstraintAttributes { return 192 }
     static var center: MMConstraintAttributes { return 768 }
     var layoutAttributes:[MMConstraintAttributes] {
        var attrs = [MMConstraintAttributes]()
        if (self.contains(MMConstraintAttributes.left)) {
            attrs.append(.left)
        }
        if (self.contains(MMConstraintAttributes.top)) {
            attrs.append(.top)
        }
        if (self.contains(MMConstraintAttributes.right)) {
            attrs.append(.right)
        }
        if (self.contains(MMConstraintAttributes.bottom)) {
            attrs.append(.bottom)
        }
        if (self.contains(MMConstraintAttributes.leading)) {
            attrs.append(.leading)
        }
        if (self.contains(MMConstraintAttributes.trailing)) {
            attrs.append(.trailing)
        }
        if (self.contains(MMConstraintAttributes.width)) {
            attrs.append(.width)
        }
        if (self.contains(MMConstraintAttributes.height)) {
            attrs.append(.height)
        }
        if (self.contains(MMConstraintAttributes.centerX)) {
            attrs.append(.centerX)
        }
        if (self.contains(MMConstraintAttributes.centerY)) {
            attrs.append(.centerY)
        }
        if (self.contains(MMConstraintAttributes.center)) {
            attrs.append(.centerX)
            attrs.append(.centerY)
        }
        if (self.contains(MMConstraintAttributes.edges)) {
            attrs.append(.left)
            attrs.append(.right)
            attrs.append(.top)
            attrs.append(.bottom)
        }
        if (self.contains(MMConstraintAttributes.size)) {
            attrs.append(.width)
            attrs.append(.height)
        }
        if (self.contains(MMConstraintAttributes.firstBaseline)) {
            attrs.append(.firstBaseline)
        }
        if (self.contains(MMConstraintAttributes.lastBaseline)) {
            attrs.append(.lastBaseline)
        }
        return attrs
    }
}
 func + (left: MMConstraintAttributes, right: MMConstraintAttributes) -> MMConstraintAttributes {
    return left.union(right)
}

 func +=(left: inout MMConstraintAttributes, right: MMConstraintAttributes) {
    left.formUnion(right)
}

 func -=(left: inout MMConstraintAttributes, right: MMConstraintAttributes) {
    left.subtract(right)
}

 func ==(left: MMConstraintAttributes, right: MMConstraintAttributes) -> Bool {
    return left.rawValue == right.rawValue
}
