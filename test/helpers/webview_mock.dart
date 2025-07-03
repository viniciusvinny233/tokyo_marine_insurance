import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

class MockWebViewPlatform extends WebViewPlatform {
  @override
  PlatformWebViewController createPlatformWebViewController(
    PlatformWebViewControllerCreationParams params,
  ) {
    return MockPlatformWebViewController(params);
  }

  @override
  PlatformWebViewWidget createPlatformWebViewWidget(
    PlatformWebViewWidgetCreationParams params,
  ) {
    return MockPlatformWebViewWidget(params);
  }
  
  @override
  PlatformWebViewCookieManager createPlatformCookieManager(
    PlatformWebViewCookieManagerCreationParams params,
  ) {
    return MockPlatformWebViewCookieManager(params);
  }
  
  @override
  PlatformNavigationDelegate createPlatformNavigationDelegate(
    PlatformNavigationDelegateCreationParams params,
  ) {
    return MockPlatformNavigationDelegate(params);
  }
}

class MockPlatformWebViewController extends PlatformWebViewController {
  MockPlatformWebViewController(super.params)
      : super.implementation();
  
  @override
  Future<void> loadRequest(LoadRequestParams params) async {}
  
  @override
  Future<String?> currentUrl() async => 'https://example.com';
  
  @override
  Future<void> setJavaScriptMode(JavaScriptMode javaScriptMode) async {}
  
  @override
  Future<void> setBackgroundColor(Color color) async {}
  
  @override
  Future<void> setPlatformNavigationDelegate(
    PlatformNavigationDelegate handler,
  ) async {}
}

class MockPlatformWebViewWidget extends PlatformWebViewWidget {
  MockPlatformWebViewWidget(super.params)
      : super.implementation();
  
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Mock WebView'));
  }
}

class MockPlatformWebViewCookieManager extends PlatformWebViewCookieManager {
  MockPlatformWebViewCookieManager(super.params)
      : super.implementation();
  
  @override
  Future<bool> clearCookies() async => true;
}

class MockPlatformNavigationDelegate extends PlatformNavigationDelegate {
  MockPlatformNavigationDelegate(super.params)
      : super.implementation();
  
  @override
  Future<void> setOnNavigationRequest(NavigationRequestCallback onNavigationRequest) async {}
  
  @override
  Future<void> setOnPageStarted(void Function(String url) onPageStarted) async {}
  
  @override
  Future<void> setOnPageFinished(void Function(String url) onPageFinished) async {}
  
  @override
  Future<void> setOnWebResourceError(void Function(WebResourceError error) onWebResourceError) async {}
  
  @override
  Future<void> setOnUrlChange(void Function(UrlChange change) onUrlChange) async {}
}