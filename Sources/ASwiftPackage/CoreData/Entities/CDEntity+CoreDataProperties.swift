//
//  CDEntity+CoreDataProperties.swift
//  
//
//  Created by Hussaan S on 16/08/2021.
//
//

import Foundation
import CoreData


extension CDEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEntity> {
        return NSFetchRequest<CDEntity>(entityName: "CDEntity")
    }

    @NSManaged public var test: String?

}
