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
    var mm:ConstraintViewDSL{
        return ConstraintViewDSL(view: self)
    }
    var mmLayoutConstraints:[NSLayoutConstraint]{
        var cons = objc_getAssociatedObject(self, "MMLayoutConstraints")
        if cons == nil{
            cons = [NSLayoutConstraint]()
        }
        return cons as! [NSLayoutConstraint]
    }
    func addConstraint(cons:NSLayoutConstraint) {
        var temp = Array<NSLayoutConstraint>()
        temp.append(contentsOf: mmLayoutConstraints)
        temp.append(cons)
        objc_setAssociatedObject(self, "MMLayoutConstraints", temp, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
}
extension NSLayoutAnchor{
    @objc func equalToSuperView() {
        
    }
}
extension NSLayoutAnchor{
    @objc @discardableResult
    func equalTo(_ anchor:NSLayoutAnchor)->NSLayoutConstraint{
        let cons = self.constraint(equalTo: anchor)
        cons.isActive = true
        return cons
    }
    @objc @discardableResult
    func equalTo(_ anchor:NSLayoutAnchor,constant:CGFloat)->NSLayoutConstraint{
        let cons = self.constraint(equalTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    @objc @discardableResult
    func lessThanOrEqualTo(_ anchor:NSLayoutAnchor) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor)
        cons.isActive = true
        return cons
    }
    @objc @discardableResult
    func lessThanOrEqualTo(_ anchor:NSLayoutAnchor,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor,constant:constant)
        cons.isActive = true
        return cons
    }
    @objc @discardableResult
    func greaterThanOrEqualTo(_ anchor:NSLayoutAnchor) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor)
        cons.isActive = true
        return cons
    }
    @objc @discardableResult
    func greateThanOrEqualTo(_ anchor:NSLayoutAnchor,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor,constant:constant)
        cons.isActive = true
        return cons
    }
}
extension NSLayoutDimension{
    @discardableResult
    func equalTo(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(equalToConstant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func equalTo(_ anchor:NSLayoutDimension,multiplier:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(equalTo: anchor, multiplier: multiplier)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func equalTo(_ anchor:NSLayoutDimension,multiplier:CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(equalTo: anchor, multiplier: multiplier,constant:constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: NSLayoutDimension, multiplier: CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: NSLayoutDimension) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func lessThanOrEqualTo(_ anchor: NSLayoutDimension,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func lessThanOrEqualToConstant(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(lessThanOrEqualToConstant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: NSLayoutDimension, multiplier: CGFloat,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: NSLayoutDimension) -> NSLayoutConstraint {
        let cons = self.constraint(greaterThanOrEqualTo: anchor)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func greaterThanOrEqualTo(_ anchor: NSLayoutDimension,constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func greaterThanOrEqualToConstant(_ constant:CGFloat) -> NSLayoutConstraint {
        let cons = self.constraint(greaterThanOrEqualToConstant: constant)
        cons.isActive = true
        return cons
    }
}
public struct ConstraintViewDSL {
    var target:AnyObject?{
        return self.view
    }
    internal let view:ConstraintView
    internal init(view:ConstraintView) {
        self.view = view
        print(Unmanaged.passUnretained(self as AnyObject).toOpaque())
    }
    func makeConstraints(_ closure: (_ make: ConstraintViewDSL) -> Void) {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        closure(self)
    }
    func remakeConstraints(_ closure: (_ make: ConstraintViewDSL) -> Void) {
        self.removeContraints()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        closure(self)
    }
    func removeContraints(){
        self.view.translatesAutoresizingMaskIntoConstraints = true
        self.view.removeConstraints(self.view.constraints)
    }
}
extension ConstraintViewDSL{
    var width:NSLayoutDimension{
        return self.view.widthAnchor
    }
    var height:NSLayoutDimension{
        return self.view.heightAnchor
    }
    var left: NSLayoutXAxisAnchor{
        return self.view.leftAnchor
    }
    var right: NSLayoutXAxisAnchor{
        return self.view.rightAnchor
    }
    var top: NSLayoutYAxisAnchor{
        return self.view.topAnchor
    }
    var bottom: NSLayoutYAxisAnchor{
        return self.view.bottomAnchor
    }
    var centerX:NSLayoutXAxisAnchor{
        return self.view.centerXAnchor
    }
    var centerY:NSLayoutYAxisAnchor{
        return self.view.centerYAnchor
    }
    var leading:NSLayoutXAxisAnchor{
        return self.view.leadingAnchor
    }
    var trailing:NSLayoutXAxisAnchor{
        return self.view.trailingAnchor
    }
}

