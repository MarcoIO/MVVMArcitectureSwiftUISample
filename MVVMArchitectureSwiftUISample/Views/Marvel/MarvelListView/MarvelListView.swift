//
//  MarvelList.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 30/11/22.
//


import SwiftUI

struct MarvelListView: View {
    @ObservedObject var vm = MarvelListViewModel()

    var body: some View {
        NavigationStack {
            List {
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

                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    

                }
            }
            .emptyListPlaceholder(
                vm.characters,
                       AnyView(Text("No Characters").font(.title)) // Placeholder
                   )
            .listStyle(.insetGrouped)
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
//            .navigationDestination(isPresented: $vm.requestSuccess) {
//                Text(vm.requestSuccessString)
//            }
        }

    }
}

struct MarvelList_Previews: PreviewProvider {
    static var previews: some View {
        MarvelListView()
    }
}


extension MarvelListView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) async {
        if vm.characters.isThresholdItem(offset: vm.pageOffset,
                                 item: item) {
            vm.isFetchingPagination = true
            await vm.getCharactersListMarvel()
        }
    }
}

// FIXME: There is a bug in SWIFT UI List, Event onAppear is not called always for each cell for this reason it's necessary to do the pagination with ScrollView and LazyVStack
