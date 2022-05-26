//
//  PersitenceManager.swift
//  GHFollowers
//
//  Created by Piyush Mandaliya on 2022-05-19.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping(GFError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorite)
                        return
                    }
                    
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll(where: { $0.login == favorite.login })
                    break
                }
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
            
        }
    }
    
    static func retriveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favoritesFollower = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favoritesFollower))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch {
            return .unableToFavorite
        }
    }
}
