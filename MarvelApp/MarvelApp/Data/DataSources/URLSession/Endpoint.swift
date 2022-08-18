//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import Foundation

//MARK: - Private extensions

private extension Encodable {
    var urlQueryItems: [URLQueryItem] {
        let mirror = Mirror(reflecting: self)

        return mirror.children.compactMap { child in
            guard let key = child.label else { return nil }
            return URLQueryItem(name: key, value: child.value as? String ?? "\(child.value)")
        }
    }
}

//MARK: -

struct Endpoint {
    private var baseURL: String { "https://gateway.marvel.com:443/v1/public" }

    let type: EndpointType
    let params: Encodable?

    func buildGetURL() -> URL? {
        guard var components = URLComponents(string: "\(baseURL)/\(type.rawValue)") else {
            return nil
        }
        if let params = params {
            components.queryItems = params.urlQueryItems
        }

        return components.url
    }
}

//MARK: - Components

enum EndpointType: String {
    case characters = "characters"
}
