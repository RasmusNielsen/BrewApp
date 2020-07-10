//
//  Recipe.swift
//  BrewApp
//
//  Created by Casper on 09/07/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let description: String
    let countdown: Double
}
