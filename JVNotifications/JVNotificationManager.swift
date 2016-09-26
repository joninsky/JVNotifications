//
//  JVNotificationManager.swift
//  JVNotifications
//
//  Created by Jon Vogel on 9/6/16.
//  Copyright © 2016 Jon Vogel. All rights reserved.
//

import UIKit
import RealmSwift




internal let debugKey = "Debug"

open class JVNotificationManager {
    //MARK: Properties
    
    static open let sharedInstance = JVNotificationManager()
    
    //Variable to determine if we should fire debug notifications or not
    open var fireDebugNotifications = UserDefaults.standard.bool(forKey: debugKey) {
        didSet {
            UserDefaults.standard.set(self.fireDebugNotifications, forKey: debugKey)
        }
    }
    
    //MARK: Init
    fileprivate init() {

        
        
    }

    
    
    //MARK: Class Functions
    
    open func quickAlert(_ title: String, message: String?, viewThatWillPresentAlert view: UIViewController, presentationStyle style: UIAlertControllerStyle) {
        //Create the alertController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        //Create the OK Action
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        //Add the action to the controller
        alertController.addAction(okAction)
        //Present the alert controller
        view.present(alertController, animated: true, completion: nil)
    }
    
    
    open func checkRegistration(_ types: UIUserNotificationType) -> Bool {
        
        let notificaitonSettigs = UIUserNotificationSettings(types: types, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificaitonSettigs)
        return true
        
    }
    
    open func deleteAllNotifications() throws {
        try Realm().write {
            try! Realm().delete(Realm().objects(JVNotification.self))
        }
    }
    
    
    open func getAllNotifications() -> [JVNotification] {
        
        do {
            return Array(try Realm().objects(JVNotification.self).sorted(byProperty: "dateFired", ascending: false))
        }catch{
            return [JVNotification]()
        }
    }
    
    open func fireNotification(_ theNotification: JVNotification) {
        if self.fireDebugNotifications == theNotification.debug {
            let notification = UILocalNotification()
            notification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
            notification.alertTitle = theNotification.title
            
            if let t = theNotification.title, let e = theNotification.explination {
                theNotification.coalescedTitle = t + " - " + e
            }
            
            
            if theNotification.coalescedTitle == nil {
                notification.alertBody = theNotification.title
            }else{
                notification.alertBody = theNotification.coalescedTitle
            }

            UIApplication.shared.presentLocalNotificationNow(notification)
            theNotification.dateFired = Date()
            do{
                try Realm().write{
                    try! Realm().add(theNotification)
                }
            }catch{
                
            }
        }
    }
    
}
