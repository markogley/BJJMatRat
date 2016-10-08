//
//  Drill+CoreDataProperties.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-10-08.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import Foundation
import CoreData


extension Drill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Drill> {
        return NSFetchRequest<Drill>(entityName: "Drill");
    }

    @NSManaged public var name: String?
    @NSManaged public var partner: NSNumber?
    @NSManaged public var detail: String?
    @NSManaged public var type: String?
    @NSManaged public var skipped: NSNumber?

}
