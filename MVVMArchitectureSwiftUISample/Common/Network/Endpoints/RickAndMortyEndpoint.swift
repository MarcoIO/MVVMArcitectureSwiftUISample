//
//  RickAndMortyEndpint.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 7/12/22.
//

import Foundation

enum RickAndMortyEndpoint {
    case getAllCharactersRickAndMorty(page: Int, nameFilter: String?, gender: Gender?, status: Status?)
}

extension RickAndMortyEndpoint: APIEndpoint {
    var basePath: String {
       return "rickandmortyapi.com/api"
    }

    var path: String {
        switch self {
        case .getAllCharactersRickAndMorty (let page, let nameFilter, let genderFilter, let statusFilter):
            var pathUrl = "/character/?page=\(page)"
            if let name = nameFilter {
              pathUrl += "&name=\(name)"
            }
            if let gender = genderFilter {
                pathUrl += "&gender=\(gender)"
            }
            if let status = statusFilter {
                pathUrl += "&status=\(status)"
            }
            return pathUrl
        }
    }

    var method: RequestMethod {
        switch self {
        case .getAllCharactersRickAndMorty:
            return .get
        }
    }

    var contentType: ContentType {
        switch self {
        case .getAllCharactersRickAndMorty:
            return .formUrlEncoded
        }
    }

    var header: [String: String]? {

        switch self {
        case .getAllCharactersRickAndMorty:
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
        case .getAllCharactersRickAndMorty:
            return nil
        }
    }
}
