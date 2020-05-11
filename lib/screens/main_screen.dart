import 'package:flutter/material.dart';
import 'package:supir/utilities/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'package:supir/utilities/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController _webViewController;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0){
        _webViewController.loadUrl('https://www.supir.app/');
      }
      if (index == 1){
        _webViewController.loadUrl('https://www.supir.app/gigs/');
      }
      if (index == 2){
        _webViewController.loadUrl('https://www.supir.app/tools/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(context),
      body: buildBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBody() {
    return Center(
      child: WebView(
        initialUrl: 'https://www.supir.app/',
        onWebViewCreated: (WebViewController webViewController) {
          this._webViewController = webViewController;
          _controller.complete(webViewController);
        },
      ),
    );
  }

  buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: kDefaultBackgroundColour,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: kHomeIcon,
          title: Text(
            'Home',
          ),
          activeIcon: kHomeIconActive,
        ),
        BottomNavigationBarItem(
          icon: kPersonIcon,
          title: Text(
            'Gigs',
          ),
          activeIcon: kPersonIconActive,
        ),
        BottomNavigationBarItem(
          icon: kSettingsIcon,
          title: Text(
            'Tools',
          ),
          activeIcon: kSettingsIconActive,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kDefaultGoldenColour,
      onTap: _onItemTapped,
      selectedIconTheme: IconThemeData(
        color: kDefaultGoldenColour,
      ),
      showUnselectedLabels: false,
      selectedFontSize: 16,
    );
  }

  buildAppBar() {
    return AppBar(
      backgroundColor: kDefaultBackgroundColour,
      title: Padding(
        padding: const EdgeInsets.only(left: 50, right: 51, top: 55, bottom: 51),
        child: Image.asset('images/supir_title.png'),
      ),
      actions: <Widget>[
        NavigationControls(_controller.future),
      ],
      centerTitle: true,
    );
  }

  buildDrawer(BuildContext context) {
    return Material(
      color: kDefaultBackgroundColour,
      child: Drawer(
        child: Material(
          color: kDefaultBackgroundColour,
          child: ListView(
            children: <Widget>[
              Container(
                height: 110,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 150, top: 20, bottom: 10),
                  child: Image.asset('images/supir_title.png'),
                ),
              ),
              ksideBarDiv,
              ListTile(
                title: Text(
                  'Home',
                  style: kSideBarTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _webViewController.loadUrl('https://www.supir.app/');
                },
              ),
              ListTile(
                title: Text(
                  'Join Now',
                  style: kSideBarTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _webViewController
                      .loadUrl('https://www.supir.app/register/');
                },
              ),
              ListTile(
                title: Text(
                  'How it Works',
                  style: kSideBarTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _webViewController.loadUrl('https://www.supir.app/how-it-works/');
                },
              ),
              ListTile(
                title: Text(
                  'About Us',
                  style: kSideBarTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _webViewController.loadUrl('https://www.supir.app/about-us/');
                },
              ),
              ListTile(
                title: Text(
                  'Login/My Account',
                  style: kSideBarTextStyle,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _webViewController.loadUrl('https://www.supir.app/member-login/');
                },
              ),
            ],
          ),
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
