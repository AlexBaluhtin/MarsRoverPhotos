//
//  CoreDataService.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 20/03/2024.
//

import CoreData
import Foundation

final class CoreDataService {
  
  static let shared = CoreDataService()
  let persistentContainer: NSPersistentContainer
  
  var viewContext: NSManagedObjectContext {
     persistentContainer.viewContext
  }
  
  private init() {
    persistentContainer = NSPersistentContainer(name: "MarsRoverPhotosDataModel")
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Unable to initialize model \(error)")
      }
    }
  }
  
  func saveFilter(filter: FilterDataModel) {
    do {
      try filter.save()
    } catch {
      print(error)
    }
  }
}
