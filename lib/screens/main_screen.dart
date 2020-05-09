import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:supir/constants.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultBackgroundColour,
        title: Text(
          'Supir',
          overflow: TextOverflow.clip,
          maxLines: 1,
          style: kAppBarText.copyWith(color: kDefaultGoldenColour),
        ),
        actions: <Widget>[
          NavigationControls(_controller.future),
        ],
        centerTitle: true,
      ),
      drawer: Material(
        color: kDefaultBackgroundColour,
        child: Drawer(
          child: Material(
            color: kDefaultBackgroundColour,
            child: ListView(
              children: <Widget>[
              /*  UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: kDefaultBackgroundColour
                  ),
                  accountName: Text('Supir', style: kSideBarNormal.copyWith(fontSize: 25, fontWeight: FontWeight.normal, color: kDefaultGoldenColour)),
                  //accountEmail: Text('By Saif', style: kSideBarNormal),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT41KuC6cpqTR5hUyO_qjNn0Ph7w73DFc8agiNslBMfDrhiQbNA&usqp=CAU'),
                  ),
                ),*/
                ListTile(
                  title: Text(
                    'Home',
                    style: kSideBarHeading,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _webViewController.loadUrl('https://www.supir.app/');
                  },
                ),
                ksideBarDiv,
                ListTile(
                  title: Text(
                    'Join Now',
                    style: kSideBarHeading,
                  ),
                ),
                ListTile(
                    title: Text(
                      'How it Works',
                      style: kSideBarHeading,
                    )),
                ListTile(
                    title: Text(
                      'About Us',
                      style: kSideBarHeading,
                    )),

              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: WebView(
          initialUrl: 'https://www.supir.app/',
          onWebViewCreated: (WebViewController webViewController) {
            this._webViewController = webViewController;
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: true),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: false),
            ),
          ],
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
    goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}