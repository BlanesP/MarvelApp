//
//  Authorized.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation

protocol MarvelAuthorized { }

extension MarvelAuthorized {

    var authorization: MarvelAuthorization? {
        let publicKey = "7ddd4dc418f8d5ace7e32bda025539a7"
        guard let privateKey = privateKey else { return nil }
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = MD5(string: "\(timestamp)\(privateKey)\(publicKey)")

        return MarvelAuthorization(ts: timestamp, apikey: publicKey, hash: hash)
    }

    private var privateKey: String? {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
           return nil
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "MARVEL_PRIVATE_KEY") as? String else {
            return nil
        }
        return value
    }
}

struct MarvelAuthorization {
    let ts: String
    let apikey: String
    let hash: String
}
