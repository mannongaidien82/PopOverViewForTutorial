//
//  TutorialPopoverBackgroundView.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/18.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

let ARROW_BASE:CGFloat = 30.0

class TutorialPopoverBackgroundView: UIPopoverBackgroundView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let arrowView:BalloonArrowView
    let backgroundView = UIView(frame: CGRectMake(0, 0, 0, 0))
    
    var _arrowOffset:CGFloat = 0
    var _arrowDirection:UIPopoverArrowDirection = UIPopoverArrowDirection.Any
    
    override init(frame: CGRect) {
        self.arrowView = BalloonArrowView(width:ARROW_BASE, height:ARROW_BASE)
        super.init(frame: frame)
        self.backgroundView.backgroundColor = UIColor.whiteColor()
        self.backgroundView.layer.cornerRadius = 10.0
        self.backgroundView.clipsToBounds = true
        self.addSubview(self.backgroundView)
        self.addSubview(self.arrowView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override static func arrowBase() -> CGFloat {
        return ARROW_BASE/2
    }
    
    override static func arrowHeight() -> CGFloat {
        return ARROW_BASE/2
    }
    
    override static func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override var arrowOffset : CGFloat {
        get {
            return self._arrowOffset
        }
        set {
            self._arrowOffset = newValue
        }
    }
    
    /* `arrowDirection` manages which direction the popover arrow is pointing. You may be required to change the direction of the arrow while the popover is still visible on-screen.
     */
    override var arrowDirection: UIPopoverArrowDirection {
        get {
            return self._arrowDirection
        }
        set {
            self._arrowDirection = newValue
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var height = self.frame.size.height;
        var width = self.frame.size.width;
        var left:CGFloat = 0.0;
        var top:CGFloat = 0.0;
        var coordinate:CGFloat = 0.0;
        var rotation = CGAffineTransformIdentity;
        
        
        switch (self.arrowDirection) {
        case UIPopoverArrowDirection.Up:
            top += arrowView.arrowHeight;
            height -= arrowView.arrowHeight;
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            self.arrowView.frame = CGRectMake(coordinate, 0, ARROW_BASE, arrowView.arrowHeight);
            break;
            
            
        case UIPopoverArrowDirection.Down:
            height -= arrowView.arrowHeight;
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            arrowView.frame = CGRectMake(coordinate, height, ARROW_BASE, arrowView.arrowHeight);
            rotation = CGAffineTransformMakeRotation( CGFloat (M_PI) );
            break;
            
        case UIPopoverArrowDirection.Left:
            left += ARROW_BASE;
            width -= ARROW_BASE;
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.arrowHeight/2);
            arrowView.frame = CGRectMake(0, coordinate, ARROW_BASE, arrowView.arrowHeight);
            rotation = CGAffineTransformMakeRotation( -1 * CGFloat (M_PI_2) );
            break;
            
        case UIPopoverArrowDirection.Right:
            width -= ARROW_BASE;
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.arrowHeight/2);
            arrowView.frame = CGRectMake(width, coordinate, ARROW_BASE, arrowView.arrowHeight);
            rotation = CGAffineTransformMakeRotation( CGFloat (M_PI_2) );
            break;
            
        default:
            break
        }
        
        self.layer.shadowColor = UIColor.clearColor().CGColor
        self.backgroundView.frame = CGRectMake(left, top, width, height)
        self.arrowView.transform = rotation
    }
}
