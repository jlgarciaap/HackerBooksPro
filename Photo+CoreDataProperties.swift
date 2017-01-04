//
//  Photo+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 03/01/2017.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var urlPhoto: String?
    @NSManaged public var photoData: NSData?
    @NSManaged public var photoBook: Book?

}
