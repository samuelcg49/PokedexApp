//
//  DatosPokemon.swift
//  PokedexApp
//
//  Created by Samuel Cíes Gracia on 9/3/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}

