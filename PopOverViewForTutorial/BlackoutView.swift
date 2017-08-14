//
//  BlackoutView.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/18.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

enum BlackoutViewCutOut {
    case rect(rect: CGRect)
    case roundedRect(rect: CGRect, cornerRadius: CGFloat)
    case oval(rect: CGRect)
}

class BlackoutView: UIView {
    
    fileprivate var fillColor:UIColor
    fileprivate var cutOuts:[BlackoutViewCutOut]
    
    init(parentView: UIView, fillColor:UIColor, cutOut:BlackoutViewCutOut) {
        self.fillColor = fillColor
        self.cutOuts = [cutOut]
        super.init(frame: parentView.frame)
        self.backgroundColor = UIColor.clear
        parentView.addSubview(self)
    }
    
    init(parentView: UIView, fillColor:UIColor, cutOuts:[BlackoutViewCutOut]) {
        self.fillColor = fillColor
        self.cutOuts = cutOuts
        super.init(frame: parentView.frame)
        self.backgroundColor = UIColor.clear
        parentView.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refresh(_ cutOuts:[BlackoutViewCutOut]) {
        self.cutOuts = cutOuts
        self.setNeedsDisplay()
    }

    func refreshForClearCutOuts() {
        self.refresh([])
    }

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.fillColor.setFill()
        UIRectFill(rect);
        let context = UIGraphicsGetCurrentContext()
        context?.setBlendMode(.destinationOut)
        for cutOut in self.cutOuts {
            var path:UIBezierPath!
            switch cutOut {
            case .rect(let cutOutRect):
                path = UIBezierPath(rect:cutOutRect)
                break
            case .roundedRect(let cutOutRect,let cutOutRectCornerRadius):
                path = UIBezierPath(roundedRect: cutOutRect, cornerRadius: cutOutRectCornerRadius)
                break
            case .oval(let cutOutRect):
                path = UIBezierPath(ovalIn:cutOutRect)
                break
            }
            path.fill()
        }
        context?.setBlendMode(.normal)
    }

}
