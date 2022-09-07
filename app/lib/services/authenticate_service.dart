import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

Future<bool> authenticateBiometrics () async {
  try {
    LocalAuthentication localAuth = LocalAuthentication();

    List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();

    print(availableBiometrics);

    if (!availableBiometrics.contains(BiometricType.fingerprint)) {
      return false;
    }


    bool isAuthenticated = await localAuth.authenticate(localizedReason: 'Please authenticate', biometricOnly: true);
    return isAuthenticated;
  }

  on PlatformException catch (e) {
    print(e);
    return false;
  }
}