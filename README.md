# Star Wars App

 
 ## About this App
 The app allows the user to view all the characters in the Star Wars movies. Once the user selects a specific character, he/she will be able to see the following details about the character And also the film's character has acted in.

 ### I use this API to provide the data for the Star Wars movies. 

 ```
 https://swapi.dev/api/
 ```

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/Essam101/Star-Wars-App.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

## iOS
You can use the commands `flutter build` and `flutter run` from the app's root
directory to build/run the app or you can open `ios/Runner.xcworkspace` in Xcode
and build/run the project as usual.

```
flutter build
```
```
flutter run
```
## Android
You can use the commands `flutter build` and `flutter run` from the app's root
directory to build/run the app or to build with Android Studio, open the
`android` folder in Android Studio and build the project as usual.

 

## Star Wars App Features:

* Splash
* Characters
* Character Data
* Routing
* Caching


## Caching 
When displaying the film name I noticed that the character obj has `List<String>` and the list contains URLs.
So, to get the film names I should loop o(n) time and every time I need to request to get the data. Because of this, it will have bad performance. 
Therefore, I made the program able to cache the data and delete it every time the user closes the application.

 

 

### Libraries & Tools Used

* [Flutter_pagination_wrapper](https://github.com/hacker1024/flutter_pagination_wrapper.git)
* [Http](https://github.com/dart-lang/http)
* [path_provider](https://github.com/flutter/plugins)

 

### Folder Structure
Here is the core folder structure which flutter provides.

```
star-wars/
|- android
|- build
|- ios
|- lib
|- test
```


### lib
Here is the folder structure that I have used in this project.

```
lib/
|- api/
|- constants/
|- models/
|- pages/
|- main.dart
|- routes.dart

 ```

 

 ### API
```
api/
|- ApiServiceProvider.dart
```


### Constants

This directory contains all the application level constants. 

```
Constants/
|- constant.dart
```

 
### Models


```
Models/
|- caractersModel.dart
|- filmModel.dart
```

### Pages


```
Pages/
|- characterDetailsScreen.dart
|- characterScreen.dart
|- splashScreen.dart
```

### Main.dart

```
main.dart
```

### Routes.dart

```
routes.dart
```

## 

* [Download the application for Android](http://www.mediafire.com/file/nym6kvr67m7tezg/app-release.apk/file)








