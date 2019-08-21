import 'package:flutter/material.dart';
import 'package:juejin_app/providers/i18n_provider.dart';
import 'package:provider/provider.dart';

import 'generated/i18n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:juejin_app/pages/login_page.dart';
import 'package:juejin_app/pages/home_page.dart';
import 'package:juejin_app/pages/activity_page.dart';
import 'package:juejin_app/pages/explore_page.dart';
import 'package:juejin_app/pages/book_page.dart';
import 'package:juejin_app/pages/me_page.dart';

void main() {

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<I18nProvider>(
          builder: (context) => I18nProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isNight =Provider.of<I18nProvider>(context).isNight;

    return MaterialApp(
      title: "12",
      theme: isNight
          ? ThemeData.dark()
          : ThemeData.light(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback:
          S.delegate.resolution(fallback: const Locale('zh', 'CN')),
      supportedLocales: S.delegate.supportedLocales,
      home: LayoutBuilder(builder: (context, constraints) {
        return Localizations.override(
          context: context,
          locale: isNight?Locale('en', ''): Locale('zh', 'CN'),
          child: MyHomePage(),
        );
      }),
//      initialRoute: '/',
      routes: {
        '/login': (ctx) => LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List _items = [
    {
      "icon": "assets/tab/tab_home_normal.png",
      "activeIcon": "assets/tab/tab_home.png"
    },
    {
      "icon": "assets/tab/tab_activity.png",
      "activeIcon": "assets/tab/tab_activity_press.png"
    },
    {
      "icon": "assets/tab/tab_explore_normal.png",
      "activeIcon": "assets/tab/tab_explore.png"
    },
    {
      "icon": "assets/tab/tab_xiaoce_normal.png",
      "activeIcon": "assets/tab/tab_xiaoce.png"
    },
    {
      "icon": "assets/tab/tab_profile_normal.png",
      "activeIcon": "assets/tab/tab_profile.png"
    }
  ];

  final List<Widget> _pages = [
    HomePage(),
    ActivityPage(),
    ExplorePage(),
    BookPage(),
    MePage(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _items
            .map((item) => BottomNavigationBarItem(
                  title: Container(),
                  icon: Image.asset(
                    item['icon'],
                    width: 30.0,
                  ),
                  activeIcon: Image.asset(
                    item['activeIcon'],
                    width: 30.0,
                  ),
                ))
            .toList(),
      ),
      body: _pages[_currentIndex],
    );
  }
}
