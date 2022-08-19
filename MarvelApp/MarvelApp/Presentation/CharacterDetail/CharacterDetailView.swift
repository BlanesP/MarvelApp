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
    let character: CharacterList.Character
    let attribution: String

    @State private var currentList = [String]()
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
        .onAppear {
            currentList = character.comics
        }
    }

    var headerImage: some View {
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
    }

    var pickerView: some View {
        Picker("", selection: $currentPickerSelection) {
            ForEach(PickerSelectionType.allCases, id: \.self) {
                Text($0.text).tag($0)
            }
        }
        .pickerStyle(.segmented)
        .onChange(of: currentPickerSelection) { newValue in
            switch newValue {
            case .comics:
                currentList = character.comics
            case .stories:
                currentList = character.stories
            case .events:
                currentList = character.events
            case .series:
                currentList = character.series
            }
        }
    }

    var listView: some View {
        List(currentList, id: \.self) { item in
            Text(item)
                .buttonStyle(.plain)
        }
        .listStyle(.plain)
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
                icon: URL(string: "https://www.apple.com")!,
                comics: ["A comic"],
                stories: ["A story"],
                events: [],
                series: []
            ),
            attribution: "Preview"
        )
    }
}
