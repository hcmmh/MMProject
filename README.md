# MMProject
# 随便搞一下HUD
### 1、Loading
```
显示
MMProgressHUD.showHUDonView(view: self.view, animated: true)
隐藏
MMProgressHUD.hideHUD(view: self.view, animated: true)
```

### 2、Text
```
let hud = MMProgressHUD.showHUDonView(view: self.view, animated: true)
hud.model = .Text
hud.title = "那就这样吧"
// delay 时间后自动隐藏
hud.hideHUD(view: self.view, delay: 2)
```
 
 ### 3、RoundProgress(圆形进度)和Progress
```
let hud = MMProgressHUD.showHUDonView(view: self.view, animated: true)
hud.model = .RoundProgress// .Progress
Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
    // 设置显示进度
    hud.progress = hud.progress+0.01
    if hud.progress>=1.0{
    MMProgressHUD.hideHUD(view: self.view, animated: true)
        t.invalidate()
    }
}
```


### 4、Custom - 自定义view
```
显示
let hud = MMProgressHUD.showHUDonView(view: self.view, animated: true)
hud.model = .Custom
let c = UIView()
c.backgroundColor = UIColor.red
hud.customView = c
hud.title = "提交成功"
hud.hideHUD(view: self.view, delay: 2)
```

# MMLayout
### 仿照snapkit 封装NSLayoutAnchor
### 简化NSLayoutAnchor的使用
### 使用方法和snapkit类似
```
let edgesView = self.edgesUI()
let subview = UIView()
self.view.addSubview(subview)
subview.backgroundColor = UIColor.green
subview.mm.makeConstraints({
    $0.center.equalToSuperView()
    $0.size.lessThanOrEqualTo(edgesView,cons:-25)
})
func edgesUI()->UIView{
    let edgesView=UIView()
    self.view.addSubview(edgesView)
    edgesView.backgroundColor = UIColor.red
    edgesView.mm.makeConstraints { (make) in
        make.top.equalTo(view.mm.safeTop, cons: 120)
        make.centerX.equalToSuperView()
        make.width.equalTo(self.view, multiplier: 0.7)
        make.height.equalTo(100)
    }
    let subview = UIView()
    edgesView.addSubview(subview)
    subview.backgroundColor = UIColor.cyan
    subview.mm.makeConstraints({
        $0.edges.equalTo(10)
    })
    return edgesView
}

// 等分
func bisection(){
    let sectionView = UIView()
    self.view.addSubview(sectionView)
    sectionView.mm.makeConstraints({
        $0.top.equalTo(view.mm.safeTop)
        $0.left.right.equalTo(15)
        $0.height.equalTo(100)
    })
    sectionView.backgroundColor = UIColor.blue
    var temp:UIView?
    for i in 0...3 {
        let subview = UIView()
        sectionView.addSubview(subview)
        subview.backgroundColor = UIColor.black
        subview.mm.makeConstraints({
            $0.centerY.equalToSuperView()
            $0.height.equalTo(sectionView, multiplier: 0.5)
        if temp == nil{
            $0.leading.equalTo(15)
        }else{
            $0.width.equalTo(temp)
            $0.leading.equalTo(temp?.mm.trailing, cons: 20)
        }
        if i == 3{
            $0.trailing.equalTo(15)
        }
    })
    temp = subview
}
```

<img src="http://honchuang.cn/attachment/20200518/b3b4b16ade05421598d79ee89650af29.png" alt="example"/>


具体代码运行效果请下载项目运行查看
