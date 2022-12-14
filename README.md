# MarvelApp

An iOS app that shows you all Marvel characters, and details of each one, using the [Marvel API](https://developer.marvel.com/)

## Architecture

This app is build with `Clean Architecture` and `MVVM`. For the views it uses `SwiftUI` and it's all connected with `Combine`.

To fetch the list of Marvel characters it uses `URLSession` to avoid third party dependencies. Even so, all the URLSession logic is contained in the DataSource so it can be easily modified.

The app also includes `Unit Tests`, `UI Tests` and `Snapshot Testing`.

## Usage

After downloading the app go to `Keys.plist` file. There you can find `MARVEL_PUBLIC_KEY` and `MARVEL_PRIVATE_KEY`. Please fill the fields with your own keys or don't hesitate to contact me for more information. 

## Changelog

- 1.0.0 (19/08/2022): See all Marvel characters and details of each one.

- 1.0.1 (21/08/2022):
    - Fixed memory leak. 
    - Fixed threading error.
    - Improved character item view.
    
- 1.1.0 (25/08/2022):
    - Added snapshot testing
    - Improved unit testing coverage

## Credit

Data provided by Marvel. © 2022 Marvel
