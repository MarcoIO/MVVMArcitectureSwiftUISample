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
                    VStack {
                        Text(character.name ?? "")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .baselineOffset(-10)
                            .shadow(color: .black, radius: 1, x: -1, y: 1)
                            .frame(width: UIScreen.main.bounds.width, height: 200)

                        if vm.isFetching && vm.characters.isLastItem(character) {
                            Divider()
                            Text("Loading ...")
                                .padding(.vertical)
                        }
                    }
                    .background(content: {
                        if let thumbnail = character.thumbnail, let path = thumbnail.path, let exten = thumbnail.exten {
                            let imageName = path + "." + exten
                            AsyncImage(url: URL(string: imageName)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                                    .clipped()
                            } placeholder: {
                               ProgressView()
                            }

                        }

                    })
                    .onAppear {
                        Task {
                            await self.listItemAppears(character)
                        }
                    }
                }

            }
            .listStyle(.insetGrouped)
            .task {
                try? await vm.getCharactersListMarvel()
            }
            .refreshable {
                try? await vm.getCharactersListMarvel()
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
                    try await vm.sortFilterCharacters()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    sortTypeButton(sortType: $vm.sortType) {
                        try await vm.sortFilterCharacters()
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
            try? await vm.getCharactersListMarvel()
        }
    }
}
