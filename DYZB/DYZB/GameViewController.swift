//
//  GameViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2017/1/3.
//  Copyright © 2017年 D.Huhu. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    
    // MARK: - 定义属性
    var groups : [GameModel]?{
        didSet{
            // 刷新表格
            collectionView.reloadData()
        }
    }
    
    // MARK: - 懒加载属性
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        
        // headerView
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
    }()
    fileprivate lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.collectionHeaderView()
        
        headerView.frame = CGRect(x: 0, y: -kHeaderViewH - kGameViewH, width: kScreenW, height: kHeaderViewH)
        headerView.headerImage.image = UIImage(named: "Img_orange")
        headerView.headerLabel.text = "常见"
        headerView.moreBtn.isHidden = true
        
        return headerView
        
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}

extension GameViewController{
    func loadData(){
        self.gameVM.loadGameData {
            // 1. 展示全部游戏数据
            self.collectionView.reloadData()
            // 2. 展示常用数据
//            var tempArray = [GameModel]()
//            for i in 0..<10{
//                tempArray.append(self.gameVM.games[i])
//            }
//            self.gameView.groups = tempArray
            // 上边方法比较复杂 用下边的
            self.gameView.groups = Array(self.gameVM.games[0..<10])
        }
    }
}
    // MARK:- 设置UI界面
extension GameViewController {
    fileprivate func setupUI() {
        // 1. 添加collectionView
        view.addSubview(collectionView)
        
        // 2. 添加headerView
        collectionView.addSubview(topHeaderView)
        
        // 3. 添加headerView内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        // 4. 将常用添加到collectionView
        collectionView.addSubview(gameView)
    }
}

    // MARK:- 遵守UICollectionView的数据源&代理
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameVM.games[indexPath.item]
        
        return cell
    }
    
    // 取出headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1. 取出headView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        // 2. 给headerView设置属性
        headerView.headerLabel.text = "全部"
        headerView.headerImage.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
}
