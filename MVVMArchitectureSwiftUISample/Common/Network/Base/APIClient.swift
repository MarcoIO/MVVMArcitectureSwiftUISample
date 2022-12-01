//
//  APIClient.swift
//  MVVMArchitectureSwiftUISample
//
//  Created by marco.iniguez.ollero on 30/11/22.
//


import Foundation

protocol APIClientProtocol {
    func sendRequest<T: Decodable>(endpoint: APIEndpoint, responseModel: T.Type) async throws -> T
}

final class APIClient: APIClientProtocol {
    static let shared = APIClient()
    func sendRequest<T: Decodable>(
        endpoint: APIEndpoint,
        responseModel: T.Type
    ) async throws -> T {

        let urlString = endpoint.scheme + endpoint.basePath + endpoint.path

        guard let url = URL(string: urlString) else {
            throw CustomNetworkError.unsuppotedURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            switch endpoint.contentType {
            case .json:
              // Parameters
                do {
                    request.httpBody = try getBodyJSONParams(parameters: body)
                } catch {
                    throw CustomNetworkError.decode
                }

            case .formUrlEncoded:
              // Parameters
                request.httpBody = getBodyFormUrlEncodedParams(parameters: body)

            case .multipart:
              // Parameters
              break
            }
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw CustomNetworkError.invalidResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw CustomNetworkError.decode
                }
                return decodedResponse
            case 401:
                throw CustomNetworkError.unauthorized
            default:
                throw CustomNetworkError.serverError
            }
        } catch {
            throw CustomNetworkError.serverUnavailable
        }
    }
}

private extension APIClient {
    func getBodyJSONParams(parameters: [String: String]) throws -> Data? {
      do {
        return try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch {
          throw CustomNetworkError.decode
      }
    }

    func getBodyFormUrlEncodedParams(parameters: [String: String]) -> Data? {
      guard let postData = parameters.queryString.data(using: .utf8)
      else { return nil }
      return postData
    }
}
