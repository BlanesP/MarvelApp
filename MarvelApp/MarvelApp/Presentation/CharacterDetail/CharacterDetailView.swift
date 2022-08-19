//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

private extension LocalizedStringKey {
    static var nothingToSee: Self { "Nothing to see here..." }
    static var comics: Self { "Comics" }
    static var stories: Self { "Stories" }
    static var events: Self { "Events" }
    static var series: Self { "Series" }
}

private extension CGFloat {
    static var circleWidth: Self { 2 }
    static var imageSize: Self { 250 }
}

//MARK: - Main View

struct CharacterDetailView: View {

    @Environment(\.viewFactory) private var viewFactory

    let character: CharacterList.Character
    let attribution: String

    @State private var currentPickerSelection: PickerSelectionType = .comics

    var body: some View {
        VStack(alignment: .center, spacing: .sizeLargeExtra) {

            headerImage
                .padding(.top, .sizeMedium)

            pickerView

            if currentList.isEmpty {
                Text(.nothingToSee)
                    .font(.subheadline)
            } else {
                listView
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, .sizeLarge)
        .addAttribution(attribution)
        .navigationTitle(character.name)
    }

    var headerImage: some View {
        AsyncImage(url: character.iconUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: .imageSize, height: .imageSize)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: .circleWidth))
    }

    var pickerView: some View {
        Picker("", selection: $currentPickerSelection) {
            ForEach(PickerSelectionType.allCases, id: \.self) {
                Text($0.text).tag($0)
            }
        }
        .pickerStyle(.segmented)
    }

    var listView: some View {
        List(currentList, id: \.id) { item in
            ZStack {
                HStack {
                    Text(item.title)

                    Spacer()

                    if item.type != .story {
                        Image.arrowRight
                    }
                }
                .listRowSeparator(.hidden)
                .listRowInsets(
                    EdgeInsets(
                        top: .sizeMedium,
                        leading: .sizeMedium,
                        bottom: .sizeMedium,
                        trailing: .sizeMedium
                    )
                )

                if item.type != .story {
                    NavigationLink(
                        destination: viewFactory.characterItemView(for: item, attribution: attribution),
                        label: { EmptyView() }
                    )
                    .opacity(0)
                }
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
    }
}

//MARK: - Utils

private extension CharacterDetailView {
    var currentList: [CharacterItem] {
        switch currentPickerSelection {
        case .comics:
            return character.comics
        case .stories:
            return character.stories
        case .events:
            return character.events
        case .series:
            return character.series
        }
    }
}

//MARK: - Components

private enum PickerSelectionType: CaseIterable {
    case comics, stories, events, series

    var text: LocalizedStringKey {
        switch self {
        case .comics:
            return .comics
        case .stories:
            return .stories
        case .events:
            return.events
        case .series:
            return .series
        }
    }
}

//MARK: - Previews

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            character: CharacterList.Character(
                id: 1,
                name: "Test",
                iconUrl: URL(string: "https://www.apple.com")!,
                comics: [CharacterItem(id: 1, title: "A comic", type: .comic)],
                stories: [CharacterItem(id: 2, title: "A story", type: .story)],
                events: [],
                series: []
            ),
            attribution: "Preview"
        )
    }
}
