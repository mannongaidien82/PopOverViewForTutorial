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
    var image:UIImage!
    var blackoutView:BlackoutView?
    
    fileprivate var showedAnimation:Bool = false
    
    convenience init() {
        self.init(nibName: "TutorialPopOverViewController", bundle: Bundle.main)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup() {
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.popoverPresentationController?.backgroundColor = UIColor.clearColor()//self.view.backgroundColor
        self.imageView.image = self.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.showedAnimation {
            self.showedAnimation = true
            self.showAnimation()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.animate(withDuration: 0.2, animations: {
            self.blackoutView?.alpha = 0
        }, completion: { (_) in
            self.blackoutView?.removeFromSuperview()
        }) 
        
        let view = self.popoverPresentationController!.presentedView!
        UIView.animate(withDuration: 0.3, animations: {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (_) in
            view.isHidden = true
        }) 
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func showAnimation() {
        let view = self.popoverPresentationController!.presentedView!
        let backgroundView = view.perform(#selector(getter: UICollectionView.backgroundView)).takeUnretainedValue() as! UIPopoverBackgroundView
        let arrowOffset = backgroundView.arrowOffset
        switch self.popoverPresentationController!.arrowDirection {
        case UIPopoverArrowDirection.up:
            let offset = arrowOffset/view.frame.width
            view.layer.anchorPoint = CGPoint(x: view.layer.anchorPoint.x + offset, y: 0)
            break;
        case UIPopoverArrowDirection.down:
            let offset = arrowOffset/view.frame.width
            view.layer.anchorPoint = CGPoint(x: view.layer.anchorPoint.x + offset, y: 1)
            break;
        case UIPopoverArrowDirection.left:
            let offset = arrowOffset/view.frame.height
            view.layer.anchorPoint = CGPoint(x: 0, y: view.layer.anchorPoint.y + offset)
            break;
        case UIPopoverArrowDirection.right:
            let offset = arrowOffset/view.frame.height
            view.layer.anchorPoint = CGPoint(x: 1, y: view.layer.anchorPoint.y + offset)
            break;
        default:
            break;
        }
        print("view.layer.anchorPoint\(view.layer.anchorPoint)")
        view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            view.transform = CGAffineTransform.identity
        }) { (_) in
        }
        
        
//        
//        var delay = 3.0 * Double(NSEC_PER_SEC)
//        var time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        dispatch_after(time, dispatch_get_main_queue(), {
//            self.blackoutView?.refreshForClearCutOuts()
//        })
    }
}

extension TutorialPopOverViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
