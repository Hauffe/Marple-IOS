//
//  Product+CoreDataProperties.swift
//  Marple
//
//  Created by Alex on 28/09/20.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var hasIngredient: Ingredient?

}

extension Product : Identifiable {

}
