# Vocabulario

The app Vocabulario is being developed with two ideas in mind:
- Improving my skills as flutter developer by implementing a project of medium size
- Enhancing my learning efforts for learning spanish as native german speaker 

## Getting Started

This is standard flutter project, so to run the app, follow these steps:
1. Clone the repository
2. Download the dependencies with `flutter pub get`
3. Run the app on a device of your choice with `flutter run`

## App-Architecture
 
The app follows my standard way of architecturing a flutter app and contains the following folders in the lib directory:
- **mock**: Contains mocked data for developing and testing the app.
- **models**: Contains data models used throughout the app.
- **providers**: Contains the business logic of the in the form of providers. These use services and are used by the screens and widgets.
- **screens**: Contains a subfolder for each screen within the app and is the main place for UI related code. Each of these subfolders may include another subfolder for widgets only used within that screen.
- **services**: Contains service classes used for interacting with various APIs (e.g. Bluetooth, WiFi, Persistent storage, Networking, etc.).
- **widgets**: Contains widgets which are used on more than one screen (e.g. a default loading widget or error widget).

## Code-conventions

- All self created `.dart` files are prefixed with `vc_`. All dart classes are prefixed with `Vc`. This is used for clear separation and quick search.
- Formatting is handled by the default flutter formatter