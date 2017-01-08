//
//  Tag+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 8/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag");
    }

    @NSManaged public var name: String?
    @NSManaged public var tagBook: NSSet?

}

// MARK: Generated accessors for tagBook
extension Tag {

    @objc(addTagBookObject:)
    @NSManaged public func addToTagBook(_ value: Book)

    @objc(removeTagBookObject:)
    @NSManaged public func removeFromTagBook(_ value: Book)

    @objc(addTagBook:)
    @NSManaged public func addToTagBook(_ values: NSSet)

    @objc(removeTagBook:)
    @NSManaged public func removeFromTagBook(_ values: NSSet)

}
