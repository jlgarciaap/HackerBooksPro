//
//  Pdf+CoreDataProperties.swift
//  HackerBooksSuperPro
//
//  Created by Juan Luis Garcia on 8/1/17.
//  Copyright © 2017 styleapps. All rights reserved.
//

import Foundation
import CoreData


extension Pdf {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pdf> {
        return NSFetchRequest<Pdf>(entityName: "Pdf");
    }

    @NSManaged public var pdfData: NSData?
    @NSManaged public var urlPdf: String?
    @NSManaged public var pdfBook: Book?

}
