//
//  AttributionTextModifier.swift
//  MarvelApp
//
//  Created by Pau Blanes on 19/8/22.
//

import SwiftUI

struct AttributionTextModifier: ViewModifier {
    let text: String?

    func body(content: Content) -> some View {
        if let text = text, !text.isEmpty {
            VStack(spacing: .zero) {
                content

                Spacer(minLength: .zero)

                Text(text)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, .sizeMedium)
                    .background(
                        Color.white
                            .defaultShadow()
                            .mask(Rectangle().padding(.top, -.sizeLarge))
                    )
            }
        } else { content }
    }
}
