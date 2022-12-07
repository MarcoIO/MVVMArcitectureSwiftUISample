//
//  MarvelDetailView.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 5/12/22.
//


import SwiftUI

struct MarvelDetailView: View {
    @ObservedObject var vm: MarvelDetailViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text(String(vm.characterDataSource?.title ?? ""))
                    .font(.largeTitle.bold())
                    .padding([.leading, .trailing, .bottom])
                if let imageName = vm.characterDataSource?.imageName {
                    AsyncImage(url: URL(string: imageName + "f")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .clipped()
                    } placeholder: {
                       Image(systemName: "photo.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .foregroundColor(.gray)

                    }

                }
                List {
                    ForEach(vm.characterDataSource?.sections ?? [], id:\.self) { section in
                        Section {
                            ForEach(section.items, id:\.self) { item in
                                Text(item.title)
                            }
                        } header: {
                            Text(section.title)
                                .font(.caption)
                            }
                        }
                    }
                .listStyle(.sidebar)
                .padding()
                }
                .overlay {
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
                .task {
                    await vm.getCharacterDetailMarvel()
                }
        }

    }
}

struct MarvelDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MarvelDetailView(vm: MarvelDetailViewModel(idCharacter: 1011334))
    }
}


