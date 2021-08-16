//
//  CDEntityCoreDataStore.swift
//
//
//  Created by Hussaan S on 16/08/2021.
//

import CoreData

public class CDEntityCoreDataStore {
    
    let coreDataStack: AnyCoreDataStack
    public var changeObserver: (() -> Void)? {
        didSet {
            self.observeChanges()
        }
    }
    
    public init(coreDataStack: AnyCoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    
    public func createCDEntity() -> CDEntity {
        return CDEntity(context: self.coreDataStack.manageObjectContext)
    }
    
    public func saveCDEntity(_ entity: CDEntity) {
        self.coreDataStack.saveContext()
    }
    
    public func fetchCDEntity(with id: UUID) throws -> CDEntity? {
        let fetchRequest: NSFetchRequest<CDEntity> = CDEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.uuidString)
        let results = try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
        return results.first
    }
    
    public func fetchCDEntities() throws -> [CDEntity] {
        let fetchRequest: NSFetchRequest<CDEntity> = CDEntity.fetchRequest()
        return try self.coreDataStack.manageObjectContext.fetch(fetchRequest)
    }
    
    public func deleteCDEntity(with id: UUID) throws {
        if let entity = try fetchCDEntity(with: id) {
            self.coreDataStack.manageObjectContext.delete(entity)
            self.coreDataStack.saveContext()
        }
    }
    
    public func observeChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: Notification.Name.NSManagedObjectContextDidSave, object: nil)
    }
    
    @objc
    func contextDidSave(_ notification: Notification) {
        guard let context = notification.object as? NSManagedObjectContext else { return }
        guard context === self.coreDataStack.manageObjectContext else { return }
        
        var didChange = false
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<CDEntity>,
           !insertedObjects.isEmpty {
            didChange = true
        }
        if let updatedObjects = notification.userInfo?[NSUpdatedObjectsKey] as? Set<CDEntity>,
           !updatedObjects.isEmpty {
            didChange = true
        }
        if let deletedObjects = notification.userInfo?[NSDeletedObjectsKey] as? Set<CDEntity>,
           !deletedObjects.isEmpty {
            didChange = true
        }
        if didChange, let changeObserver = self.changeObserver {
            changeObserver()
        }
    }
}
