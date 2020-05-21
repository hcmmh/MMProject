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
    public var center: MMMakerExtendable {
        self.description.attributes += .centerX
        self.description.attributes += .centerY
        return self
    }
    public var edges: MMMakerExtendable {
        self.description.attributes += .left
        self.description.attributes += .right
        self.description.attributes += .top
        self.description.attributes += .bottom

        return self
    }
    public var size: MMMakerExtendable {
        self.description.attributes += .height
        self.description.attributes += .width
        return self
    }
    public var firstBaseline: MMMakerExtendable {
        self.description.attributes += .firstBaseline
        return self
    }
    public var lastBaseline: MMMakerExtendable {
        self.description.attributes += .lastBaseline
        return self
    }
     let description: MMConstraintDescription
    
     init(_ description: MMConstraintDescription) {
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
    func equalTo(_ other:MMConstraintTarget?,multiplier:CGFloat, cons:MMConstraintTarget,type:Int = 0){
        let item = self.description.item as AnyObject
        if other == nil {
            for i in self.description.attributes.layoutAttributes{
                MMLayoutItem.item(target: item, attributes: i).equalTo(nil, multiplier: multiplier, cons: cons.constant,type: type)
            }
        }else{
            if let v = other as? CGSize{
                if self.description.attributes.contains(.width){
                    MMLayoutItem.item(target: item, attributes: .width).equalTo(nil, multiplier: multiplier, cons: v.width,type: type)
                }
                if self.description.attributes.contains(.height){
                    MMLayoutItem.item(target: item, attributes: .height).equalTo(nil, multiplier: multiplier, cons: v.height,type: type)
                }
            }
            if let v = other as? CGPoint{
                if self.description.attributes.contains(.centerX){
                    MMLayoutItem.item(target: item, attributes: .centerX).equalTo(nil, multiplier: multiplier, cons: v.x)
                }
                if self.description.attributes.contains(.centerY){
                    MMLayoutItem.item(target: item, attributes: .centerY).equalTo(nil, multiplier: multiplier, cons: v.y)
                }
            }
            if let v = other as? MMLayoutItem{
                for i in self.description.attributes.layoutAttributes{
                    MMLayoutItem.item(target: item, attributes: i).equalTo(v, multiplier: multiplier, cons: cons.constant,type: type)
                }
            }
            if let v = other as? ConstraintView{
                for i in self.description.attributes.layoutAttributes{
                    MMLayoutItem.item(target: item, attributes: i).equalTo(MMLayoutItem.item(target: v, attributes: i), multiplier: multiplier, cons: cons.constant,type: type)
                }
            }
        }
    }
    func lessThanOrEqualTo(_ other:MMConstraintTarget?){
        if let other = other as? MMLayoutItem{
            lessThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? ConstraintView{
            lessThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGSize{
            lessThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGPoint{
            lessThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else{
            lessThanOrEqualTo(nil, multiplier: 1, cons: (other?.constant)!)
        }
    }
    func lessThanOrEqualToSuperView(){
        lessThanOrEqualTo(self.description.item.superview, cons: 0)
    }
    func lessThanOrEqualTo(_ other:MMConstraintTarget?, cons:MMConstraintTarget){
        lessThanOrEqualTo(other, multiplier: 1, cons: cons)
    }
    func lessThanOrEqualTo(_ other:MMConstraintTarget?,multiplier:CGFloat){
        lessThanOrEqualTo(other, multiplier: multiplier, cons: 0)
    }
    func lessThanOrEqualTo(_ other:MMConstraintTarget?,multiplier:CGFloat, cons:MMConstraintTarget){
        equalTo(other, multiplier: multiplier, cons: cons, type: 1)
    }
    func greatThanOrEqualTo(_ other:MMConstraintTarget?){
        if let other = other as? MMLayoutItem{
            greatThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? ConstraintView{
            greatThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGSize{
            greatThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else if let other = other as? CGPoint{
            greatThanOrEqualTo(other, multiplier: 1, cons: 0)
        }else{
            greatThanOrEqualTo(nil, multiplier: 1, cons: (other?.constant)!)
        }
    }
    func greatThanOrEqualToSuperView(){
        greatThanOrEqualTo(self.description.item.superview, cons: 0)
    }
    func greatThanOrEqualTo(_ other:MMConstraintTarget?, cons:MMConstraintTarget){
        greatThanOrEqualTo(other, multiplier: 1, cons: cons)
    }
    func greatThanOrEqualTo(_ other:MMConstraintTarget?,multiplier:CGFloat){
        greatThanOrEqualTo(other, multiplier: multiplier, cons: 0)
    }
    func greatThanOrEqualTo(_ other:MMConstraintTarget?,multiplier:CGFloat, cons:MMConstraintTarget){
        equalTo(other, multiplier: multiplier, cons: cons, type: 2)
    }
}
