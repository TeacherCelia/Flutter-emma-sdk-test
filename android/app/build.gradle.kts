plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // added: firebase
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.emma_flutter_example"
    compileSdk = 34 // changed
    ndkVersion = "27.0.12077973" // changed

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21 // changed
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions {
        jvmTarget = "21" // changed
    }    

    buildFeatures {
        buildConfig = true // added: buildconfig error
    }

    defaultConfig {
        applicationId = "com.example.emma_flutter_example"
        minSdk = 23 // changed
        targetSdk = 34 // changed
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// added: Firebase implementation
dependencies {
    implementation ("com.google.firebase:firebase-messaging:21.0.1") // Firebase
}

// added: jvm toolchain version error
kotlin {
    jvmToolchain(21) 
}

