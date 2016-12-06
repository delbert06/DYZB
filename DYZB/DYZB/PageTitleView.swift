//
//  PageTitleView.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/18.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

// MARK: - 定义协议
protocol PageTitleViewDelegate : class {
    func pageTitle(titleView : PageTitleView,selectedIndex Index : Int)
}

// MARK: - 定义常量
let kScrollLineH:CGFloat = 2
let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85) // 元祖 85,85,85 灰色
let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK: - 定义PageTitleView类
class PageTitleView: UIView {
    
    //MARK: - 定义属性
    var titles : [String]
    var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()

    lazy var titleLabels:[UILabel] = [UILabel]()
    
    //MARK: - 构造函数
    init(frame : CGRect,titles : [String]) {
        self.titles = titles
        
        super.init(frame:frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageTitleView {
    func setUpUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setupLabels()
        setupBottomMenuAndScrollLine()
    }
    
    private func setupLabels() {
        let labelY : CGFloat = 0
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelW:CGFloat = frame.width / CGFloat(titles.count)

        for (index,title) in titles.enumerated(){
            // 1.创建lable
            let label = UILabel()
            
            // 2.设置lable的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            //.0的意思是取出元祖的第一个元素
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4. 将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 5.给Label添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    func setupBottomMenuAndScrollLine() {
        // 1.添加底线
        let buttonline = UIView()
        buttonline.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        buttonline.frame = CGRect(x: 0, y: frame.height - lineH, width: bounds.width, height: lineH)
        addSubview(buttonline)
        
        scrollView.addSubview(scrollLine)
        
        guard let fristLabel = titleLabels.first else{
            print("不在setupLabels里增加titleLabels.append(label)就执行此方法")
            return }
        fristLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: fristLabel.frame.origin.x, y: frame.height - kScrollLineH, width:fristLabel.frame.width , height: kScrollLineH)
    }
}


//MARK: - 监听label的点击
extension PageTitleView{
    @objc func titleLabelClick(tap:UITapGestureRecognizer){
        
        //1 获取当前label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        //2 获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //3 切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4 保存新的label的下标值
        currentIndex = currentLabel.tag
        
        //5 滚动条位置的改变
        let scrollLinePostion = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15){
            self.scrollLine.frame.origin.x = scrollLinePostion
        }
        
        //6 通知代理
        delegate?.pageTitle(titleView: self, selectedIndex: currentLabel.tag)
    }
}


//MARK: - 对外暴露的方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat,sourceIndex : Int,targetIndex : Int){
        // 1. 取出souceLabel/targetIndex
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2. 处理滑块
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3. 颜色处理
        // 3.1 取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        
        // 3.2 变化sourceLable
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.3 变化targetLable
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        // 4. 记录最新的index
        currentIndex = targetIndex
    }
}
