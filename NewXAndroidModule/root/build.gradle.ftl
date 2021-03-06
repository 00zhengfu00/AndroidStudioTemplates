<#import "root://activities/common/kotlin_macros.ftl" as kt>
apply plugin: 'com.android.application'
<@kt.addKotlinPlugins />

android {
    compileSdkVersion build_versions.target_sdk
    buildToolsVersion build_versions.build_tools
    
    defaultConfig {
        applicationId "${packageName}"
        minSdkVersion 14
        targetSdkVersion build_versions.target_sdk
        versionCode 1
        versionName "1.0"
        testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
    }

    if (isNeedPackage.toBoolean()) {
        signingConfigs {
            release {
                storeFile file(app_release.storeFile)
                storePassword app_release.storePassword
                keyAlias app_release.keyAlias
                keyPassword app_release.keyPassword
            }
        }
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            if (isNeedPackage.toBoolean()) {
                signingConfig signingConfigs.release
            }
        }
    }

    if (isNeedPackage.toBoolean()) {
        applicationVariants.all { variant ->
            variant.outputs.all {
                if (variant.buildType.name.equals('release')) {
                    outputFileName = "demo.apk"
                }
            }
        }
    }

    lintOptions {
        abortOnError false
    }
    
}

dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar'])
    implementation deps.support.app_compat
     testImplementation deps.junit
    androidTestImplementation deps.runner
    androidTestImplementation deps.espresso.core
    
    //XUtil
    implementation 'com.github.xuexiangjys.XUtil:xutil-core:+'
    //XPage
    implementation 'com.github.xuexiangjys.XPage:xpage-lib:+'
    annotationProcessor 'com.github.xuexiangjys.XPage:xpage-compiler:+'
    //butterknife的sdk
    implementation 'com.jakewharton:butterknife:8.8.1'
    annotationProcessor 'com.jakewharton:butterknife-compiler:8.8.1'

    <@kt.addKotlinDependencies />
}
