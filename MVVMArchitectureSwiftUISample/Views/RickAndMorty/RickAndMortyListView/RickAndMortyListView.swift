//
//  RickAndMortyListView.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import SwiftUI

struct RickAndMortyListView: View {
    @ObservedObject var vm = RickAndMortyListViewModel()

    var body: some View {
        NavigationStack {

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Select Gender:")
                                .font(.callout.bold())
                            Picker("Select Gender:", selection: $vm.genderType) {
                                ForEach(Gender.allCases, id:\.self) { gender in
                                    Text(gender.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: vm.genderType) { newValue in
                                Task {
                                    await vm.sortFilterCharacters()
                                }
                            }
                        }
                        .padding()
                        VStack (alignment: .leading, spacing: 16) {
                            Text("Select Status:")
                                .font(.callout.bold())
                            Picker("Select Status:", selection: $vm.statusType) {
                                ForEach(Status.allCases, id:\.self) { status in
                                    Text(status.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: vm.statusType) { newValue in
                                Task {
                                    await vm.sortFilterCharacters()
                                }
                            }
                        }
                        .padding()
                    LazyVStack(spacing: 0) {
                        ForEach(vm.characters) { character in
                            LazyVStack {
                                CharacterRickAndMortyCell(vm: RickAndMortyListCellViewModel(character: character))
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
                    await vm.getCharactersListRickAndMorty()
                }
            }
            .searchable(text: $vm.search, prompt: Text("Search a character"))
            .refreshable {
                await vm.getCharactersListRickAndMorty()
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
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Text("Page index: \(vm.pageList)"))

            //            .onSubmit(of: .search) {
            //                Task {
            //                     await vm.sortFilterCharacters()
            //                }
            //            }
            .onChange(of: vm.search) { newValue in
                Task {
                    await vm.sortFilterCharacters()
                }
            }
        }

    }
}

struct RickAndMortyListView_Previews: PreviewProvider {
    static var previews: some View {
        RickAndMortyListView()
    }
}


extension RickAndMortyListView {
    private func listItemAppears<Item: Identifiable>(_ item: Item) async {
        if vm.characters.isThresholdItem(offset: vm.pageOffset,
                                         item: item) {
            vm.isFetchingPagination = true
            await vm.getCharactersListRickAndMorty()
        }
    }
}
