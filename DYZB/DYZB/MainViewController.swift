//
//  MainViewController.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/17.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addchildVC(stroryboardName: "Home")
        addchildVC(stroryboardName: "Live")
        addchildVC(stroryboardName: "Follow")
        addchildVC(stroryboardName: "Profile")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addchildVC(stroryboardName:String){
        let childVC = UIStoryboard(name: stroryboardName, bundle: nil).instantiateInitialViewController()!
        
        addChildViewController(childVC)
    }

}
