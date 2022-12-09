//
//  MarvelListScrollView.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import SwiftUI



struct MarvelListScrollView: View {
    @ObservedObject var vm = MarvelListViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(vm.characters) { character in
                        NavigationLink {
                            MarvelDetailView(vm: MarvelDetailViewModel(idCharacter: character.id ?? -1))
                        } label: {
                            VStack {
                                CharacterCell(vm: MarvelListCellViewModel(character: character))
                                if vm.isFetchingPagination && vm.characters.isLastItem(character) {
                                    Divider()
                                    Text("Loading ...")
                                        .padding(.vertical)
                                }

                            }.onAppear {
                                Task {
                                    await self.listItemAppears(character)
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.visible)
            .task {
                if vm.characters.isEmpty {
                    await vm.getCharactersListMarvel()
                }
            }
            .refreshable {
                 await vm.getCharactersListMarvel()
            }.overlay {
                if vm.isFetching {
                    LoadingSpinner()
                }
            }
            .alert("Network Error",
                   isPresented: $vm.showAlert) {
                Button {} label: {
                    Text("OK")
                }
            } message: {
                Text(vm.errorMsg)
            }
            .navigationTitle("Characters")
            .navigationBarItems(trailing: Text("Page index: \(vm.pageList)"))
            .searchable(text: $vm.search, prompt: Text("Search a character"))
            .onChange(of: vm.search) { newValue in
                Task {
                     await vm.sortFilterCharacters()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    sortTypeButton(sortType: $vm.sortType) {
                        await vm.sortFilterCharacters()
                    }
                }
            }
        }

    }
}

struct MarvelListScroll_Previews: PreviewProvider {
    static var previews: some View {
        MarvelListScrollView()
    }
}


extension MarvelListScrollView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) async {
        if vm.characters.isThresholdItem(offset: vm.pageOffset,
                                 item: item) {
            vm.isFetchingPagination = true
            await vm.getCharactersListMarvel()
        }
    }
}
