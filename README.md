
# React Native Indy SDK

**iOS only at the moment**

## Getting started

`$ npm install react-native-indy --save`

### Mostly automatic installation

`$ react-native link react-native-indy`

Add `Indy.framework` to your Embedded libraries

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-indy` and add `RNIndy.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNIndy.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android (not supported yet)

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
import { randomBytes } from "crypto";
import Indy from "react-native-indy";

const createWallet = async () => {
	const name = `wallet` + Date.now();

	// make sure to use native randomBytes to ensure sound randomness!
	const seed = randomBytes(32).toString("hex");

	const key = await Indy.generateWalletKey(seed);
	await Indy.createWallet(name, key);
	return { name, key };
}

let walletHandle;

try {
	// load a wallet or create a wallet for the first time
	const { name, key } = storedWallet || await createWallet();

	// ... store the name and key for future use ...

	// open an existing wallet
	walletHandle = await Indy.openWallet(name, key);

	// ... do some work ...
} catch (e) {

	// ... handle the error ...

} finally {
	// clean up
	if (walletHandle) {
		await Indy.closeWallet(walletHandle);
	}
}

```
