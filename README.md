# MarvelApp

An iOS app that shows you all Marvel characters, and details of each one, using the [Marvel API](https://developer.marvel.com/)

## Architecture

This app is build with `Clean Architecture` and `MVVM`. For the views it uses `SwiftUI` and it's all connected with `Combine`.

To fetch the list of Marvel characters it uses `URLSession` to avoid third party dependencies. Even so, all the URLSession logic is contained in the DataSource so it can be easily modified.

The app also includes `Unit Tests` and `UI Tests`. 

## Usage

After downloading the app go to `Keys.plist` file. There you can find `MARVEL_PUBLIC_KEY` and `MARVEL_PRIVATE_KEY`. Please fill the fields with your own keys or don't hesitate to contact me for more information. 

## Credit

Data provided by Marvel. © 2022 Marvel
