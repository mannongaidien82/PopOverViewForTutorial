//
//  BalloonArrowView.swift
//  PPopOverViewForTutorial
//
//  Created by grachro on 2016/06/11.
//

import UIKit

class BalloonArrowView: UIView {
    
    let arrowWidth:CGFloat
    let arrowHeight:CGFloat
    
    init(width: CGFloat, height: CGFloat) {
        arrowWidth = width
        arrowHeight = height
        super.init(frame: CGRect(x: 0, y: 0, width: arrowWidth, height: arrowHeight))
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let x:CGFloat = arrowWidth / 2
        let y:CGFloat = 0
        
        let path = UIBezierPath();
        path.moveToPoint(CGPointMake(x, y));
        path.addLineToPoint(CGPointMake(x+arrowWidth/3, y+arrowHeight*2/3));
        path.addLineToPoint(CGPointMake(x-arrowWidth/3, y+arrowHeight*2/3));
        path.closePath()
        UIColor.whiteColor().setFill()
        path.fill();
    }
}
