//
//  RoundButton.swift
//  ZichenWang-Lab3
//
//  Created by 王梓辰 on 7/1/20.
//  Copyright © 2020 Zichen Wang. All rights reserved.
//

import Foundation
import UIKit


/*
 this class credits to a swift blog from
 https://blog.supereasyapps.com/how-to-create-round-buttons-using-ibdesignable-on-ios-11/
 */
@IBDesignable class RoundButton : UIButton{

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }

    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
}
