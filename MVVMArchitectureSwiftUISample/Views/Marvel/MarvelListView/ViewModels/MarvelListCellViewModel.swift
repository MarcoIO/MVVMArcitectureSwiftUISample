//
//  MarvelListCellViewModel.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//

import UIKit

final class MarvelListCellViewModel:ObservableObject {
    var character: CharactersList
    @Published var imageCharacter: UIImage?


    public init(character: CharactersList) {
        self.character = character
        getImage()
    }

    func getImage() {
        if let thumbnail = character.thumbnail, let path = thumbnail.path, let exten = thumbnail.exten, let urlImage =  URL(string: path + "." + exten) {
            let url = URL.cachesDirectory.appending(path: urlImage.lastPathComponent)
            if FileManager.default.fileExists(atPath: url.path()) {
                do {
                    let data = try Data(contentsOf: url)
                    self.imageCharacter = UIImage(data: data)
                } catch {
                    print("Error en la carga \(url)")
                }
            } else {
                Task {
                    await getImageAsync()
                }
            }
        }
    }

    @MainActor
    func getImageAsync() async {
        if let thumbnail = character.thumbnail, let path = thumbnail.path, let exten = thumbnail.exten, let urlImage =  URL(string: path + "." + exten) {
            do {
                imageCharacter = try await AsyncImageLoader().getImage(url: urlImage)
            } catch {
                print("Error al cargar \(urlImage)")
            }
        }
    }
}
