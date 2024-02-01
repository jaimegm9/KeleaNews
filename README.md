# KeleaNews by Jaime Gutiérrez

Native iOS app that starts with a home screen where news from de current country are shown at first, also you can search for news on the search bar. Tapping one, you are navigated to its detail screen, where you can see the whole article, also, in a Safari view inside the app.

# Usage:

Open *KeleaNews.xcworkspace*, select **KeleaNews** scheme, choose a simulator that runs on iOS 15.0 or above and press (CMD+R).

# Configuration:

The project has 2 environments, PROD and STAGE, that choose between two News API configurations, that currently are the same to make the project work fine in both environments. 
Feel free to add your own News API Key in *NewsApiConfig.swift* or add a fake token to see the error handling in the app.
Also the project has 2 schemes: **KeleaNews** which has PROD configuration and **KeleaNews-STAGE** with STAGE configuration

# Architecture:

The architecture used in the project is **MVVM-C**, which matches good with **SwiftUI** and **Combine** (used in the network layer).

# Project structure:

## Project:

- **App**: Contains the App and supporting files such as localizables (english and spanish) and Assets.
- **Service**: Contains the NewsAPI config, service and worker.
- **Model**: Contains model objects use in the whole app.
- **Scenes**: Contains the main 2 screens of the app: Home and Detail.
        
## Packages:

- **NetworkCombine**: Self develop network layer using Combine, since it fits really well with SwiftUI and MVVM, also in the assessment says using reactive programming was a plus.
- **DesignSystem**: Self develop Design package where I created some custom and reusable UI componentes, and also an ImageCombine component to load images using Combine and cache them.

# Testing:

## Unit Test:

The unit tests in this project have been done with the native library *XCTest*. 
Making a good use of the MVVM architecture and mocking the service worker.

- Usage: Select **KeleaNews** scheme and press (CMD+U)

## UI Test:

The UI tests in this project have been done using the Robot Pattern and the *XCTest* library.

- Usage: Select **KeleaNews** scheme and press (CMD+U). You might need to add an user to access the "Developer Tools" group, or just use a real device.
        
 
