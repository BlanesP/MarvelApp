//
//  MarvelAppApp.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

@main
struct MarvelAppApp: App {

    let viewFactory = ViewFactory()

    var body: some Scene {
        WindowGroup {
            viewFactory.characterListView
        }
    }
}
