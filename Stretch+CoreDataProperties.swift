//
//  Stretch+CoreDataProperties.swift
//  BJJ Mat Rat
//
//  Created by Mark Ogley on 2016-10-05.
//  Copyright © 2016 Mark Ogley. All rights reserved.
//

import Foundation
import CoreData


extension Stretch {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stretch> {
        return NSFetchRequest<Stretch>(entityName: "Stretch");
    }

    @NSManaged public var body: String?
    @NSManaged public var detail: String?
    @NSManaged public var image: NSData?
    @NSManaged public var sides: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var skipped: NSNumber?

}
