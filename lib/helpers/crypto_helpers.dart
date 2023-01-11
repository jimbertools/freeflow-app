import 'dart:typed_data';

import 'package:flutter_sodium/flutter_sodium.dart';

KeyPair generateKeyPairFromEntropy(Uint8List entropy) {
  return Sodium.cryptoSignSeedKeypair(entropy);
}
