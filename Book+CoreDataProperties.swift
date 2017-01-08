//
//  Book+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 7/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var title: String?
    @NSManaged public var bookAuthor: NSSet?
    @NSManaged public var bookPdf: Pdf?
    @NSManaged public var bookPhoto: Photo?
    @NSManaged public var bookTag: NSSet?
    @NSManaged public var bookAnnotations: NSSet?

}

// MARK: Generated accessors for bookAuthor
extension Book {

    @objc(addBookAuthorObject:)
    @NSManaged public func addToBookAuthor(_ value: Author)

    @objc(removeBookAuthorObject:)
    @NSManaged public func removeFromBookAuthor(_ value: Author)

    @objc(addBookAuthor:)
    @NSManaged public func addToBookAuthor(_ values: NSSet)

    @objc(removeBookAuthor:)
    @NSManaged public func removeFromBookAuthor(_ values: NSSet)

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

// MARK: Generated accessors for bookAnnotations
extension Book {

    @objc(addBookAnnotationsObject:)
    @NSManaged public func addToBookAnnotations(_ value: Annotations)

    @objc(removeBookAnnotationsObject:)
    @NSManaged public func removeFromBookAnnotations(_ value: Annotations)

    @objc(addBookAnnotations:)
    @NSManaged public func addToBookAnnotations(_ values: NSSet)

    @objc(removeBookAnnotations:)
    @NSManaged public func removeFromBookAnnotations(_ values: NSSet)

}
