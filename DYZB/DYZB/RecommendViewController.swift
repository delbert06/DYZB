//
//  RecommendViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2016/12/7.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

let kItemMargin :CGFloat = 10
let kItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kItemW * 3 / 4
let kNormalCellID = "kNormalCellID"
let kHeadView : CGFloat = 50
let kHeaderViewID = "kHeaderViewID"

let kPrettyItemH = kItemW * 4 / 3
let kPrettyCellID = "kPrettyCellID"

class RecommendViewController: UIViewController {
    // MARK: - 懒加载ViewModel
    lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    // MARK: - 懒加载属性
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1. 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //为了防止超出屏幕范围(没有随着父控件缩小而缩小，Tabbar占据了一部分)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadView)
        // 边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2. 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]  // 排版自动布局
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName:"NormalCollectionCell",bundle:nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"PrettyCollectionViewCell",bundle:nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName:"CollectionHeaderView",bundle:nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RecommendViewController{
    func setupUI(){
        view.addSubview(collectionView)
    }
}

extension RecommendViewController :UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewModel.anchorGroups[section]
        
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 获取模型
        let group = recommendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        // 2. 定义cell
        var cell : CollectionBaseCell!
        
        // 3. 获取cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCollectionViewCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! NormalCollectionCell
        }
        
        cell.anchor = anchor
        
        return cell
    }
    
    // 头部view的实现
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出section的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.white

        // 2. 取出模型
        headerView.group = recommendViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else{
            return CGSize(width: kItemW, height: kNormalItemH)
        }
    }
}

// MARK: - 网络请求
extension RecommendViewController{
    func loadData(){
        recommendViewModel.requestData { 
            self.collectionView.reloadData()
        }
    }
}
