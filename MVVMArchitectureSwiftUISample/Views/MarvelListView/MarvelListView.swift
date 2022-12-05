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
                    CharacterCell(vm: vm, character: character)
                    .onAppear {
                        Task {
                            await self.listItemAppears(character)
                        }
                    }
                }

            }
            .emptyListPlaceholder(
                vm.characters,
                       AnyView(Text("No Characters").font(.title)) // Placeholder
                   )
            .listStyle(.insetGrouped)
            .task {
                 await vm.getCharactersListMarvel()
            }
            .refreshable {
                 await vm.getCharactersListMarvel()
            }.overlay {
                if vm.isFetching {
                    ProgressView()
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
            vm.isFetching = true
            await vm.getCharactersListMarvel()
        }
    }
}
