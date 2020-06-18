# Apptiser 
iOS Technical Exam for Apptiser.

## Installation
Clone this repo and look for `Appetiser/Appetiser.xcworkspace`

## Architecture:
The architecture of this app is `MVVM-C` and `RxSwift` for bindings.
`C` stands for coordinator and the responsibility of coordinator is to coordinate between view controllers and view models or simply view navigations.

## Persistence:
The persistence mechanism of this app is `Realm`.
Realm because it is easy to setup and already had a built in extension for RXSwift bindings that is perfect for MVVM architecture.
Objects are also Codables for easy coding / decoding.

## UI:
The app used the default large title navigation.

|List View | Details View |
|--- | --- |
![llist](https://user-images.githubusercontent.com/6054907/85042955-697e2a00-b1be-11ea-81b5-01816d1f499f.png) | ![detail](https://user-images.githubusercontent.com/6054907/85043025-7d299080-b1be-11ea-981a-546e82336cd5.png) |
