//
//  RoundButton.swift
//  CameraApp1
//
//  Created by Rajita Pujare on 7/13/17.
//  Copyright © 2017 Rajita Pujare. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
        self.layer.cornerRadius = cornerRadius
    }
}
@IBInspectable var borderWidth: CGFloat = 2 {
    didSet {
        self.layer.borderWidth = borderWidth
    }
}
@IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
        self.layer.borderColor = borderColor.cgColor
    }


}
}
