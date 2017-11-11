//
//  CodeDataManager.swift
//  BaseMVP
//
//  Created by Irvin Robles on 10/25/17.
//  Copyright © 2017 Irvin Robles. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  static let shared = CoreDataManager()
  var managedObjectContext: NSManagedObjectContext
  
  init() {
    guard let modelURL = Bundle.main.url(forResource: "Entities", withExtension:"momd") else {
      fatalError("Error loading model from bundle")
    }
    guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
      fatalError("Error initializing mom from: \(modelURL)")
    }
    let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
    self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    self.managedObjectContext.persistentStoreCoordinator = psc
    
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let docURL = urls[urls.endIndex-1]
    
    let storeURL = docURL.appendingPathComponent("EntitiesV2.sqlite")
    do {
      try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    } catch {
      fatalError("Error migrating store: \(error)")
    }
  }
  
  static func getRegsiters() {
    
  }
  
  static func getRegister() {
    
  }
  
  static func addRegister() {
    
  }
  
  static func deleteRegister() {
    
  }
  
  static func updateRegsiter() {
    
  }
}
