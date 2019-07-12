
# React Native Indy SDK

## Getting started

`$ npm install react-native-indy --save`

### Mostly automatic installation

`$ react-native link react-native-indy`

Add `Indy.framework` to Embedded libraries

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-indy` and add `RNIndy.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNIndy.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNIndyPackage;` to the imports at the top of the file
  - Add `new RNIndyPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-indy'
  	project(':react-native-indy').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-indy/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-indy')
  	```

## Usage
```javascript
import RNIndy from 'react-native-indy';
import { createWallet } from 'react-native-indy';

await createWallet("wallet1");
```
