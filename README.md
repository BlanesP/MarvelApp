# MarvelApp

An iOS app that shows you all marvel characters and details of each one using the [Marvel API](https://developer.marvel.com/)

## Architecture

This app is build with `Clean Architecture` and `MVVM`. For the views it uses `SwiftUI` and it's all connected with `Combine`.

To fetch the list of Marvel characters it uses `URLSession` to avoid third party dependencies. Even so, all the URLSession logic is contained in the DataSource so it can be easily modified.

It also features `Unit Tests`and `UI Tests`. 

## Use

After downloading the app go to `Keys.plist` file. There you can find `MARVEL_PUBLIC_KEY` and `MARVEL_PRIVATE_KEY`. Please fill the fields with your own keys or don't hesitate to contact me for more information. 

## Credit

Data provided by Marvel. © 2022 Marvel
