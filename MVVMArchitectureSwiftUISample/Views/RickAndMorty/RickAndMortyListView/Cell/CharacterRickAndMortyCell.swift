//
//  CharacterRickAndMortyCell.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import SwiftUI

struct CharacterRickAndMortyCell: View {
    @ObservedObject var vm: RickAndMortyListCellViewModel
    var body: some View {
        ZStack(alignment: .top) {
            if let imageName = vm.character.image {
                AsyncImage(url: URL(string: imageName)) { image in
                    image
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .scaledToFill()
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
            Text(vm.character.name ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: -1, y: 1)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
                .padding(.leading, 16)
        }

        .background(content: {


        })
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CharacterRickAndMortyCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRickAndMortyCell(vm: RickAndMortyListCellViewModel(character: ResultRickAndMorty(id: 1, name: "Hulk", image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/hulk-avengers-age-of-ultron-1550250955.jpeg")))
    }
}
