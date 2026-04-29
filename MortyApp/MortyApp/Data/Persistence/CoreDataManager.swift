
import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MortyApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("CoreData error: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveFavorite(character: Character) {
        let entity = FavoriteCharacter(context: context)
        entity.id = Int64(character.id)
        entity.name = character.name
        entity.image = character.image
        
        save()
    }
    
    func deleteFavorite(id: Int) {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        if let result = try? context.fetch(request).first {
            context.delete(result)
            save()
        }
    }
    
    func isFavorite(id: Int) -> Bool {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
    

    func fetchFavorites() -> [FavoriteCharacter] {
        let request: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    
    private func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
    
    func saveWatchedEpisode(_ episode: Episode) {
        let entity = WatchedEpisode(context: context)
        entity.id = Int64(episode.id)
        entity.name = episode.name
        save()
    }

    func deleteWatchedEpisode(id: Int) {
        let request: NSFetchRequest<WatchedEpisode> = WatchedEpisode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        if let result = try? context.fetch(request).first {
            context.delete(result)
            save()
        }
    }

    func isEpisodeWatched(id: Int) -> Bool {
        let request: NSFetchRequest<WatchedEpisode> = WatchedEpisode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        let count = (try? context.count(for: request)) ?? 0
        return count > 0
    }
}
