//
//  JVNotification.swift
//  JVNotifications
//
//  Created by Jon Vogel on 9/6/16.
//  Copyright © 2016 Jon Vogel. All rights reserved.
//

import UIKit
import RealmSwift


open class JVNotification: Object {
    
    //MARK: Properties
    open dynamic var title: String?
    open dynamic var explination: String?
    open internal(set) dynamic var coalescedTitle: String?
    open dynamic var image: String?
    open dynamic var subImage: String?
    open internal(set) dynamic var dateFired: Date!
    open dynamic var debug = false
    open dynamic var seen = false
    
    public convenience init(title t: String, explination e: String, imageName i: String, subImageName s: String) {
        self.init()
        self.title = t
        self.explination = e
        self.image = i
        self.subImage = s
    }
    
    
    
    //MARK: Functions
    open func delete() throws {
        do{
            try Realm().write {
                try! Realm().delete(self)
            }
        }catch{
            throw error
        }
    }
    
    open func markAsSeen() throws {
        do{
            try Realm().write{
                self.seen = true
            }
        }catch{
            throw error
        }
    }
}


