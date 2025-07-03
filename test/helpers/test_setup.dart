import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'webview_mock.dart';

void setupTestEnvironment() {
  TestWidgetsFlutterBinding.ensureInitialized();
  WebViewPlatform.instance = MockWebViewPlatform();

  final originalDebugPrint = debugPrint;

  debugPrint = (String? message, {int? wrapWidth}) {};

  addTearDown(() {
    debugPrint = originalDebugPrint;
  });
}