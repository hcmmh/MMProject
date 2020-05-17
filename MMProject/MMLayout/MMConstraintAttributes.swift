//
//  MMConstraintAttributes.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit
internal struct MMConstraintAttributes:OptionSet,ExpressibleByIntegerLiteral{
    typealias IntegerLiteralType = UInt
    
    internal init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    internal init(_ rawValue: UInt) {
        self.init(rawValue: rawValue)
    }
    internal init(nilLiteral: ()) {
        self.rawValue = 0
    }
    internal init(integerLiteral rawValue: IntegerLiteralType) {
        self.init(rawValue: rawValue)
    }
    internal private(set) var rawValue: UInt
    // normal
    internal static var none: MMConstraintAttributes { return 0 }
    internal static var left: MMConstraintAttributes { return 1 }
    internal static var top: MMConstraintAttributes {  return 2 }
    internal static var right: MMConstraintAttributes { return 4 }
    internal static var bottom: MMConstraintAttributes { return 8 }
    internal static var leading: MMConstraintAttributes { return 16 }
    internal static var trailing: MMConstraintAttributes { return 32 }
    internal static var width: MMConstraintAttributes { return 64}
    internal static var height: MMConstraintAttributes { return 128 }
    internal static var centerX: MMConstraintAttributes { return 256 }
    internal static var centerY: MMConstraintAttributes { return 512 }
    internal static var safeTop: MMConstraintAttributes { return 1024 }
    internal static var safeBottom: MMConstraintAttributes { return 2048 }

    // aggregates
    internal static var edges: MMConstraintAttributes { return 15 }
    internal static var size: MMConstraintAttributes { return 192 }
    internal static var center: MMConstraintAttributes { return 768 }
    internal var layoutAttributes:[MMConstraintAttributes] {
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
            attrs.append(.center)
        }
        if (self.contains(MMConstraintAttributes.edges)) {
            attrs.append(.edges)
        }
        if (self.contains(MMConstraintAttributes.size)) {
            attrs.append(.size)
        }
        return attrs
    }
}
internal func + (left: MMConstraintAttributes, right: MMConstraintAttributes) -> MMConstraintAttributes {
    return left.union(right)
}

internal func +=(left: inout MMConstraintAttributes, right: MMConstraintAttributes) {
    left.formUnion(right)
}

internal func -=(left: inout MMConstraintAttributes, right: MMConstraintAttributes) {
    left.subtract(right)
}

internal func ==(left: MMConstraintAttributes, right: MMConstraintAttributes) -> Bool {
    return left.rawValue == right.rawValue
}
