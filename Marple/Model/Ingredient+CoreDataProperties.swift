//
//  Ingredient+CoreDataProperties.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?

}

extension Ingredient : Identifiable {

}
