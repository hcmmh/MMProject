//
//  UIView+Extension.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/13.
//  Copyright © 2020年 hcmmh. All rights reserved.
//
import UIKit

typealias ConstraintView = UIView

extension ConstraintView{
    @available(iOS 9.0, *)
    var mm:ConstraintViewLayoutDSL{
        set{
            objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 10010), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get{
            var view = objc_getAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque().advanced(by: 10010))
            if view == nil{
                view = ConstraintViewLayoutDSL(view: self)
                self.mm = view as! ConstraintViewLayoutDSL
            }
            return view as! ConstraintViewLayoutDSL
        }
    }
    internal func getAddressKey(key:UInt)->UnsafeMutableRawPointer{
        return Unmanaged.passUnretained(self).toOpaque().advanced(by: Int(key))
    }
    internal func setCustomValue(_ value:Any,forKey:UnsafeMutableRawPointer){
        objc_setAssociatedObject(self, forKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    internal func getCustomValue(_ forKey:UnsafeMutableRawPointer)->Any?{
        return objc_getAssociatedObject(self, forKey)
    }
    func setMMConstraint(key:MMConstraintAttributes,value:NSLayoutConstraint) {
        addMMItems(item: value)
        setCustomValue(value, forKey: getAddressKey(key: key.rawValue))
    }
    func mmConstraint(key:MMConstraintAttributes) -> NSLayoutConstraint? {
        return getCustomValue(getAddressKey(key: key.rawValue)) as? NSLayoutConstraint ?? nil
    }
    private var items:UInt {
        return 10086
    }
    var mmLayoutItems:[NSLayoutConstraint]{
        set{
            objc_setAssociatedObject(self, getAddressKey(key: items), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            let obj = objc_getAssociatedObject(self, getAddressKey(key: items))
            if obj == nil{
                return [NSLayoutConstraint]()
            }
            return obj as! [NSLayoutConstraint]
        }
    }
    func addMMItems(item:NSLayoutConstraint) {
        item.isActive = true
        var list = mmLayoutItems
        list.append(item)
        mmLayoutItems = list
    }
}
public struct ConstraintViewLayoutDSL {
    internal let view:ConstraintView
    internal init(view:ConstraintView) {
        self.view = view
    }
    func makeConstraints(_ closure: makeClosure) {
        MMConstraintMaker.makeConstraints(item: self.view, closure: closure)
    }
    func removeConstraints() {
        MMConstraintMaker.removeConstraints(item: self.view)
    }
}
extension ConstraintViewLayoutDSL{
    var width:MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .width)
    }
    var height:MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .height)
    }
    var size:MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .size)
    }
    var left: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .left)
    }
    var right: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .right)
    }
    var leading: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .leading)
    }
    var trailing: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .trailing)
    }
    var centerX: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .centerX)
    }
    var top: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .top)
    }
    @available(iOS 11.0, *)
    var safeTop: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .safeTop)
    }
    @available(iOS 11.0, *)
    var safeBottom: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .safeBottom)
    }
    var bottom: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .bottom)
    }
    var centerY: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .centerY)
    }
    var edges: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .edges)
    }

    var center: MMLayoutItem{
        return MMLayoutItem.item(target: view, attributes: .center)
    }
}


