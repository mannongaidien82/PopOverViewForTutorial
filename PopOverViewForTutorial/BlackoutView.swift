//
//  BlackoutView.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/18.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

class BlackoutView: UIView {
    
    let fillColor:UIColor
    let framesToCutOut:[CGRect]
    
    init(parentView: UIView, fillColor:UIColor, framesToCutOut:[CGRect]) {
        self.fillColor = fillColor
        self.framesToCutOut = framesToCutOut
        super.init(frame: parentView.frame)
        self.backgroundColor = UIColor.clearColor()
        parentView.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        self.fillColor.setFill()
        UIRectFill(rect);
        let context = UIGraphicsGetCurrentContext()
        CGContextSetBlendMode(context, .DestinationOut)
        for pathRect in self.framesToCutOut {
            let path = UIBezierPath(ovalInRect: pathRect)
            path.fill()
        }
        CGContextSetBlendMode(context, .Normal)
    }

}
