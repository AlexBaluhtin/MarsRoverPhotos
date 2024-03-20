//
//  Model.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import CoreData
import Foundation

protocol Model {}

extension Model where Self: NSManagedObject {
  
  func save() throws {
    try CoreDataService.shared.viewContext.save()
  }
  
  func delete() throws {
     CoreDataService.shared.viewContext.delete(self)
    try save()
  }
  
  static var all: NSFetchRequest<Self> {
    let request = NSFetchRequest<Self>(entityName: String(describing: self))
    request.sortDescriptors = []
    request.predicate = NSPredicate(format: "savedInDatabase == %@", NSNumber(value: true))
    return request
  }
  
  func clearAll() throws {
    let request = NSFetchRequest<Self>(entityName: String(describing: self))
    if let allObjects = try CoreDataService.shared.viewContext.fetch(request) as? [Self] {
      for object in allObjects {
        CoreDataService.shared.viewContext.delete(object)
      }
      try CoreDataService.shared.viewContext.save()
    }
  }
  
  static func fetchObjectWithID(_ id: NSManagedObjectID) -> Self? {
    do {
      return try CoreDataService.shared.viewContext.existingObject(with: id) as? Self
    } catch {
      print("Error fetching object with ID: \(error)")
      return nil
    }
  }
}
