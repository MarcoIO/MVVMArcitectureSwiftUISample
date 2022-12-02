//
//  CharacterCell.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 2/12/22.
//


import SwiftUI

struct CharacterCell: View {
    @ObservedObject var vm: MarvelListViewModel
    let character: CharactersList
    var body: some View {
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
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCell(vm: MarvelListViewModel(), character: CharactersList(name: "HULK", thumbnail: Thumbnail(exten: "jpeg", path: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/hulk-avengers-age-of-ultron-1550250955")))
    }
}
