//
//  CharacterItemView.swift
//  MarvelApp
//
//  Created by Pau Blanes on 19/8/22.
//

import SwiftUI

private extension LocalizedStringKey {
    static var readMore: Self { "Read more" }
    static var errorMsg: Self { "Ups! Something went wrong." }
    static var ok: Self { "OK" }
}

private extension CGFloat {
    static var progressScale: Self { 1.5 }
}

//MARK: - Main View

struct CharacterItemView: View {
    @ObservedObject var viewModel: CharacterItemViewModel
    let attribution: String

    @State private var loading = false
    @State private var showError = false

    var body: some View {
        VStack {
            Text(viewModel.item.title)
                .font(.title)
                .bold()

            if loading {
                ProgressView()
                    .scaleEffect(.progressScale)
                    .padding(.top, .sizeLargeExtra)
            } else {
                contentView
                    .padding(.vertical, .sizeLarge)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, .sizeNormal)
        .addAttribution(attribution)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(viewModel.output, perform: output)
        .onAppear { [weak viewModel] in
            viewModel?.input(.fetchData)
        }
        .alert(.errorMsg, isPresented: $showError) {
            Button(.ok, role: .cancel, action: {})
        }
    }

    var contentView: some View {
        VStack(spacing: .sizeNormal) {
            if let description = viewModel.item.description {
                Text(description)
                    .font(.subheadline)
                    .italic()
            }

            if let imageUrl = viewModel.item.imageUrl {
                AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                } placeholder: { ProgressView() }
            }

            Spacer()

            if let detailUrl = viewModel.item.detailUrl {
                Link(.readMore, destination: detailUrl)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

//MARK: - Performs

private extension CharacterItemView {
    func output(_ value: CharacterItemViewModel.ViewOutput) {
        loading = (value == .loading)

        if case .error = value { showError = true }
    }
}

//MARK: - Previews

struct CharacterItemView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory().characterItemView(for: CharacterItem(id: 1, title: "Test", type: .comic), attribution: "Preview")
    }
}
