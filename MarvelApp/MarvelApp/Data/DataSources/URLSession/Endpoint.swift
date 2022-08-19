//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import Foundation

private extension Encodable {
    var urlQueryItems: [URLQueryItem] {
        let mirror = Mirror(reflecting: self)

        return mirror.children.compactMap { child in
            guard let key = child.label else { return nil }
            return URLQueryItem(name: key, value: child.value as? String ?? "\(child.value)")
        }
    }
}

struct Endpoint {

    let baseURL: BaseURLType
    let request: RequestType
    let params: Encodable?

    func buildGETURL() -> URL? {
        guard var components = URLComponents(string: "\(baseURL.rawValue)/\(request.rawValue)") else {
            return nil
        }
        if let params = params {
            components.queryItems = params.urlQueryItems
        }

        return components.url
    }
}

//MARK: - Components

enum RequestType: String {
    case characters = "characters"
}

enum BaseURLType: String {
    case marvel = "https://gateway.marvel.com:443/v1/public"
}
