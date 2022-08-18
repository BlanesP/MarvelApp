//
//  CharacterDetailView.swift
//  MarvelApp
//
//  Created by Pau Blanes on 18/8/22.
//

import SwiftUI

private extension LocalizedStringKey {
    static var nothingToSee: Self { "Nothing to see here..." }
}

private extension CGFloat {
    static var circleWidth: Self { 2 }
    static var imageSize: Self { 250 }
}

//MARK: - Main View

struct CharacterDetailView: View {
    let character: CharacterList.Character

    @State private var currentList = [String]()

    var body: some View {
        VStack(alignment: .center, spacing: .sizeLargeExtra) {

            headerImage

            pickerView

            if currentList.isEmpty {
                Text(.nothingToSee)
                    .font(.subheadline)
            } else {
                listView
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, .sizeLarge)
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
            .padding(.top, .sizeMedium)
    }

    var pickerView: some View {
        Picker("What is your favorite color?", selection: $currentList) {
            Text("Comics").tag(character.comics)
            Text("Stories").tag(character.stories)
            Text("Events").tag(character.events)
            Text("Series").tag(character.series)
        }
        .pickerStyle(.segmented)
    }

    var listView: some View {
        List(currentList, id: \.self) { item in
            Text(item)
                .buttonStyle(.plain)
        }
        .listStyle(.plain)
    }
}

//MARK: - Previews

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            character: CharacterList.Character(
                id: 1,
                name: "Test",
                icon: URL(string: "")!,
                comics: [],
                stories: [],
                events: [],
                series: []
            )
        )
    }
}
