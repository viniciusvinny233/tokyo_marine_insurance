import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/custom_drawer_widget.dart';
import 'package:tokyo_marine_insurance/modules/home/presentation/widgets/custom_app_bar.dart';

class InsuranceWebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const InsuranceWebViewScreen({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<InsuranceWebViewScreen> createState() => _InsuranceWebViewScreenState();
}

class _InsuranceWebViewScreenState extends State<InsuranceWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;

        final canGoBack = await _controller.canGoBack();
        if (canGoBack) {
          _controller.goBack();
        } else {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF3B9C85),
          child: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            if (await _controller.canGoBack()) {
              await _controller.goBack();
            } else {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF3B9C85),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
