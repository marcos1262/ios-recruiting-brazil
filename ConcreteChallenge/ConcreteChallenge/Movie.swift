//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Marcos Santos on 19/12/19.
//
//

import Foundation
import CoreData
import UIKit

@objc(Movie)
public class Movie: NSManagedObject, Decodable {

    public var image: UIImage = .placeholder

    enum CodingKeys: String, CodingKey {
        case id
        case imagePath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case title
        case genres = "genres"
    }

    // MARK: Codable

    required convenience public init(from decoder: Decoder) throws {
        try self.init(saving: false)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int64.self, forKey: .id)
        self.imagePath = try container.decode(String.self, forKey: .imagePath)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.title = try container.decode(String.self, forKey: .title)

        self.releaseDate = try decoder.decode(CodingKeys.releaseDate, using: DateFormatter.databaseDate)

        if let genres = try container.decodeIfPresent([Genre].self, forKey: .genres) {
            for genre in genres {
                self.addToGenres(genre)
                genre.addToMovies(self)
            }
        }
    }

    func isSaved() throws -> Bool {
        return (try Self.queryById(Int(self.id))) != nil
    }

    func insertIntoContext() throws {
        if !self.isInserted {
            let context = try CoreDataManager.getContext()
            context.insert(self)

            for genre in (self.genres?.allObjects as? [Genre]) ?? [] {
                try genre.insertIntoContext()
            }
        }
    }
}