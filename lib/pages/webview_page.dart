import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({
    Key key,
    this.title,
    this.url,
  })  : assert(title != null),
        assert(url != null),
        super(key: key);

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      url: url,
//      withZoom: true,
//      withLocalStorage: true,
//      hidden: true,
    );
  }
}
