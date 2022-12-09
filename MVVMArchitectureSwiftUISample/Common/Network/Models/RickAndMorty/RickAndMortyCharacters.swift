//
//  RickAndMortyCharacter.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import Foundation

struct RickAndMortyCharacters: Codable {
    let info: Info?
    let results: [ResultRickAndMorty]?
}

struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

struct ResultRickAndMorty: Codable, Identifiable {
    let id: Int?
    let name: String?
    let status: Status?
    let species, type: String?
    let gender: Gender?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?

    init(id: Int?, name: String?, image: String?) {
        self.id = id
        self.name = name
        self.image = image
        self.status = .alive
        self.gender = .male
        self.species = nil
        self.type = nil
        self.origin = nil
        self.location = nil
        self.episode = nil
        self.url = nil
        self.created = nil
    }
}

enum Gender: String, Codable, CaseIterable {
    case all = "All"
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct Location: Codable {
    let name: String?
    let url: String?
}

enum Status: String, Codable, CaseIterable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
