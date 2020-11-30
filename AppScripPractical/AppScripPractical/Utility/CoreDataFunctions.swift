//
//  CoreDataFunctions.swift
//  AppScripPractical
//
//  Created by Mac Mini on 12/11/20.
//

import UIKit
import CoreData

class CoreDataFunctions: NSObject {
    var Movies: [NSManagedObject] = []
    
    func fetchMovieList() -> [NSManagedObject] {
        //1
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Movie")
        
        //3
        do {
            Movies = try managedContext.fetch(fetchRequest)
            return Movies
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func save(title: String, name: String, link: String, artist: String, category: String, image: String) {
        
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Movie",
                                       in: managedContext)!
        
        let Movie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        Movie.setValue(name, forKeyPath: "name")
        Movie.setValue(link, forKeyPath: "link")
        Movie.setValue(category, forKeyPath: "category")
        Movie.setValue(artist, forKeyPath: "artist")
        Movie.setValue(title, forKeyPath: "title")
        Movie.setValue(image, forKeyPath: "image")
        
        do {
            try managedContext.save()
            Movies.append(Movie)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllData(entity: String) {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        if #available(iOS 9, *)
        {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do
            {
                try managedContext.execute(deleteRequest)
                try managedContext.save()
            }
            catch
            {
                print("There was an error:\(error)")
            }
        }
        else
        {
            do{
                let deleteRequest = try managedContext.fetch(deleteFetch)
                for anItem in deleteRequest {
                    managedContext.delete(anItem as! NSManagedObject)
                }
            }
            catch
            {
                print("There was an error:\(error)")
            }
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
