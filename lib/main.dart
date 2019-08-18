import 'package:flutter/material.dart';
import 'package:juejin_app/pages/login_page.dart';
import 'package:juejin_app/pages/home_page.dart';
import 'package:juejin_app/pages/activity_page.dart';
import 'package:juejin_app/pages/explore_page.dart';
import 'package:juejin_app/pages/book_page.dart';
import 'package:juejin_app/pages/me_page.dart';

import 'package:timeago/timeago.dart' as timeago;

void main(){
  timeago.setLocaleMessages('en', timeago.ZhCnMessages());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '掘金',
      theme: ThemeData(
        primaryColor: Color(0xFF377DF6),
        accentColor: Color(0xFF377DF6),
        dividerColor: Color(0xFFD8D8D8),
        backgroundColor: Color(0xFFF6F7F9),
      ),
      home: MyHomePage(),
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

  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
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
