//
//  Helpers.swift
//  ProFive
//
//  Created by P5M on 25/08/17.
//  Copyright © 2017 P5M. All rights reserved.
//

import UIKit

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}

extension UIImageView {

public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {

       if self.image == nil{
             self.image = PlaceHolderImage
       }

       URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

           if error != nil {
               print(error ?? "No Error")
               return
           }
           DispatchQueue.main.async(execute: { () -> Void in
               let image = UIImage(data: data!)
               self.image = image
           })

       }).resume()
   }}

@objc public extension UIView {
    
    /**
    Returns the UIViewController object that manages the receiver.
    */
    @objc func viewContainingController() -> UIViewController? {
        
        var nextResponder: UIResponder? = self
        
        repeat {
            nextResponder = nextResponder?.next
            
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            
        } while nextResponder != nil
        
        return nil
    }
    
    /**
     Returns the UIViewController object that is actually the parent of this object. Most of the time it's the viewController object which actually contains it, but result may be different if it's viewController is added as childViewController of another viewController.
     */
    @objc func parentContainerViewController() -> UIViewController? {
        
        var matchController = viewContainingController()
        var parentContainerViewController: UIViewController?

        if var navController = matchController?.navigationController {
            
            while let parentNav = navController.navigationController {
                navController = parentNav
            }
            
            var parentController: UIViewController = navController

            while let parent = parentController.parent,
                (parent.isKind(of: UINavigationController.self) == false &&
                    parent.isKind(of: UITabBarController.self) == false &&
                    parent.isKind(of: UISplitViewController.self) == false) {
                        
                        parentController = parent
            }

            if navController == parentController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = parentController
            }
        } else if let tabController = matchController?.tabBarController {
            
            if let navController = tabController.selectedViewController as? UINavigationController {
                parentContainerViewController = navController.topViewController
            } else {
                parentContainerViewController = tabController.selectedViewController
            }
        } else {
            while let parentController = matchController?.parent,
                (parentController.isKind(of: UINavigationController.self) == false &&
                    parentController.isKind(of: UITabBarController.self) == false &&
                    parentController.isKind(of: UISplitViewController.self) == false) {
                        
                        matchController = parentController
            }

            parentContainerViewController = matchController
        }
        
        let finalController = parentContainerViewController
        
        return finalController
    }

    ///-----------------------------------
    /// MARK: Superviews/Subviews/Siglings
    ///-----------------------------------
    
    /**
    Returns the superView of provided class type.

     
     @param classType class type of the object which is to be search in above hierarchy and return
     
     @param belowView view object in upper hierarchy where method should stop searching and return nil
*/
    @objc func superviewOfClassType(_ classType: UIView.Type, belowView: UIView? = nil) -> UIView? {

        var superView = superview
        
        while let unwrappedSuperView = superView {
            
            if unwrappedSuperView.isKind(of: classType) {
                
                //If it's UIScrollView, then validating for special cases
                if unwrappedSuperView.isKind(of: UIScrollView.self) {
                    
                    let classNameString = NSStringFromClass(type(of: unwrappedSuperView.self))

                    //  If it's not UITableViewWrapperView class, this is internal class which is actually manage in UITableview. The speciality of this class is that it's superview is UITableView.
                    //  If it's not UITableViewCellScrollView class, this is internal class which is actually manage in UITableviewCell. The speciality of this class is that it's superview is UITableViewCell.
                    //If it's not _UIQueuingScrollView class, actually we validate for _ prefix which usually used by Apple internal classes
                    if unwrappedSuperView.superview?.isKind(of: UITableView.self) == false &&
                        unwrappedSuperView.superview?.isKind(of: UITableViewCell.self) == false &&
                        classNameString.hasPrefix("_") == false {
                        return superView
                    }
                } else {
                    return superView
                }
            } else if unwrappedSuperView == belowView {
                return nil
            }
            
            superView = unwrappedSuperView.superview
        }
        
        return nil
    }
}

extension UIColor {
    
