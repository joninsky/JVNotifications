//
//  JVNotification.swift
//  JVNotifications
//
//  Created by Jon Vogel on 9/6/16.
//  Copyright © 2016 Jon Vogel. All rights reserved.
//

import UIKit
import RealmSwift


public class JVNotification: Object {
    
    //MARK: Properties
    public dynamic var title: String?
    public dynamic var explination: String?
    public dynamic var image: String?
    public dynamic var subImage: String?
    public internal(set) dynamic var dateFired: NSDate!
    public dynamic var debug = false
    public dynamic var seen = false
    
    public convenience init(title t: String, explination e: String, imageName i: String, subImageName s: String) {
        self.init()
        self.title = t
        self.explination = e
        self.image = i
        self.subImage = s
    }
    
    
    
    //MARK: Functions
    public func delete() throws {
        do{
            try Realm().write {
                try Realm().delete(self)
            }
        }catch{
            throw error
        }
    }
    
    public func markAsSeen() throws {
        do{
            try Realm().write{
                self.seen = true
            }
        }catch{
            throw error
        }
    }
}


