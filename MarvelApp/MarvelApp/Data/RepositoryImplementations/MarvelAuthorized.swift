//
//  MarvelAuthorized.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation

protocol MarvelAuthorized { }

extension MarvelAuthorized {
    var authorization: MarvelAuthorization? {
        guard let privateKey = getKey("MARVEL_PRIVATE_KEY"),
              let publicKey = getKey("MARVEL_PUBLIC_KEY")
        else { return nil }
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5

        return MarvelAuthorization(ts: timestamp, apikey: publicKey, hash: hash)
    }
}

//MARK: - Utils

private extension MarvelAuthorized {
    func getKey(_ key: String) -> String? {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
           return nil
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        return plist?.object(forKey: key) as? String
    }
}

//MARK: - Components

struct MarvelAuthorization {
    let ts: String
    let apikey: String
    let hash: String
}
