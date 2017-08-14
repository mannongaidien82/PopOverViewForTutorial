//
//  FirstViewController.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/17.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch = touches.first!
        let point = touch.location(in: self.view)
        print("Point\(point)")
        let image = UIImage(named: "niconico")
        let selectedRect = CGRect(origin: point, size: CGSize(width: 44, height: 44))
        let popover = TutorialPopOverViewController()
        popover.blackoutView = BlackoutView(parentView: self.view, fillColor: UIColor(white: 0.0, alpha: 0.6), cutOut: BlackoutViewCutOut.oval(rect: selectedRect))
        popover.image = image
        popover.popoverPresentationController?.sourceView = self.view
        popover.popoverPresentationController?.sourceRect = selectedRect
        popover.popoverPresentationController?.permittedArrowDirections = .any
        popover.popoverPresentationController?.popoverBackgroundViewClass = TutorialPopoverBackgroundView.self
        popover.preferredContentSize = CGSize(width: 200, height: 85)
        
        self.present(popover, animated: true, completion: nil)
    }
}

