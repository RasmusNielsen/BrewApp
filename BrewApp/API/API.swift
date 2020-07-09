//
//  API.swift
//  BrewApp
//
//  Created by Casper on 09/07/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import Foundation

class API {
    static let sharedInstance = API()

    init() {}
    
    // Fetches local JSON file and decode it into models.
    public func fetchRecipes() -> Array<Recipe>? {
        if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let recipes = try decoder.decode(Array<Recipe>.self, from: data)
                return recipes
            } catch let error {
                // TODO: Handle this error better maybe.
                print(error)
                return nil
            }
        }
        return nil
    }
}


