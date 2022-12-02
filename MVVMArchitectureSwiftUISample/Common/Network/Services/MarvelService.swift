//
//  MarvelService.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 30/11/22.
//


import Foundation

protocol MarvelServiceable {
    func getCharactersListMarvel(page: Int, sortType: SortType, search: String?) async throws -> CharactersListMarvel
    func getCharacterDetailMarvel(id: Int) async throws -> CharactersListMarvel
}

struct MarvelService: MarvelServiceable {

    func getCharactersListMarvel(page: Int, sortType: SortType, search: String?) async throws -> CharactersListMarvel {
        return  try await APIClient.shared.sendRequest(endpoint: MarvelEndpoint.getCharactersListMarvel(page: page, sortType: sortType, search: search), responseModel: CharactersListMarvel.self)
    }

    func getCharacterDetailMarvel(id: Int) async throws -> CharactersListMarvel {
        return  try await APIClient.shared.sendRequest(endpoint: MarvelEndpoint.getCharacterDetailMarvel(id: id), responseModel: CharactersListMarvel.self)
    }
}
