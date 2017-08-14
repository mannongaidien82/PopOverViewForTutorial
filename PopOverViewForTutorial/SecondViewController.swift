//
//  SecondViewController.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/17.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tapLeftTopButton(_ sender: AnyObject) {
        let button = sender as! UIButton
        let image = UIImage(named: "niconico")
        let selectedRect = CGRect(x: button.frame.origin.x-5, y: button.frame.origin.y-5, width: button.frame.width+10, height: button.frame.height+10)
        let popover = TutorialPopOverViewController()
        popover.blackoutView = BlackoutView(parentView: self.view, fillColor: UIColor(white: 0.0, alpha: 0.6), cutOut: BlackoutViewCutOut.roundedRect(rect: selectedRect, cornerRadius: 3))
        popover.image = image
        popover.popoverPresentationController?.sourceView = self.view
        popover.popoverPresentationController?.sourceRect = selectedRect
        popover.popoverPresentationController?.permittedArrowDirections = .any
        popover.popoverPresentationController?.popoverBackgroundViewClass = TutorialPopoverBackgroundView.self
        popover.preferredContentSize = CGSize(width: 200, height: 85)
        
        self.present(popover, animated: true, completion: {
            button.titleLabel?.textColor = UIColor.blue
        })
    }
    
}

