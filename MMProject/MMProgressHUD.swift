//
//  MMProgressHUD.swift
//  MMProject
//
//  Created by hcmmh on 2020/5/11.
//  Copyright © 2020年 hcmmh. All rights reserved.
//

import UIKit

enum MMHUDModel {
    case Text // 纯文字提示
    case Loading // loading加载提示
    case Custom // 自定义标识
    case RoundProgress // 圆形加载进度提示
    case Progress // 条形进度提示
}

typealias doSomethings = () -> Void

class MMProgressHUD: UIView {
    // 提示文字
    var title:String {
        set{
            self.titleLabel.text = newValue
        }
        get{
            return self.titleLabel.text ?? "loading"
        }
    }
    fileprivate var blackColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)// default
    var finished:doSomethings?
    var progressLoading:doSomethings?
  
    var progress:Float = 0.0{
        didSet{
            if self.cycleProgress != nil {
                self.cycleProgress?.progress = progress
            }
            if self.progressView != nil {
                self.progressView?.progress = progress
            }
            let tip = String(format:"%.0f",progress*100)
            self.titleLabel.text = tip+"%"
        }
    }
    
    
    fileprivate var cycleProgress:CycleProgress?
    fileprivate var progressView:UIProgressView?
    
    fileprivate var titleLabel = UILabel()
    fileprivate var contentView = UIView()
    fileprivate var activityView:UIActivityIndicatorView?
    // 自定义标识类型为UIimageView 尺寸方形
    var customView:UIView?{
        didSet{
            setActivityViewlayout()
            setTextLabelLayout()
            setCustomViewLayout()
        }
    }
    // 默认loading加载提示
    var model:MMHUDModel = .Loading{
        didSet{
            setActivityViewlayout()
            setTextLabelLayout()
            setCustomViewLayout()
        }
    }
    fileprivate init(view:UIView) {
        super.init(frame: view.bounds)
        let size = self.bounds
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        self.commoninit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func showHUDonView(view:UIView,animated:Bool)->MMProgressHUD{
        let hud = MMProgressHUD.init(view: view)
        view.addSubview(hud)
        hud.showAnimated(animated: animated)
        return hud
    }
    static func hideHUD(view:UIView,animated:Bool){
        MMProgressHUD.removeHUD(view)
    }
    func hideHUD(view:UIView,delay:TimeInterval){
        let time = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { (t) in
            MMProgressHUD.removeHUD(view)
        }
        RunLoop.current.add(time, forMode: RunLoop.Mode.common)
    }
    static func removeHUD(_ view:UIView){
        var hud = self.getHUD(view)
        if hud != nil{
            if ((hud?.finished) != nil){
                hud?.finished!()
            }
            hud?.removeFromSuperview()
            hud = nil
        }
    }
    static func getHUD(_ view:UIView)->MMProgressHUD?{
        let subs = view.subviews.reversed()
        for temp in subs {
            if temp.isKind(of: self){
                return temp as? MMProgressHUD
            }
        }
        return nil
    }
    fileprivate func commoninit(){
        addObserver(self, forKeyPath: "model", options: .new, context: nil)
        // 整体背景色默认黑色半透
        self.backgroundColor = blackColor
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.8).isActive = true
        contentView.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor, multiplier: 0.3).isActive = true
        contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        // 中心区域背景色
        contentView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        // 菊花
        createActivityView()
        // 文本提示
        createLabel()
    }
    fileprivate func createActivityView(){
        let acview = UIActivityIndicatorView(style: .whiteLarge)
        acview.hidesWhenStopped = true
        acview.startAnimating()
        self.activityView = acview
    }
   
    fileprivate func createLabel(){
        let size = self.bounds
        let width = size.width/3
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.center.y = width-label.frame.height/2
        label.numberOfLines = 2
        label.text = self.title
        self.titleLabel = label
    }
    fileprivate func showAnimated(animated:Bool){
        setActivityViewlayout()
        setTextLabelLayout()
    }
    fileprivate func setActivityViewlayout(){
        let view:UIView? = self.activityView
        self.contentView.addSubview(view!)
        view?.translatesAutoresizingMaskIntoConstraints = false
        let w = view?.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
        let h = view?.heightAnchor.constraint(equalTo: self.contentView.widthAnchor,multiplier:0.5)
        let t = view?.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let x = view?.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        switch self.model {
        case .Text:
            view?.removeConstraints([w!,h!,t!,x!])
            view?.removeFromSuperview()
        case .Loading,.RoundProgress:
            w?.isActive = true; h?.isActive = true; t?.isActive = true; x?.isActive = true
        default:
            print(1)
        }
    }

    fileprivate func setTextLabelLayout(){
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:-10).isActive = true
        switch model {
        case .Loading:
            let top = titleLabel.topAnchor.constraint(equalTo: (activityView?.bottomAnchor)!,constant:5)
            top.isActive = true
        case .Text:
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant:10).isActive = true
        default:
            print("default")
        }
    }
    
    fileprivate func setCustomViewLayout(){
        switch self.model {
        case .Custom:
            guard self.customView != nil else{
                return
            }
            let view:UIView? = self.customView
            self.contentView.addSubview(view!)
            view?.translatesAutoresizingMaskIntoConstraints = false
            let size = view?.frame.size
            if size?.width == 0{
                view?.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7).isActive = true
                view?.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7).isActive = true
            }else{
                view?.widthAnchor.constraint(equalToConstant: self.bounds.width/4).isActive = true
                view?.heightAnchor.constraint(equalToConstant: (size?.height)! * self.bounds.width/4 / (size?.width)!).isActive = true
            }
           
            view?.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            view?.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            activityView?.removeFromSuperview()
            activityView = nil
            titleLabel.topAnchor.constraint(equalTo: view!.bottomAnchor,constant:10).isActive = true
        case .Progress:
            print("1")
            let pro = UIProgressView()
            self.contentView.addSubview(pro)
            pro.progress = 0.0
            activityView?.removeFromSuperview()
            activityView = nil
            pro.translatesAutoresizingMaskIntoConstraints = false
            pro.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.8).isActive = true
            pro.widthAnchor.constraint(greaterThanOrEqualTo: self.widthAnchor, multiplier: 0.3).isActive = true
            pro.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15).isActive = true
            pro.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15).isActive = true
            pro.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
            pro.heightAnchor.constraint(equalToConstant: 5).isActive = true
            pro.trackTintColor = UIColor.darkGray
            pro.tintColor = UIColor.white
            titleLabel.topAnchor.constraint(equalTo: pro.bottomAnchor,constant:10).isActive = true
            self.progressView = pro
        default:
            print("setCustomViewLayout default")
        }
    }
    
    override func layoutSubviews() {
        print("layoutSubviews")
        super.layoutSubviews()
        let maskPath = UIBezierPath.init(roundedRect: contentView.bounds, cornerRadius: 5)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = contentView.bounds
        maskLayer.path = maskPath.cgPath
        contentView.layer.mask = maskLayer
        if model == .RoundProgress {
            let pro = CycleProgress()
            self.contentView.addSubview(pro)
            pro.progress = 0.0
            activityView?.removeFromSuperview()
            activityView = nil
            pro.translatesAutoresizingMaskIntoConstraints = false
            let w = pro.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5)
            let h = pro.heightAnchor.constraint(equalTo: self.contentView.widthAnchor,multiplier:0.5)
            let t = pro.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
            let x = pro.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
            w.isActive = true; h.isActive = true; t.isActive = true; x.isActive = true
            titleLabel.topAnchor.constraint(equalTo: pro.bottomAnchor,constant:10).isActive = true
            self.cycleProgress = pro
        }
    }
    deinit{
        print("MMProgressHUD is deinit")
    }
}
private class CycleProgress: UIView {
    var progress: Float = 0 {
        didSet {
            if let layer = self.shapelayer {
                layer.strokeEnd = CGFloat(self.progress)
            }
        }
    }
    
