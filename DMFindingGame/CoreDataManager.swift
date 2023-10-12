
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
     let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        let context =
         persistentContainer.viewContext
        let newScore = Score(context: context)
        newScore.value = Int16(score)
        do {
            try context.save()
        } catch {
            fatalError("Error saving context: \(error.localizedDescription)")
        }
    }
    
        /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Int] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Score>(entityName: "Score")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "value", ascending: false)]
        
        do {
            let scores = try context.fetch(fetchRequest)
            return scores.map { Int($0.value) }
        } catch {
            fatalError("Error fetching scores: \(error.localizedDescription)")
        }
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
                        
            do {
                let context = persistentContainer.viewContext

                let fetchRequest = NSFetchRequest<Score>(entityName: "Score")
                //ns predicate
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "value", ascending: false)]

                let scores = try context.fetch(fetchRequest)
                if let highScore = scores.first {
                    return Int(highScore.value)
                }
                return Int(scores.first?.value ?? 0)
            } catch {
                return 0
            }
        }
    }
