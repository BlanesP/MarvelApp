//
//  String+MD5.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Foundation
import CryptoKit

extension String {
    var md5: Self {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    var secureUrl: Self {
        self.replacingOccurrences(of: "http:", with: "https:")
    }
}

