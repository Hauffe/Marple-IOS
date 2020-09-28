//
//  Restriction+CoreDataProperties.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//
//

import Foundation
import CoreData


extension Restriction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restriction> {
        return NSFetchRequest<Restriction>(entityName: "Restriction")
    }

    @NSManaged public var name: String?
    @NSManaged public var available: Bool
    @NSManaged public var hasIngredient: Ingredient?

}

extension Restriction : Identifiable {

}
