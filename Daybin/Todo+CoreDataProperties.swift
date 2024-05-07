//
//  Todo+CoreDataProperties.swift
//  Daybin
//
//  Created by 양원식 on 5/7/24.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var calenderDay: String?
    @NSManaged public var id: UUID?
    @NSManaged public var todo: String?

}

extension Todo : Identifiable {

}
