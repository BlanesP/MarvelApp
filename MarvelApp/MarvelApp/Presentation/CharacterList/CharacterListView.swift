//
//  CharacterListView.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import Combine
import SwiftUI

private extension CGFloat {
    static var progressScale: Self { 1.5 }
    static var circleWidth: Self { 2 }
    static var imageSize: Self { 44 }
}

private extension LocalizedStringKey {
    static var allCharacters: Self { "All Marvel Characters!" }
    static var errorMsg: Self { "Ups! Something went wrong." }
    static var tryAgain: Self { "Try again" }
}

private extension String {
    static func summary(comics: Int, stories: Int, events: Int, series: Int) -> Self {
        let itemList = [
            comics > 0 ? "\(comics) \(comics > 1 ? "Comics" : "Comic")" : nil,
            stories > 0 ? "\(stories) \(stories > 1 ? "Stories" : "Story")" : nil,
            events > 0 ? "\(events) \(events > 1 ? "Events" : "Event")" : nil,
            series > 0 ? "\(series) \(series > 1 ? "Series" : "Serie")" : nil
        ]

        let result = itemList.compactMap{ $0 }.joined(separator: ", ")

        return result.isEmpty ? "No appearences" : result
    }
}

//MARK: - Main View

struct CharacterListView: View {
    @Environment(\.viewFactory) private var viewFactory

    @ObservedObject var viewModel: CharacterListViewModel

    @State private var loading = false
    @State private var loadingMore = false
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                if loading {
                    ProgressView()
                        .scaleEffect(.progressScale)
                        .padding(.top, .sizeLargeExtra)
                } else {
                    characterList

                    if loadingMore {
                        ProgressView()
                    }
                }

                Spacer()
            }
            .navigationTitle(.allCharacters)
        }
        .alert(.errorMsg, isPresented: $showError) {
            Button(.tryAgain, role: .cancel) { [weak viewModel] in
                viewModel?.input(.fetchData(refresh: true))
            }
        }
        .onReceive(viewModel.output, perform: output)
        .onAppear { [weak viewModel] in
            viewModel?.input(.fetchData(refresh: true))
        }
    }

    var characterList: some View {
        List(viewModel.characters) { character in
            CharacterRowView(character: character)
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: .sizeMedium,
                        leading: .sizeMedium,
                        bottom: .sizeMedium,
                        trailing: .sizeMedium
                    )
                )
                .background(
                    NavigationLink(
                        destination: viewFactory.characterDetailView(for: character),
                        label: { EmptyView() }
                    )
                    .opacity(0)
                )
                .onAppear { [weak viewModel] in
                    if character.id == viewModel?.characters.last?.id {
                        viewModel?.input(.fetchData(refresh: false))
                    }
                }
        }
        .listStyle(.plain)
    }
}

//MARK: - AdditionalViews

private struct CharacterRowView: View {
    let character: CharacterList.Character

    var body: some View {
        HStack(alignment: .center, spacing: .sizeLarge) {

            AsyncImage(url: character.icon) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: .imageSize, height: .imageSize)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: .circleWidth))

            VStack(alignment: .leading, spacing: .sizeSmall) {
                Text(character.name)
                    .font(.headline)
                    .bold()

                Text(
                    String.summary(
                        comics: character.comics.count,
                        stories: character.stories.count,
                        events: character.events.count,
                        series: character.series.count
                    )
                )
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }

            Spacer()

            Image.arrowRight
        }
        .foregroundColor(.black)
        .padding(.sizeLarge)
        .background(Color.white)
        .cornerRadius(.sizeNormal)
        .defaultShadow()
    }
}

//MARK: - Performs

private extension CharacterListView {
    func output(_ value: CharacterListViewModel.ViewOutput) {
        loadingMore = (value == .loadingMore)
        loading = (value == .loading)

        if case .error = value { showError = true }
    }
}

//MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewFactory().characterListView
    }
}
