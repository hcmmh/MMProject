//
//  UIView+Extension.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/13.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif


#if os(iOS) || os(tvOS)
typealias ConstraintView = UIView
#else
typealias ConstraintView = NSView
#endif
extension ConstraintView{
    @available(iOS 9.0, *)
    var mm:ConstraintViewLayoutDSL{
        set{
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 10001), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            var view = objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 10001))
            if view == nil{
                view = ConstraintViewLayoutDSL(view: self)
                self.mm = view as! ConstraintViewLayoutDSL
            }
            return view as! ConstraintViewLayoutDSL
        }
    }
    var mmLayoutItems:[NSLayoutConstraint]{
        set{
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque(), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            let obj = objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque())
            if obj == nil{
                return [NSLayoutConstraint]()
            }
            return obj as! [NSLayoutConstraint]
        }
    }
    func addMMItems(item:NSLayoutConstraint) {
        var list = mmLayoutItems
        list.append(item)
        mmLayoutItems = list
    }
}
extension ConstraintView{
    var leftConstraint:NSLayoutConstraint?{
        set{
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 2001), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 2001)) as? NSLayoutConstraint ?? nil
        }
    }
    var rightConstraint:NSLayoutConstraint?{
        set{
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 2002), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 2002)) as? NSLayoutConstraint ?? nil
        }
    }
}


public struct ConstraintViewLayoutDSL {
    internal let view:ConstraintView
    internal init(view:ConstraintView) {
        self.view = view
    }
    func makeConstraints(_ closure: (_ make: ConstraintViewLayoutDSL) -> Void) {
        if view.superview != nil{
            self.removeConstraints()
            self.view.translatesAutoresizingMaskIntoConstraints = false
            closure(self)
            NSLayoutConstraint.activate(view.mmLayoutItems)
        }else{
            print("warning：该view还没添加到父View")
        }
    }
    func removeConstraints() {
        if view.superview != nil{
            self.view.translatesAutoresizingMaskIntoConstraints = true
            NSLayoutConstraint.deactivate(self.view.mmLayoutItems)
            self.view.mmLayoutItems.removeAll()
        }else{
            print("warning：该view还没添加到父View")
        }
    }
}
extension ConstraintViewLayoutDSL{
    var width:MMLayoutDimension{
        return MMLayoutDimension(target: view, type: .width)
    }
    var height:MMLayoutDimension{
        return MMLayoutDimension(target: view, type: .height)
    }
    var size:MMLayoutSizeItem{
        return MMLayoutSizeItem(target: view, type: .size)
    }
    var left: MMLayoutXItem{
        return MMLayoutXItem(target: view, type: .left)
    }
    var right: MMLayoutXItem{
        return MMLayoutXItem(target: view, type: .right)
    }
    var leading: MMLayoutXItem{
        return MMLayoutXItem(target: view, type: .leading)
    }
    var trailing: MMLayoutXItem{
        return MMLayoutXItem(target: view, type: .trailing)
    }
    var centerX: MMLayoutXItem{
        return MMLayoutXItem(target: view, type: .centerX)
    }
    var top: MMLayoutYItem{
        return MMLayoutYItem(target: view, type: .top)
    }
    @available(iOS 11.0, *)
    var safeTop: MMLayoutYItem{
        return MMLayoutYItem(target: view, type: .safeTop)
    }
    @available(iOS 11.0, *)
    var safeBottom: MMLayoutYItem{
        return MMLayoutYItem(target: view, type: .safeBottom)
    }
    var bottom: MMLayoutYItem{
        return MMLayoutYItem(target: view, type: .bottom)
    }
    var centerY: MMLayoutYItem{
        return MMLayoutYItem(target: view, type: .centerY)
    }
    var edges: MMLayoutEdgesItem{
        return MMLayoutEdgesItem(target: view, type: .centerY)
    }
}
extension MMLayoutEdgesItem{
    func equalTo(_ constant:CGFloat){
        target?.mm.left.equalTo(constant)
        target?.mm.top.equalTo(constant)
        target?.mm.right.equalTo(-constant)
        target?.mm.bottom.equalTo(-constant)
    }
    func equalToSuperView(){
        equalTo(0)
    }
}
extension MMLayoutSizeItem{
    func equalTo(size:CGSize){
        equalTo(width: size.width, height: size.height)
    }
    func equalTo(width:CGFloat,height:CGFloat){
        target?.mm.width.equalTo(width)
        target?.mm.height.equalTo(height)
    }
    func equalTo(subview:ConstraintView){
        target?.mm.width.equalTo(subview.mm.width)
        target?.mm.height.equalTo(subview.mm.height)
    }
    func equalToSuperView(){
        target?.mm.width.equalTo((target?.superview?.mm.width)!)
        target?.mm.height.equalTo((target?.superview?.mm.height)!)
    }
}
extension MMLayoutXItem{
    @discardableResult
    func equalToSuperView()->NSLayoutConstraint{
        switch type {
        case .left:
            return equalTo((target?.superview?.mm.left)!)
        case .right:
            return equalTo((target?.superview?.mm.right)!)
        case .leading:
            return equalTo((target?.superview?.mm.leading)!)
        case .trailing:
            return equalTo((target?.superview?.mm.trailing)!)
        case .centerX:
            return equalTo((target?.superview?.mm.centerX)!)
        default:
            return  NSLayoutConstraint()
        }
    }
    @discardableResult
    func equalTo(_ constant:CGFloat)->NSLayoutConstraint{
        switch type {
        case .left:
            return equalTo((target?.superview?.mm.left)!,constant:constant)
        case .right:
            return equalTo((target?.superview?.mm.right)!,constant:constant)
        case .leading:
            return equalTo((target?.superview?.mm.leading)!,constant:constant)
        case .trailing:
            return equalTo((target?.superview?.mm.trailing)!,constant:constant)
        case .centerX:
            return equalTo((target?.superview?.mm.centerX)!,constant:constant)
        default:
            return  NSLayoutConstraint()
        }
    }
    
