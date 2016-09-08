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

public class JVNotificationManager {
    //MARK: Properties
    
    static public let sharedInstance = JVNotificationManager()
    
    //Variable to determine if we should fire debug notifications or not
    public var fireDebugNotifications = NSUserDefaults.standardUserDefaults().boolForKey(debugKey) {
        didSet {
            NSUserDefaults.standardUserDefaults().setBool(self.fireDebugNotifications, forKey: debugKey)
        }
    }
    
    //MARK: Init
    private init() {

        
        
    }

    
    
    //MARK: Class Functions
    
    public func quickAlert(title: String, message: String?, viewThatWillPresentAlert view: UIViewController, presentationStyle style: UIAlertControllerStyle) {
        //Create the alertController
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        //Create the OK Action
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        //Add the action to the controller
        alertController.addAction(okAction)
        //Present the alert controller
        view.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    public func checkRegistration(types: UIUserNotificationType) -> Bool {
        
        let notificaitonSettigs = UIUserNotificationSettings(forTypes: types, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificaitonSettigs)
        return true
        
    }
    
    public func deleteAllNotifications() throws {
        try Realm().write {
            try Realm().delete(Realm().objects(JVNotification.self))
        }
    }
    
    
    public func getAllNotifications() -> [JVNotification] {
        
        do {
            return Array(try Realm().objects(JVNotification.self).sorted("dateFired", ascending: false))
        }catch{
            return [JVNotification]()
        }
    }
    
    public func fireNotification(theNotification: JVNotification) {
        if self.fireDebugNotifications == theNotification.debug {
            let notification = UILocalNotification()
            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber
            notification.alertTitle = theNotification.title
            if theNotification.title != nil && theNotification.explination != nil {
                notification.alertBody = theNotification.title! + " - " + theNotification.explination!
            }else{
                notification.alertBody = theNotification.explination
            }
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
            theNotification.dateFired = NSDate()
            do{
                try Realm().write{
                    try Realm().add(theNotification)
                }
            }catch{
                
            }
        }
    }
    
}
