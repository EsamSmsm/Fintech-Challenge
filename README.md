# Flutter FinTech Challenge

### Overview

A Flutter app showcasing a FinTech dashboard with metrics and graph visualizations. Runs on iOS,
Android, and Web with a responsive UI.

### Features

- Metrics Overview: View key stats like total orders, average price, and returned orders.

- Graph Visualization: Analyze trends with dynamic charts.

- Responsive Design: Optimized for mobile and web.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio)
- [Xcode](https://developer.apple.com/xcode/) (for iOS development)

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/EsamSmsm/Fintech-Challenge.git
    cd fintech_challenge
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Run the app:
    ```sh
    flutter run
    ```

### Project Structure

- `lib/`: Contains the main source code for the application.
- `test/`: Contains the test files for the application.
- `assets/`: Contains the assets used in the application, such as images and JSON files.
- `pubspec.yaml`: Contains the dependencies and other project configurations.

### Dependencies

- **flutter_bloc**: State management library for Flutter using the BLoC pattern.
- **equatable**: Simplifies equality comparisons.
- **responsive_framework**: Helps in building responsive layouts.
- **google_fonts**: Allows you to use Google Fonts in your Flutter app.
- **animated_digit**: Provides animated digit widgets.
- **flutter_svg**: Renders SVG images in Flutter.
- **syncfusion_flutter_charts**: Provides a wide range of chart widgets.

### Dev Dependencies

- **flutter_test**: Provides testing utilities for Flutter apps.
- **flutter_lints**: Contains a set of recommended lints to encourage good coding practices.
- **build_runner**: A build system for Dart code generation.

### Assets

- `assets/json/orders.json`: Contains order data in JSON format.
- `assets/images/`: Contains image assets used in the application.

### Running Tests

To run tests, use the following command:

```sh
flutter test