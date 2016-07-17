//
//  TutorialPopOverViewController.swift
//  PopOverViewForTutorial
//
//  Created by HikaruSato on 2016/07/17.
//  Copyright © 2016年 HikaruSato. All rights reserved.
//

import UIKit

class TutorialPopOverViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var image:UIImage?
    
    convenience init() {
        self.init(nibName: "TutorialPopOverViewController", bundle: NSBundle.mainBundle())
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.modalPresentationStyle = .Popover
        self.popoverPresentationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.popoverPresentationController?.backgroundColor = self.view.backgroundColor
        self.imageView.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let view = self.popoverPresentationController!.presentedView()!
        let col = view.performSelector(Selector("popoverBackgroundColor"))
        print("\(col)")
        let backgroundView = view.performSelector(Selector("backgroundView")).takeUnretainedValue() as! UIPopoverBackgroundView
        let arrowOffset = backgroundView.arrowOffset
        print("backgroundView.arrowOffset:\(arrowOffset)")
        switch self.popoverPresentationController!.arrowDirection {
        case UIPopoverArrowDirection.Up:
            let offset = arrowOffset/view.frame.width
            view.layer.anchorPoint = CGPoint(x: 0.5 + offset, y: 0)
            break;
        case UIPopoverArrowDirection.Down:
            let offset = arrowOffset/view.frame.width
            view.layer.anchorPoint = CGPoint(x: 0.5 + offset, y: 1)
            break;
        case UIPopoverArrowDirection.Left:
            let offset = arrowOffset/view.frame.height
            view.layer.anchorPoint = CGPoint(x: 0, y: 0.5 + offset)
            break;
        case UIPopoverArrowDirection.Right:
            let offset = arrowOffset/view.frame.height
            view.layer.anchorPoint = CGPoint(x: 1, y: 0.5 + offset)
            break;
        default:
            break;
        }
        
        view.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            view.transform = CGAffineTransformIdentity
            }) { (_) in
                
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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

extension TutorialPopOverViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
