# IG Story

## Description

IG Story is a Flutter project that implements the story feature of Instagram. It allows users to view stories shared by different users.

## Features

- View stories shared by different users.
- Navigate through the stories seamlessly.

## Important Developer Implementations

- **Caching Mechanism with SQFLite**: IG Story implements a caching mechanism using SQFLite, a lightweight and efficient local database solution for Flutter. This allows the application to store and retrieve stories locally, optimizing performance and providing a seamless user experience.

- **Singleton Registry**: The project utilizes a singleton registry pattern to manage and access shared resources across different parts of the application. This helps in maintaining a centralized state and ensures consistency in data access and manipulation.

- **State Management with Cubit**: For state management, IG Story uses Cubit, a lightweight and reactive state management solution provided by the Flutter_bloc package. Cubit simplifies the management of application state and facilitates the separation of concerns in the project architecture.

- **Custom Gesture Service**: IG Story incorporates a custom gesture service that enables granular differentiation between user gestures. This service plays a crucial role in distinguishing between various gestures, enhancing the user experience and interaction within the application.

## Future Implementations

Although certain features could not be implemented in the current version, the code has been written in a modular and extensible manner, making it easy to add new features in the future. Some potential future implementations include:

1. **Pausing a Story**: Implementing a feature to pause a story when the user holds the screen can be achieved using the custom gesture recognition service.

2. **Marking a Story as Seen**: The caching database is designed with the capability to mark stories as seen. This feature can be added in future updates to enhance user experience.

## Installation

To run IG Story locally, follow these steps:

1. Clone the repository:
    ```sh
    git clone https://github.com/yash2616/ig_story.git
    ```

2. Navigate to the project directory:
    ```sh
    cd ig_story
    ```

3. Install dependencies:
    ```sh
    flutter pub get
    ```

4. Run the project:
    ```sh
    flutter run
    ```

## Integration Testing

Run the following command:
   ```sh
   flutter test integration_test/app_test.dart
   ```

## Usage

IG Story is a mobile application. After installation, users can launch the app on their mobile phones and start viewing stories shared by different users.

## Contributing

Contributions are welcome! If you'd like to contribute to IG Story, please fork the repository, make your changes, and submit a pull request. Make sure to follow the project's coding standards and guidelines.

## License

This project is open source and available under the [MIT License](LICENSE).
