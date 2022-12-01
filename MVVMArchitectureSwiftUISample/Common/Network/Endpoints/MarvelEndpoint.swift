//
//  MarvelEndpoint.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 30/11/22.
//


import Foundation

enum MarvelEndpoint {
    case getCharactersListMarvel(page: Int)
    case getCharacterDetailMarvel(id: Int)
}

extension MarvelEndpoint: APIEndpoint {
    var basePath: String {
       return "gateway.marvel.com:443"
    }

    var path: String {
        switch self {
        case .getCharactersListMarvel (let page):
            let timestamp = Int(Date().timeIntervalSince1970)
            let publicKey = APIMarvelKeys.publicKey
            let privateKey = APIMarvelKeys.privateKey
            let hash = "\(timestamp)\(privateKey)\(publicKey)"
            let limit = 20
            let offset = limit * page
            return "/v1/public/characters" + "?\(APIParameterKey.timestamp.rawValue)=\(timestamp)"
              + "&\(APIParameterKey.hash.rawValue)=\(hash.md5())"
              + "&\(APIParameterKey.apiKey.rawValue)=\(publicKey)"
              + "&\(APIParameterKey.limit.rawValue)=\(limit)"
              + "&\(APIParameterKey.offset.rawValue)=\(offset)"
        case .getCharacterDetailMarvel(let id):
            let timestamp = Int(Date().timeIntervalSince1970)
            let publicKey = APIMarvelKeys.publicKey
            let privateKey = APIMarvelKeys.privateKey
            let hash = "\(timestamp)\(privateKey)\(publicKey)"
            return "/v1/public/characters/\(id)" + "?\(APIParameterKey.timestamp.rawValue)=\(timestamp)"
              + "&\(APIParameterKey.hash.rawValue)=\(hash.md5())"
              + "&\(APIParameterKey.apiKey.rawValue)=\(publicKey)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .getCharactersListMarvel, .getCharacterDetailMarvel:
            return .get
        }
    }

    var contentType: ContentType {
        switch self {
        case .getCharactersListMarvel, .getCharacterDetailMarvel:
            return .formUrlEncoded
        }
    }

    var header: [String: String]? {
        // Access Token to use in Bearer header
       // let accessToken = "insert your access token here -> https://www.themoviedb.org/settings/api"
        switch self {
        case .getCharactersListMarvel, .getCharacterDetailMarvel:
//            return [
//                "Authorization": "Bearer \(accessToken)",
//                "Content-Type": "application/json;charset=utf-8"
//            ]
            return [
                HTTPHeaderField.acceptType.rawValue : HeadersParams.defaultAccept.rawValue,
                HTTPHeaderField.connection.rawValue :  HeadersParams.keepAlive.rawValue ,
                HTTPHeaderField.acceptEncoding.rawValue :  HeadersParams.gzipDeflateBr.rawValue ,
                HTTPHeaderField.contentType.rawValue : contentType.rawValue
            ]
        }
    }

    var body: [String: String]? {
        switch self {
        case .getCharactersListMarvel, .getCharacterDetailMarvel:
            return nil
        }
    }
}
