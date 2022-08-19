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
    var urlParams: [String]?

    func buildGETURL() -> URL? {
        var urlString = "\(baseURL.rawValue)/\(request.rawValue)"
        if let urlParams = urlParams, !urlParams.isEmpty {
            urlString.append("/\(urlParams.joined(separator: "/"))")
        }

        guard var components = URLComponents(string: urlString) else {
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
    case comics = "comics"
    case events = "events"
    case stories = "series"
}

enum BaseURLType: String {
    case marvel = "https://gateway.marvel.com:443/v1/public"
}
