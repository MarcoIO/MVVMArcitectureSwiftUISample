//
//  CharacterCell.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 2/12/22.
//


import SwiftUI

struct CharacterCell: View {
    @ObservedObject var vm: MarvelListCellViewModel
    var body: some View {
        ZStack(alignment: .top) {
//            if let thumbnail = vm.character.thumbnail, let path = thumbnail.path, let exten = thumbnail.exten {
//                let imageName = path + "." + exten
//                AsyncImage(url: URL(string: imageName)) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 250)
//                        .clipped()
//                } placeholder: {
//                   Image(systemName: "photo.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
//                        .clipped()
//                        .foregroundColor(.gray)
//                }
//
//            }

            if let characterImage = vm.imageCharacter {
                Image(uiImage: characterImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .clipped()
            } else {
                Image(systemName: "photo.fill")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 100, height: 100)
                     .clipped()
                     .foregroundColor(.gray)
            }
            Text(vm.character.name ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1, x: -1, y: 1)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding()
        }

        .background(content: {


        })
        .listRowSeparator(.hidden)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(vm: MarvelListCellViewModel(character: CharactersList(name: "Hulk", thumbnail: Thumbnail(exten: "jpeg", path: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/hulk-avengers-age-of-ultron-1550250955"))))
    }
}
