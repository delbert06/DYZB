//
//  HomeViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/17.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

private let ktitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK: -懒加载属性
     lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStautusBarH + kNavigationBarH, width: kScreenW, height: ktitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
     lazy var pageContentView:PageContentView = {
        let contentH = kScreenH - kStautusBarH - kNavigationBarH - ktitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStautusBarH + kNavigationBarH + ktitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
//
//        for _ in 0..<4 {
//            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
//            childVCs.append(vc)
//        }
        let youxiVC = self.storyboard?.instantiateViewController(withIdentifier: "youxi")
        let tuijianVC = self.storyboard?.instantiateViewController(withIdentifier: "tuijian")
        let yuleVC = self.storyboard?.instantiateViewController(withIdentifier:"yule")
        let quwanVC = self.storyboard?.instantiateViewController(withIdentifier:"quwan")
        
        childVCs.append(youxiVC!)
        childVCs.append(tuijianVC!)
        childVCs.append(yuleVC!)
        childVCs.append(quwanVC!)
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

    
    //MARK: - 设置UI界面
    extension HomeViewController{
    func setupUI(){
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
    private func setNavigationBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        let size = CGSize(width: 40, height: 40)
        
        let his = UIBarButtonItem(imageName: "image_my_history", highImage: "Image_my_history_click", size: size)
        let scan = UIBarButtonItem(imageName: "Image_scan", highImage: "Image_scan_click", size: size)
        let search = UIBarButtonItem(imageName: "btn_search", highImage: "btn_search_clicked", size: size)
        
        navigationItem.rightBarButtonItems = [his,scan,search]
    }
}


//MARK: - 遵守PageTitleView协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitle(titleView: PageTitleView, selectedIndex Index: Int) {
        pageContentView.setCurrentIndex(currnetIndex: Index)
    }
}

extension HomeViewController : PageCollectViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
