import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'src/app.dart';

void main() {
  const myApp = MyApp();
  runApp(
    const ProviderScope(
      child: myApp,
    ),
  );
}
