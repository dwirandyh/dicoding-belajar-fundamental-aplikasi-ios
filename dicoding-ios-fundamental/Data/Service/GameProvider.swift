//
//  GameProvider.swift
//  dicoding-ios-fundamental
//
//  Created by Dwi Randy Herdinanto on 20/08/20.
//  Copyright © 2020 dwirandyh. All rights reserved.
//

import Foundation
import CoreData

typealias getAllFavoriteCompletion = (_ game: [Game]) -> Void
typealias addFavoriteCompletion = () -> Void
typealias maxIdCompletion = (_ maxId: Int) -> Void
typealias findFavoriteCompletion = (_ isExist: Bool) -> Void
typealias removeFavoriteCompletion = () -> Void

protocol GameProvider {
    func getAllFavorite(completion: @escaping getAllFavoriteCompletion)
    func addFavorite(game: Game, completion: @escaping addFavoriteCompletion)
    func findData(gameId: Int, completion: @escaping findFavoriteCompletion)
    func removeFavorite(gameId: Int, completion: @escaping removeFavoriteCompletion)
}

class GameProviderImpl {

    private static let entity: String = "Favorite"
    private enum Attribute: String {
        case id
        case gameId
        case name
        case backgroundImage
        case gameRelease
        case playtime
        case rating
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameDB")

        container.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }

    private func getMaxId(completion: maxIdCompletion) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastData = try taskContext.fetch(fetchRequest)
                if let data = lastData.first, let position = data.value(forKey: Attribute.id.rawValue) as? Int {
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

extension GameProviderImpl: GameProvider {

    func getAllFavorite(completion: @escaping getAllFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: GameProviderImpl.entity)
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [Game] = []
                for result in results {
                    let game: Game = Game(id: result.value(forKeyPath: Attribute.gameId.rawValue) as? Int,
                                          name: result.value(forKeyPath: Attribute.name.rawValue) as? String,
                                          description: nil, rating: result.value(forKeyPath: Attribute.rating.rawValue) as? Float,
                                          backgroundImage: result.value(forKeyPath: Attribute.backgroundImage.rawValue) as? String,
                                          released: result.value(forKeyPath: Attribute.gameRelease.rawValue) as? Date,
                                          playtime: result.value(forKeyPath: Attribute.playtime.rawValue) as? Int,
                                          genres: nil, clip: nil)
                    games.append(game)
                }

                completion(games)
            } catch let error as NSError {
                print("Could no fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func addFavorite(game: Game, completion: @escaping addFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: GameProviderImpl.entity, in: taskContext) {
                let data = NSManagedObject(entity: entity, insertInto: taskContext)

                self.getMaxId { (id) in
                    data.setValue(id + 1, forKey: Attribute.id.rawValue)
                    data.setValue(game.id, forKey: Attribute.gameId.rawValue)
                    data.setValue(game.backgroundImage, forKey: Attribute.backgroundImage.rawValue)
                    data.setValue(game.released, forKey: Attribute.gameRelease.rawValue)
                    data.setValue(game.name, forKey: Attribute.name.rawValue)
                    data.setValue(game.playtime, forKey: Attribute.playtime.rawValue)
                    data.setValue(game.rating, forKey: Attribute.rating.rawValue)
                    data.setValue(game.released, forKey: Attribute.gameRelease.rawValue)

                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }

    func findData(gameId: Int, completion: @escaping findFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: GameProviderImpl.entity)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(Attribute.gameId.rawValue) == \(gameId)")
            do {
                if let _ = try taskContext.fetch(fetchRequest).first {
                    completion(true)
                } else {
                    completion(false)
                }
            } catch let error as NSError {
                print("Could not fecth. \(error), \(error.userInfo)")
            }
        }
    }

    func removeFavorite(gameId: Int, completion: @escaping removeFavoriteCompletion) {
        let taskContext = self.newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GameProviderImpl.entity)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(Attribute.gameId.rawValue) == \(gameId)")

            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                completion()
            }
        }
    }
}
