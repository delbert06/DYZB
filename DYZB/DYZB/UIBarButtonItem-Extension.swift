//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 胡迪 on 2016/10/17.
//  Copyright © 2016年 D.Huhu. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    convenience init(imageName:String,highImage:String = "",size:CGSize = CGSize.zero) {
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImage != "" {
            btn.setImage(UIImage(named:highImage), for: .highlighted)
        }
       
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView:btn)
    }
}
