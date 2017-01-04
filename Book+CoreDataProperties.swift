//
//  Book+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 03/01/2017.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var title: String?
    @NSManaged public var bookTag: NSSet?
    @NSManaged public var bookPdf: Pdf?
    @NSManaged public var bookPhoto: NSSet?
    @NSManaged public var bookAuthor: Author?

}

// MARK: Generated accessors for bookTag
extension Book {

    @objc(addBookTagObject:)
    @NSManaged public func addToBookTag(_ value: Tag)

    @objc(removeBookTagObject:)
    @NSManaged public func removeFromBookTag(_ value: Tag)

    @objc(addBookTag:)
    @NSManaged public func addToBookTag(_ values: NSSet)

    @objc(removeBookTag:)
    @NSManaged public func removeFromBookTag(_ values: NSSet)

}

// MARK: Generated accessors for bookPhoto
extension Book {

    @objc(addBookPhotoObject:)
    @NSManaged public func addToBookPhoto(_ value: Photo)

    @objc(removeBookPhotoObject:)
    @NSManaged public func removeFromBookPhoto(_ value: Photo)

    @objc(addBookPhoto:)
    @NSManaged public func addToBookPhoto(_ values: NSSet)

    @objc(removeBookPhoto:)
    @NSManaged public func removeFromBookPhoto(_ values: NSSet)

}
