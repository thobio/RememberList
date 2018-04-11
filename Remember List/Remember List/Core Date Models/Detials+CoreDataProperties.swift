//
//  Detials+CoreDataProperties.swift
//  Remember List
//
//  Created by Thobio on 10/04/18.
//  Copyright © 2018 STapps. All rights reserved.
//
//

import Foundation
import CoreData


extension Detials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detials> {
        return NSFetchRequest<Detials>(entityName: "Detials")
    }

    @NSManaged public var comments: String?
    @NSManaged public var names: String?
    @NSManaged public var dates: NSDate?
    @NSManaged public var owner: Day?

}
