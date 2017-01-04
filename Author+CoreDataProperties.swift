//
//  Author+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 03/01/2017.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author");
    }

    @NSManaged public var name: String?
    @NSManaged public var authorBook: NSSet?

}

// MARK: Generated accessors for authorBook
extension Author {

    @objc(addAuthorBookObject:)
    @NSManaged public func addToAuthorBook(_ value: Book)

    @objc(removeAuthorBookObject:)
    @NSManaged public func removeFromAuthorBook(_ value: Book)

    @objc(addAuthorBook:)
    @NSManaged public func addToAuthorBook(_ values: NSSet)

    @objc(removeAuthorBook:)
    @NSManaged public func removeFromAuthorBook(_ values: NSSet)

}
