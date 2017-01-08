//
//  Annotations+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 7/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Annotations {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Annotations> {
        return NSFetchRequest<Annotations>(entityName: "Annotations");
    }

    @NSManaged public var annotationString: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var annotationPhoto: NSData?
    @NSManaged public var annotationBook: Book?

}
