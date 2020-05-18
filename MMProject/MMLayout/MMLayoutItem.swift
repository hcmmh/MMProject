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
public class MMLayoutItem{
    internal static func item(target: AnyObject?, attributes: MMConstraintAttributes)->MMLayoutItem{
        let item = objc_getAssociatedObject(target!, Unmanaged.passUnretained(target!).toOpaque().advanced(by: Int(attributes.rawValue)+10001)) as? MMLayoutItem
        if item == nil{
            let temp = MMLayoutItem(target: target, attributes: attributes)
            objc_setAssociatedObject(target!, Unmanaged.passUnretained(target!).toOpaque().advanced(by: Int(attributes.rawValue)+10001),temp, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           return temp
        }else{
            return item!
        }
    }
    internal weak var target: AnyObject?
    internal let attributes: MMConstraintAttributes
    private init(target: AnyObject?, attributes: MMConstraintAttributes) {
        self.target = target
        self.attributes = attributes
    }
    internal var layoutConstraintItem: MMLayoutConstraintItem? {
        return self.target as? MMLayoutConstraintItem
    }
    var xanchor:NSLayoutXAxisAnchor?{
        if attributes == .left {
            return left
        }
        if attributes == .right {
            return right
        }
        if attributes == .centerX {
            return centerX
        }
        if attributes == .leading {
            return leading
        }
        if attributes == .trailing {
            return trailing
        }
        return nil
    }
    var yanchor:NSLayoutYAxisAnchor?{
        if attributes == .top {
            return top
        }
        if attributes == .bottom {
            return bottom
        }
        if attributes == .centerY {
            return centerY
        }
        if attributes == .safeTop {
            return safeTop
        }
        if attributes == .safeBottom {
            return safeBottom
        }
        if attributes == .firstBaseline {
            return firstBaseline
        }
        if attributes == .lastBaseline {
            return lastBaseline
        }
        return nil
    }
    var dimension:NSLayoutDimension?{
        if attributes == .height {
            return height
        }
        if attributes == .width {
            return width
        }
        return nil
    }
    var widthDimension:NSLayoutDimension?{
        return width
    }
    var heightDimension:NSLayoutDimension?{
        return height
    }
    private var left:NSLayoutXAxisAnchor?{
        return self.target?.leftAnchor
    }
    private var right:NSLayoutXAxisAnchor?{
        return self.target?.rightAnchor
    }
    private var centerX:NSLayoutXAxisAnchor?{
        return self.target?.centerXAnchor
    }
    private var top:NSLayoutYAxisAnchor?{
        return self.target?.topAnchor
    }
    private var bottom:NSLayoutYAxisAnchor?{
        return self.target?.bottomAnchor
    }
    private var centerY:NSLayoutYAxisAnchor?{
        return self.target?.centerYAnchor
    }
    private var leading:NSLayoutXAxisAnchor?{
        return self.target?.leadingAnchor
    }
    private var trailing:NSLayoutXAxisAnchor?{
        return self.target?.trailingAnchor
    }
    private var safeTop:NSLayoutYAxisAnchor?{
        return self.target?.safeAreaLayoutGuide?.topAnchor
    }
    private var safeBottom:NSLayoutYAxisAnchor?{
        return self.target?.safeAreaLayoutGuide?.bottomAnchor
    }
    private var width:NSLayoutDimension?{
        return self.target?.widthAnchor
    }
    private var height:NSLayoutDimension?{
        return self.target?.heightAnchor
    }
    private var firstBaseline:NSLayoutYAxisAnchor?{
        return self.target?.firstBaselineAnchor
    }
    private var lastBaseline:NSLayoutYAxisAnchor?{
        return self.target?.lastBaselineAnchor
    }
    private var center:MMLayoutItem?{
        return MMLayoutItem.item(target: self.target, attributes: .center)
    }
    private var size:MMLayoutItem?{
        return MMLayoutItem.item(target: self.target, attributes: .size)
    }
    private var edges:MMLayoutItem?{
        return MMLayoutItem.item(target: self.target, attributes: .edges)
    }
}
extension MMLayoutItem{
    @discardableResult
    func equalTo(_ other:MMLayoutItem?,multiplier:CGFloat, cons:CGFloat,type:Int = 0)->NSLayoutConstraint? {
        let view = self.target as! ConstraintView
        var o = other
        var layout:NSLayoutConstraint? = view.mmConstraint(key: attributes)
        if layout != nil{
            NSLayoutConstraint.deactivate([layout!])
        }
        if o == nil{
            o = MMLayoutItem.item(target: view.superview, attributes: attributes)
        }
        if attributes == .left || attributes == .centerX || attributes == .leading {
            if o?.xanchor != nil{
                layout = xanchor!.constraint(equalTo: (o?.xanchor)!, constant: cons)
            }
        }
        if attributes == .right || attributes == .trailing{
            if o?.xanchor != nil{
                layout = xanchor!.constraint(equalTo: (o?.xanchor)!, constant: -cons)
            }
        }
        if attributes == .top || attributes == .bottom || attributes == .centerY || attributes == .safeTop || attributes == .firstBaseline || attributes == .lastBaseline{
            if o?.yanchor != nil{
                layout = yanchor!.constraint(equalTo: (o?.yanchor)!, constant: cons)
            }
        }
        if attributes == .bottom ||  attributes == .safeBottom {
            if o?.yanchor != nil{
                layout = yanchor!.constraint(equalTo: (o?.yanchor)!, constant: -cons)
            }
        }
        if attributes == .width || attributes == .height {
            if other == nil{
                if type == 1{
                    layout = dimension!.constraint(lessThanOrEqualToConstant: cons)
                }else if type == 2{
                    layout = dimension!.constraint(greaterThanOrEqualToConstant: cons)
                }else{
                    layout = dimension!.constraint(equalToConstant: cons)
                }
            }else{
                if attributes == .width && o?.attributes == .size{
                    if type == 1{
                        layout = dimension!.constraint(greaterThanOrEqualTo: (o?.widthDimension)!, multiplier: multiplier, constant: cons)
                    }else if type == 2{
                        layout = dimension!.constraint(lessThanOrEqualTo: (o?.widthDimension)!, multiplier: multiplier, constant: cons)
                    }else{
                        layout = dimension!.constraint(equalTo: (o?.widthDimension)!, multiplier: multiplier, constant: cons)
                    }
                }else if attributes == .height && o?.attributes == .size{
                    if type == 1{
                        layout = dimension!.constraint(greaterThanOrEqualTo: (o?.heightDimension)!, multiplier: multiplier, constant: cons)
                    }else if type == 2{
                        layout = dimension!.constraint(lessThanOrEqualTo: (o?.heightDimension)!, multiplier: multiplier, constant: cons)
                    }else{
                        layout = dimension!.constraint(equalTo: (o?.heightDimension)!, multiplier: multiplier, constant: cons)
                    }
                }else{
                    if type == 1{
                        layout = dimension!.constraint(greaterThanOrEqualTo: (o?.dimension)!, multiplier: multiplier, constant: cons)
                    }else if type == 2{
                        layout = dimension!.constraint(lessThanOrEqualTo: (o?.dimension)!, multiplier: multiplier, constant: cons)
                    }else{
                        layout = dimension!.constraint(equalTo: (o?.dimension)!, multiplier: multiplier, constant: cons)
                    }
                }
            }
        }
        layout?.isActive = true
        if layout != nil {
            view.setMMConstraint(key: attributes, value: layout!)
        }
        return layout
    }
}

