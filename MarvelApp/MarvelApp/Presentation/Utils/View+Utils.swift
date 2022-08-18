//
//  View+Utils.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

private extension Color {
    static var shadowColor: Self { .black.opacity(0.2) }
}

extension View {
    func defaultShadow() -> some View {
        self.shadow(color: .shadowColor, radius: .sizeSmall)
    }
}