    private var shapelayer: CAShapeLayer!
    private var didLayout = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard !self.didLayout else {
            return
        }
        self.didLayout = true
        
        let bl = CAShapeLayer()
        bl.frame = self.bounds
        bl.lineWidth = 4 // 圆弧的宽度
        bl.fillColor = nil // 填充颜色为空
        bl.strokeColor = UIColor.darkGray.cgColor // 描边颜色
        
        let b1 = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 3, dy: 3)) // 贝塞尔路径
        b1.apply(CGAffineTransform(translationX: -self.bounds.width / 2, y: -self.bounds.height / 2))
        b1.apply(CGAffineTransform(rotationAngle: -.pi/2.0))
        b1.apply(CGAffineTransform(translationX: self.bounds.width / 2, y: self.bounds.height / 2))
        bl.path = b1.cgPath
        self.layer.addSublayer(bl)
        bl.zPosition = -1
        bl.strokeStart = 0
        bl.strokeEnd = 1 // 使用这个模拟进度
        
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.lineWidth = 4 // 圆弧的宽度
        layer.fillColor = nil // 填充颜色为空
        layer.strokeColor = UIColor.white.cgColor // 描边颜色
        let b = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 3, dy: 3)) // 贝塞尔路径
        b.apply(CGAffineTransform(translationX: -self.bounds.width / 2, y: -self.bounds.height / 2))
        b.apply(CGAffineTransform(rotationAngle: -.pi/2.0))
        b.apply(CGAffineTransform(translationX: self.bounds.width / 2, y: self.bounds.height / 2))
        
        layer.path = b.cgPath
        self.layer.addSublayer(layer)
        layer.zPosition = -1
        layer.strokeStart = 0
        layer.strokeEnd = 0 // 使用这个模拟进度
        self.shapelayer = layer
    }
}
