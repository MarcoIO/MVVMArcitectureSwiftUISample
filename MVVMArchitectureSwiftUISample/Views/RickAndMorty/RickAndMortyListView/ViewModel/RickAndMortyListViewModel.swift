//
//  RickAndMortyListViewModel.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import Foundation

final class RickAndMortyListViewModel:ObservableObject {
    @Published var isFetching = false
    @Published var isFetchingPagination = false

    @Published var characters: [ResultRickAndMorty] = []

    @Published var showAlert = false
    @Published var errorMsg = ""


    let rickAndMortyService = RickAndMortyService()

    @Published var pageList = 0
    @Published var statusType:Status = .all
    @Published var genderType:Gender = .all
    @Published var search: String = ""


    var pageOffset = 0


    public init() {

    }
    @MainActor
    func getCharactersListRickAndMorty() async {
        defer {
            isFetching = false
            isFetchingPagination = false
        }
        do {
            if !characters.isEmpty {
                pageList += 1
            }
            if pageList == 0 {
                isFetching = true
            } else  {
                isFetchingPagination = true
            }
            let response = try await rickAndMortyService.getAllCharactersRickAndMorty(page: pageList, nameFilter: search, gender: genderType == .all ? nil : genderType, status: statusType == .all ? nil : statusType)
            if let data = response.results {
                if pageList == 0 {
                    characters.removeAll()
                }
                characters += data
            }
        } catch let error as CustomNetworkError {
            errorMsg = error.customMessage
            showAlert.toggle()
        } catch {
            errorMsg = error.localizedDescription
            showAlert.toggle()
        }
    }

    @MainActor
    func sortFilterCharacters() async {
        characters.removeAll()
        pageList = 0
        await getCharactersListRickAndMorty()
    }
}
