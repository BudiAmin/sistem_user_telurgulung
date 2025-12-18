plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.uts_22"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.example.uts_22"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        // ✅ PERBAIKAN UTAMA
        versionCode = flutter.versionCode()
        versionName = flutter.versionName()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}

flutter {
    source = "../.."
}
