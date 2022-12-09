//
//  RickAndMortyListCellViewModel.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import UIKit

final class RickAndMortyListCellViewModel:ObservableObject {
    var character: ResultRickAndMorty
    @Published var imageCharacter: UIImage?


    public init(character: ResultRickAndMorty) {
        self.character = character
        getImage()
    }

    func getImage() {
        if let image = character.image, let urlImage = URL(string: image) {
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
        if let imageName = character.image, let urlImage =  URL(string: imageName) {
            do {
                imageCharacter = try await AsyncImageLoader().getImage(url: urlImage)
            } catch {
                print("Error al cargar \(urlImage)")
            }
        }
    }
}
