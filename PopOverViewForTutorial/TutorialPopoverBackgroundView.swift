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
    let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var _arrowOffset:CGFloat = 0
    var _arrowDirection:UIPopoverArrowDirection = UIPopoverArrowDirection.any
    
    override init(frame: CGRect) {
        self.arrowView = BalloonArrowView(width:ARROW_BASE, height:ARROW_BASE)
        super.init(frame: frame)
        self.backgroundView.backgroundColor = UIColor.white
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
        var rotation = CGAffineTransform.identity;
        
        
        switch (self.arrowDirection) {
        case UIPopoverArrowDirection.up:
            top += arrowView.arrowHeight;
            height -= arrowView.arrowHeight;
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            self.arrowView.frame = CGRect(x: coordinate, y: 0, width: ARROW_BASE, height: arrowView.arrowHeight);
            break;
            
            
        case UIPopoverArrowDirection.down:
            height -= arrowView.arrowHeight;
            coordinate = ((self.frame.size.width / 2) + self.arrowOffset) - (ARROW_BASE/2);
            arrowView.frame = CGRect(x: coordinate, y: height, width: ARROW_BASE, height: arrowView.arrowHeight);
            rotation = CGAffineTransform( rotationAngle: CGFloat (Double.pi) );
            break;
            
        case UIPopoverArrowDirection.left:
            left += ARROW_BASE;
            width -= ARROW_BASE;
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.arrowHeight/2);
            arrowView.frame = CGRect(x: 0, y: coordinate, width: ARROW_BASE, height: arrowView.arrowHeight);
            rotation = CGAffineTransform( rotationAngle: -1 * CGFloat (Double.pi/2) );
            break;
            
        case UIPopoverArrowDirection.right:
            width -= ARROW_BASE;
            coordinate = ((self.frame.size.height / 2) + self.arrowOffset) - (arrowView.arrowHeight/2);
            arrowView.frame = CGRect(x: width, y: coordinate, width: ARROW_BASE, height: arrowView.arrowHeight);
            rotation = CGAffineTransform( rotationAngle: CGFloat (Double.pi/2) );
            break;
            
        default:
            break
        }
        
        self.layer.shadowColor = UIColor.clear.cgColor
        self.backgroundView.frame = CGRect(x: left, y: top, width: width, height: height)
        self.arrowView.transform = rotation
        
        //This is Very Tricky!!! below codes hide background black views.
        if let window = UIApplication.shared.keyWindow {
            for v in window.subviews {
                if NSStringFromClass(type(of: v)) == "UITransitionView" {
                    for vv in v.subviews {
                        if NSStringFromClass(type(of: vv)) == "_UIMirrorNinePatchView" {
                            vv.isHidden = true
                        }
                    }
                }
            }
        }
    }
}
