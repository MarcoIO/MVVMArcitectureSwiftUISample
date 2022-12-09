//
//  RickAndMortyService.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import Foundation

protocol RickAndMortyServiceable {
    func getAllCharactersRickAndMorty(page: Int, nameFilter: String?, gender: Gender?, status: Status?) async throws -> RickAndMortyCharacters
}

struct RickAndMortyService: RickAndMortyServiceable {

    func getAllCharactersRickAndMorty(page: Int, nameFilter: String?, gender: Gender?, status: Status?) async throws -> RickAndMortyCharacters {
        return  try await APIClient.shared.sendRequest(endpoint: RickAndMortyEndpoint.getAllCharactersRickAndMorty(page: page, nameFilter: nameFilter, gender: gender, status: status), responseModel: RickAndMortyCharacters.self)
    }
}
