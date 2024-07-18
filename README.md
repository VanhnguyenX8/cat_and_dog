# cat_and_dog 

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Normal run
```
flutter run
```

## Define env variable
```
flutter run --dart-define=SOME_VAR=SOME_VALUE --dart-define=OTHER_VAR=OTHER_VALUE
```

# Build
## Apk
```
flutter build apk --split-per-abi --release --target-platform=android-arm64 --analyze-size
```
## Bundle
```
flutter build appbundle --release --obfuscate --split-debug-info=build
```
## Web
```
flutter build web
```
## IOS
Use Xcode, [online documentation](https://flutter.dev/docs/deployment/ios)
```
flutter build ipa --release --obfuscate --split-debug-info=build
```
- apk
```
flutter build apk --split-per-abi --release --obfuscate --split-debug-info=build
```
# Generate models, datas

## Generate models
```
dart run build_runner build --delete-conflicting-outputs
```
```
dart run build_runner build --delete-conflicting-outputs --build-filter=<path_file>
```
## generate icon
```
dart run flutter_launcher_icons:main
```
## generate splash
```
dart run flutter_native_splash:create
```
## upgrade pub
```
dart upgrade --major-versions --dry-run
```
