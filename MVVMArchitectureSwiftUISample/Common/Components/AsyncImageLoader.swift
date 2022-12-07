//
//  AsyncImageLoader.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//


import UIKit
 
final class AsyncImageLoader {
    func getImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        if let image, let data = image.pngData() {
            let url = URL.cachesDirectory.appending(path: url.lastPathComponent)
            try data.write(to: url, options: [.atomic])
        }
        return image
    }
}