    @discardableResult
    func equalTo(_ anchor:MMLayoutXItem)->NSLayoutConstraint{
        return equalTo(anchor, constant: 0.0)
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutXItem,constant:CGFloat)->NSLayoutConstraint{
        let cons = self.anchor.constraint(equalTo: anchor.anchor, constant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor:MMLayoutXItem) -> NSLayoutConstraint {
        return lessThanOrEqualTo(anchor, constant: 0.0)
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor:MMLayoutXItem,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.anchor.constraint(lessThanOrEqualTo: anchor.anchor,constant:constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor:MMLayoutXItem) -> NSLayoutConstraint {
        return greateThanOrEqualTo(anchor, constant: 0.0)
    }
    @discardableResult
    func greateThanOrEqualTo(_ anchor:MMLayoutXItem,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.anchor.constraint(lessThanOrEqualTo: anchor.anchor,constant:constant)
        target?.addMMItems(item: cons)
        return cons
    }
}
extension MMLayoutYItem{
    @discardableResult
    func equalToSuperView()->NSLayoutConstraint{
        switch type {
        case .top:
            return equalTo((target?.superview?.mm.top)!)
        case .bottom:
            return equalTo((target?.superview?.mm.bottom)!)
        case .centerY:
            return equalTo((target?.superview?.mm.centerY)!)
        case .safeTop:
            return equalTo((target?.superview?.mm.safeTop)!)
        case .safeBottom:
            return equalTo((target?.superview?.mm.safeBottom)!)
        default:
            return  NSLayoutConstraint()
        }
    }
    @discardableResult
    func equalTo(_ constant:CGFloat)->NSLayoutConstraint{
        switch type {
        case .top:
            return equalTo((target?.superview?.mm.top)!,constant:constant)
        case .bottom:
            return equalTo((target?.superview?.mm.bottom)!,constant:constant)
        case .safeTop:
            return equalTo((target?.superview?.mm.safeTop)!,constant:constant)
        case .safeBottom:
            return equalTo((target?.superview?.mm.safeBottom)!,constant:constant)
        case .centerY:
            return equalTo((target?.superview?.mm.centerY)!,constant:constant)
        default:
            return  NSLayoutConstraint()
        }
    }
    
    @discardableResult
    func equalTo(_ anchor:MMLayoutYItem)->NSLayoutConstraint{
        return equalTo(anchor, constant: 0.0)
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutYItem,constant:CGFloat)->NSLayoutConstraint{
        let cons = self.anchor.constraint(equalTo: anchor.anchor, constant: constant)
        cons.isActive = true
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor:MMLayoutYItem) -> NSLayoutConstraint {
        return lessThanOrEqualTo(anchor, constant: 0.0)
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor:MMLayoutYItem,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.anchor.constraint(lessThanOrEqualTo: anchor.anchor,constant:constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor:MMLayoutYItem) -> NSLayoutConstraint {
        return greateThanOrEqualTo(anchor, constant: 0.0)
    }
    @discardableResult
    func greateThanOrEqualTo(_ anchor:MMLayoutYItem,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.anchor.constraint(lessThanOrEqualTo: anchor.anchor,constant:constant)
        target?.addMMItems(item: cons)
        return cons
    }
}
extension MMLayoutDimension{
    @discardableResult
    func equalToSuperView() ->NSLayoutConstraint{
        if type == .width{
            return (target?.mm.width.equalTo((target?.superview)!))!
        }else{
            return (target?.mm.height.equalTo((target?.superview)!))!
        }
    }
    @discardableResult
    func equalTo(_ subview:ConstraintView) -> NSLayoutConstraint {
        if type == .width{
            return (target?.mm.width.equalTo(subview.mm.width))!
        }else{
            return (target?.mm.height.equalTo(subview.mm.height))!
        }
    }
    @discardableResult
    func equalTo(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(equalToConstant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutDimension) -> NSLayoutConstraint {
        return equalTo(anchor, multiplier: 1.0, constant: 0.0)
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutDimension,constant:CGFloat) -> NSLayoutConstraint {
        return equalTo(anchor, multiplier: 1.0, constant: constant)
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutDimension,multiplier:CGFloat) -> NSLayoutConstraint {
        return equalTo(anchor, multiplier: multiplier, constant: 0.0)
    }
    @discardableResult
    func equalTo(_ anchor:MMLayoutDimension,multiplier:CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(equalTo: anchor.dimension, multiplier: multiplier,constant:constant)
        target?.addMMItems(item: cons)
        return cons
    }
    
    @discardableResult
    func lessThanOrEqualToConstant(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(lessThanOrEqualToConstant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: MMLayoutDimension) -> NSLayoutConstraint {
        return lessThanOrEqualTo(anchor, multiplier: 1.0, constant: 0.0)
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: MMLayoutDimension,constant:CGFloat) -> NSLayoutConstraint {
        return lessThanOrEqualTo(anchor, multiplier: 1.0, constant: constant)
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: MMLayoutDimension, multiplier: CGFloat) -> NSLayoutConstraint {
        return lessThanOrEqualTo(anchor, multiplier: multiplier, constant: 0.0)
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: MMLayoutDimension, multiplier: CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(lessThanOrEqualTo: anchor.dimension, multiplier: multiplier, constant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
    
    
    @discardableResult
    func greaterThanOrEqualToConstant(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(greaterThanOrEqualToConstant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: MMLayoutDimension) -> NSLayoutConstraint {
        return greaterThanOrEqualTo(anchor, multiplier: 0.0, constant: 0.0)
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: MMLayoutDimension,constant:CGFloat) -> NSLayoutConstraint {
        return greaterThanOrEqualTo(anchor, multiplier: 0.0, constant: constant)
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: MMLayoutDimension, multiplier: CGFloat) -> NSLayoutConstraint {
        return greaterThanOrEqualTo(anchor, multiplier: multiplier, constant: 0.0)
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: MMLayoutDimension, multiplier: CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.dimension.constraint(greaterThanOrEqualTo: anchor.dimension, multiplier: multiplier, constant: constant)
        target?.addMMItems(item: cons)
        return cons
    }
}
