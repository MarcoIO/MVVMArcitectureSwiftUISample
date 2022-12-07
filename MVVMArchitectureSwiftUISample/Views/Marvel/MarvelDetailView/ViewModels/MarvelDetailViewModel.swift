//
//  MarvelDetailViewModel.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 5/12/22.
//


import Foundation

final class MarvelDetailViewModel:ObservableObject {
    @Published var isFetching = false

    @Published var showAlert = false
    @Published var errorMsg = ""
    @Published var characterDataSource: MarvelDetailModelLogic.ViewDataSource?

    var idCharacter: Int
    var character: CharactersList?
    let marvelService = MarvelService()

    public init(idCharacter: Int) {
        self.idCharacter = idCharacter
    }

    @MainActor
    func getCharacterDetailMarvel() async {
        isFetching = true
        defer { isFetching = false }
        do {
            let response = try await marvelService.getCharacterDetailMarvel(id: idCharacter)
            if let data = response.data {
                character = data.results?.first
                if let character = character {
                    characterDataSource = MarvelDetailModelLogic().getMarvelDetailModelDataSource(character: character)
                }
            }
        } catch let error as CustomNetworkError {
            errorMsg = error.customMessage
            showAlert.toggle()
        } catch {
            errorMsg = error.localizedDescription
            showAlert.toggle()
        }
    }
}