    /**
     Creates a UIColor object for the given rgb value which can be specified
     as HTML hex color value. For example:
     
     let color = UIColor(rgb: 0x8046A2)
     let colorWithAlpha = UIColor(rgb: 0x8046A2, alpha: 0.5)
     
     - parameter rgb: color value as Int. To be specified as hex literal like 0xff00ff
     - parameter alpha: alpha optional alpha value (default 1.0)
     */
    
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((rgb & 0xff0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00ff00) >>  8) / 255
        let b = CGFloat((rgb & 0x0000ff)      ) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        let r = CGFloat(red) / 255
        let g = CGFloat(green) / 255
        let b = CGFloat(blue) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

@IBDesignable
public class MKActivityIndicator: UIView {
    
    
    private let drawableLayer = CAShapeLayer()
    var animating = false
    
    @IBInspectable public var color: UIColor = UIColor(hex: 0x2196F3) {
        didSet {
            drawableLayer.strokeColor = self.color.cgColor
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 6 {
        didSet {
            drawableLayer.lineWidth = self.lineWidth
            self.updatePath()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override var bounds: CGRect {
        didSet {
            updateFrame()
            updatePath()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
        updatePath()
    }
    
    public func startAnimating() {
        if self.animating {
            return
        }
        
        self.parentContainerViewController()?.view.isUserInteractionEnabled = false
        self.animating = true
        self.isHidden = false
        self.resetAnimations()
    }
    
    public func stopAnimating() {
        
        self.parentContainerViewController()?.view.isUserInteractionEnabled = true
        self.drawableLayer.removeAllAnimations()
        self.animating = false
        self.isHidden = true
    }
    
    private func setup() {
        self.isHidden = true
        self.layer.addSublayer(self.drawableLayer)
        self.drawableLayer.strokeColor = self.color.cgColor
        self.drawableLayer.lineWidth = self.lineWidth
        self.drawableLayer.fillColor = UIColor.clear.cgColor
        self.drawableLayer.lineCap = CAShapeLayerLineCap.round
        self.drawableLayer.strokeStart = 0.99
        self.drawableLayer.strokeEnd = 1
        updateFrame()
        updatePath()
    }
    
    private func updateFrame() {
        self.drawableLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
    }
    
    private func updatePath() {
        let center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        let radius = min(self.bounds.width, self.bounds.height) / 2 - self.lineWidth
        self.drawableLayer.path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(2 * Double.pi),
            clockwise: true)
            .cgPath
    }
    
    private func resetAnimations() {
        drawableLayer.removeAllAnimations()
        
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnim.fromValue = 0
        rotationAnim.duration = 4
        rotationAnim.toValue = 2 * Double.pi
        rotationAnim.repeatCount = Float.infinity
        rotationAnim.isRemovedOnCompletion = false
        
        let startHeadAnim = CABasicAnimation(keyPath: "strokeStart")
        startHeadAnim.beginTime = 0.1
        startHeadAnim.fromValue = 0
        startHeadAnim.toValue = 0.25
        startHeadAnim.duration = 1
        startHeadAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let startTailAnim = CABasicAnimation(keyPath: "strokeEnd")
        startTailAnim.beginTime = 0.1
        startTailAnim.fromValue = 0
        startTailAnim.toValue = 1
        startTailAnim.duration = 1
        startTailAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let endHeadAnim = CABasicAnimation(keyPath: "strokeStart")
        endHeadAnim.beginTime = 1
        endHeadAnim.fromValue = 0.25
        endHeadAnim.toValue = 0.99
        endHeadAnim.duration = 0.5
        endHeadAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let endTailAnim = CABasicAnimation(keyPath: "strokeEnd")
        endTailAnim.beginTime = 1
        endTailAnim.fromValue = 1
        endTailAnim.toValue = 1
        endTailAnim.duration = 0.5
        endTailAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let strokeAnimGroup = CAAnimationGroup()
        strokeAnimGroup.duration = 1.5
        strokeAnimGroup.animations = [startHeadAnim, startTailAnim, endHeadAnim, endTailAnim]
        strokeAnimGroup.repeatCount = Float.infinity
        strokeAnimGroup.isRemovedOnCompletion = false
        
        self.drawableLayer.add(rotationAnim, forKey: "rotation")
        self.drawableLayer.add(strokeAnimGroup, forKey: "stroke")
    }
}
