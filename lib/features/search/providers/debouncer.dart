import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  Timer? _timer;

  void run(VoidCallback action) {
    dispose();
    _timer = Timer(const Duration(seconds: 1), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
