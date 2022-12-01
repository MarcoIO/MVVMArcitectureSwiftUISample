//
//  MarvelListViewModel.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 30/11/22.
//


import Foundation

final class MarvelListViewModel:ObservableObject {
    @Published var isFetching = false
    @Published var characters: [CharactersList] = []

    @Published var showAlert = false
    @Published var errorMsg = ""

    let marvelService = MarvelService()

    @Published var pageList = 0
    var pageOffset = 3

    public init() {

    }
    @MainActor
    func getCharactersListMarvel() async throws {
        isFetching = true
        defer { isFetching = false }
        do {
            if !characters.isEmpty {
                pageList += 1
            }
            let response = try await marvelService.getCharactersListMarvel(page: pageList)
            if let data = response.data {
                characters += data.results ?? []
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
