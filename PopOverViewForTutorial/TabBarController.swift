//
//  TabBarController.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/18.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        // Prevent UIBarButtonItem tintColor becoming gray when presenting popover.
        // see:http://stackoverflow.com/questions/31148852/uibarbuttonitem-doesnt-turn-gray-when-presenting-popover
        self.tabBar.tintAdjustmentMode = UIViewTintAdjustmentMode.Normal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension TabBarController:UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        let index = self.viewControllers!.indexOf(viewController)!.hashValue
        let image = UIImage(named: "pokemon")
        let selectedItem = orderedTabBarItemViews()[index]
        
        let selectedRect = CGRectMake(self.tabBar.frame.minX + selectedItem.frame.minX, self.tabBar.frame.minY + selectedItem.frame.minY,selectedItem.frame.width, selectedItem.frame.height)
        let popover = TutorialPopOverViewController()
        popover.blackoutView = BlackoutView(parentView: self.view, fillColor: UIColor(white: 0.0, alpha: 0.6), cutOut: BlackoutViewCutOut.roundedRect(rect: selectedRect, cornerRadius: 3))
        popover.image = image
        popover.popoverPresentationController?.sourceView = self.view
        popover.popoverPresentationController?.sourceRect = selectedRect
        popover.popoverPresentationController?.permittedArrowDirections = .Any
        popover.popoverPresentationController?.popoverBackgroundViewClass = TutorialPopoverBackgroundView.self
        popover.preferredContentSize = CGSize(width: 200, height: 85)
        
        self.presentViewController(popover, animated: true, completion:{            
        })
    }
    
    private func orderedTabBarItemViews() -> [UIView] {
        let interactionViews = tabBar.subviews.filter({$0.userInteractionEnabled})
        return interactionViews.sort({$0.frame.minX < $1.frame.minX})
    }
}
