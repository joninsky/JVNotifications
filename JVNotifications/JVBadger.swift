//
//  JVBadger.swift
//  JVNotifications
//
//  Created by Jon Vogel on 9/6/16.
//  Copyright © 2016 Jon Vogel. All rights reserved.
//

import UIKit

open class Badger: UILabel {
    
    
    open var badgeValue: String = "" {
        willSet(newValue){
            
        }
        
        didSet{
            self.text = badgeValue
            if self.badgeValue.isEmpty || self.badgeValue == "0"{
                self.isHidden = true
            }else{
                self.isHidden = false
            }
        }
    }
    
    public init(badgeColor color: UIColor?, textColor: UIColor?, viewToBadge view: UIView, initialValue value: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        
        
        if color == nil {
            self.backgroundColor = UIColor.red
        }else {
            self.backgroundColor = color
        }
        
        if textColor == nil {
            self.textColor = UIColor.white
        }else{
            self.textColor = textColor
        }
        
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = NSTextAlignment.center
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        self.constrain(view)
        
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
        if value != nil {
            self.badgeValue = value!
            self.text = value
            if self.text!.isEmpty == true || self.badgeValue == "0"{
                self.isHidden = true
            }
        }else{
            self.isHidden = true
        }
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func constrain(_ superView: UIView) {
        
        var arrayOfConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint(item: superView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0)
        
        let horizontalConstraint = NSLayoutConstraint(item: superView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0)
        
        let widthConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:[me(>=25)]", options: [], metrics: nil, views: ["me": self])
        
        let heighConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:[me(>=25)]", options: [], metrics: nil, views: ["me":self])
        
        arrayOfConstraints.append(contentsOf: widthConstraint)
        arrayOfConstraints.append(contentsOf: heighConstraint)
        arrayOfConstraints.append(verticalConstraint)
        arrayOfConstraints.append(horizontalConstraint)
        
        superView.addConstraints(arrayOfConstraints)
        
    }
    
    
}
