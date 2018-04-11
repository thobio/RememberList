//
//  Day+CoreDataProperties.swift
//  Remember List
//
//  Created by Thobio on 10/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var dates: NSDate?
    @NSManaged public var detials: NSSet?

}

// MARK: Generated accessors for detials
extension Day {

    @objc(addDetialsObject:)
    @NSManaged public func addToDetials(_ value: Detials)

    @objc(removeDetialsObject:)
    @NSManaged public func removeFromDetials(_ value: Detials)

    @objc(addDetials:)
    @NSManaged public func addToDetials(_ values: NSSet)

    @objc(removeDetials:)
    @NSManaged public func removeFromDetials(_ values: NSSet)

}
