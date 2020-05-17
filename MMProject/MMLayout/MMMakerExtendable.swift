//
//  MMMakerExtendable.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/17.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

public protocol MMMakerConstraintExtendable{}
public class MMMakerExtendable:MMMakerConstraintExtendable{
    public var left: MMMakerExtendable {
        self.description.attributes += .left
        return self
    }
    public var top: MMMakerExtendable {
        self.description.attributes += .top
        return self
    }
    public var bottom: MMMakerExtendable {
        self.description.attributes += .bottom
        return self
    }
    public var right: MMMakerExtendable {
        self.description.attributes += .right
        return self
    }
    public var leading: MMMakerExtendable {
        self.description.attributes += .leading
        return self
    }
    public var trailing: MMMakerExtendable {
        self.description.attributes += .trailing
        return self
    }
    public var width: MMMakerExtendable {
        self.description.attributes += .width
        return self
    }
    public var height: MMMakerExtendable {
        self.description.attributes += .height
        return self
    }
    public var centerX: MMMakerExtendable {
        self.description.attributes += .centerX
        return self
    }
    public var centerY: MMMakerExtendable {
        self.description.attributes += .centerY
        return self
    }
    public var edges: MMMakerExtendable {
        self.description.attributes += .edges
        return self
    }
    public var size: MMMakerExtendable {
        self.description.attributes += .size
        return self
    }
    internal let description: MMConstraintDescription
    
    internal init(_ description: MMConstraintDescription) {
        self.description = description
    }
  
    func equalTo(_ other:MMConstraintTarget?){
        if let other = other as? MMLayoutItem{
            equalTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? ConstraintView{
            equalTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGSize{
            equalTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGPoint{
            equalTo(other, multiplier: 1, cons: 0)
        }else{
            equalTo(nil, multiplier: 1, cons: (other?.constant)!)
        }
    }
    func equalToSuperView(){
        equalTo(self.description.item.superview, cons: 0)
    }
    func equalTo(_ other:MMConstraintTarget?, cons:MMConstraintTarget){
        equalTo(other, multiplier: 1, cons: cons)
    }
    func equalTo(_ other:MMConstraintTarget?,multiplier:CGFloat){
        equalTo(other, multiplier: multiplier, cons: 0)
    }
    func equalTo(_ other:MMConstraintTarget?,multiplier:CGFloat, cons:MMConstraintTarget){
        if other == nil {
            for i in self.description.attributes.layoutAttributes{
                if i == .edges{
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .left).equalTo(nil, multiplier: multiplier, cons: cons.constant)
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .right).equalTo(nil, multiplier: multiplier, cons: -cons.constant)
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .top).equalTo(nil, multiplier: multiplier, cons: cons.constant)
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .bottom).equalTo(nil, multiplier: multiplier, cons: -cons.constant)
                }else{
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: i).equalTo(nil, multiplier: multiplier, cons: cons.constant)
                }
            }
        }else{
            if let v = other as? ConstraintView{
                for i in self.description.attributes.layoutAttributes{
                    if i == .size{
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .width).equalTo(v.mm.width, multiplier: multiplier, cons: 0)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .height).equalTo(v.mm.height, multiplier: multiplier, cons: 0)
                    }else if(i == .edges){
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .left).equalTo(v.mm.left, multiplier: multiplier, cons: cons.constant)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .right).equalTo(v.mm.right, multiplier: multiplier, cons: -cons.constant)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .top).equalTo(v.mm.top, multiplier: multiplier, cons: cons.constant)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .bottom).equalTo(v.mm.bottom, multiplier: multiplier, cons: -cons.constant)
                    }else if(i == .center){
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .centerX).equalTo(v.mm.centerX, multiplier: multiplier, cons:cons.constant)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .centerY).equalTo(v.mm.centerY, multiplier: multiplier, cons: cons.constant)
                    }else{
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: i).equalTo(MMLayoutItem.item(target: v, attributes: i), multiplier: multiplier, cons: cons.constant)
                    }
                }
            }
            if let v = other as? CGSize{
                if self.description.attributes == .size{
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .width).equalTo(nil, multiplier: multiplier, cons: v.width)
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .height).equalTo(nil, multiplier: multiplier, cons: v.height)
                }
            }
            if let v = other as? CGPoint{
                if self.description.attributes == .center{
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .centerX).equalTo(nil, multiplier: multiplier, cons: v.x)
                    MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .centerY).equalTo(nil, multiplier: multiplier, cons: v.y)
                }
            }
            if let v = other as? MMLayoutItem{
                for i in self.description.attributes.layoutAttributes{
                    if i == .size{
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .width).equalTo(v, multiplier: multiplier, cons: 0)
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: .height).equalTo(v, multiplier: multiplier, cons: 0)
                    }else{
                        MMLayoutItem.item(target: self.description.item as AnyObject, attributes: i).equalTo(v, multiplier: multiplier, cons: cons.constant)
                    }
                }
            }
            
        }
    }
}
