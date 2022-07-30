import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keyboard_utils/keyboard_listener.dart' as kb_listener;
import 'package:keyboard_utils/keyboard_utils.dart' as kb_utils;

class KeyboardBloc {
  kb_utils.KeyboardUtils _keyboardUtils = kb_utils.KeyboardUtils();
  StreamController<double> _streamController = StreamController<double>();
  Stream<double> get stream => _streamController.stream;

  kb_utils.KeyboardUtils get keyboardUtils => _keyboardUtils;

  late int _idKeyboardListener;

  void start(
      VoidCallback onActivateKeyboard, VoidCallback onActivateKeyboard2) {
    _idKeyboardListener = _keyboardUtils.add(
      listener: kb_listener.KeyboardListener(
        willHideKeyboard: () {
          _streamController.sink.add(_keyboardUtils.keyboardHeight);
          onActivateKeyboard2();
        },
        willShowKeyboard: (double keyboardHeight) {
          _streamController.sink.add(keyboardHeight);
          onActivateKeyboard();
        },
      ),
    );
  }

  void dispose() {
    _keyboardUtils.unsubscribeListener(subscribingId: _idKeyboardListener);
    if (_keyboardUtils.canCallDispose()) {
      _keyboardUtils.dispose();
    }
    _streamController.close();
  }
}
