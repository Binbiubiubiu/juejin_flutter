import 'package:flutter/material.dart';
import 'package:juejin_app/pages/login_page.dart';
import 'package:juejin_app/pages/home_page.dart';
import 'package:juejin_app/pages/activity_page.dart';
import 'package:juejin_app/pages/explore_page.dart';
import 'package:juejin_app/pages/book_page.dart';
import 'package:juejin_app/pages/me_page.dart';

import 'package:juejin_app/prividers/custom_data_privider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CustomDataPrivider(
      theme: CustomThemeData(
        customListItemBg: Colors.white,
        customListItemActiveBg: Colors.grey[200],
      ),
      child: MaterialApp(
        title: '掘金',
        theme: ThemeData(
          primaryColor: Color(0xFF377DF6),
          dividerColor: Color(0xFFD8D8D8),
          backgroundColor: Color(0xFFF6F7F9),
        ),
        home: MyHomePage(),
//      initialRoute: '/',
        routes: {
          '/login': (ctx) => LoginPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      appBar: null,
      bottomNavigationBar: ButtonBar(
//        type: BottomNavigationBarType.fixed,
//        backgroundColor: Colors.white,
//        currentIndex: _currentIndex,
//        onTap: (int index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//        items: [
//          BottomNavigationBarItem(
//            title: Container(),
//            icon: Icon(Icons.add),
//            activeIcon: Icon(Icons.add),
//          ),
//          BottomNavigationBarItem(
//            title: Container(),
//            icon: Icon(Icons.add),
//            activeIcon: Icon(Icons.add),
//          ),
//          BottomNavigationBarItem(
//            title: Container(),
//            icon: Icon(Icons.add),
//            activeIcon: Icon(Icons.add),
//          ),
//          BottomNavigationBarItem(
//            title: Container(),
//            icon: Icon(Icons.add),
//            activeIcon: Icon(Icons.add),
//          ),
//        ],
        children:<Widget>[]: _items
            .map((item) => BottomNavigationBarItem(
                  title: ConstrainedBox(constraints: BoxConstraints()),
                  icon: Stack(
                    children: <Widget>[
                      Image.asset(
                        item['icon'],
                        width: 30.0,
                      ),
                      Positioned(
                        top:-10.0,
                        right: 0,
                        child: Text("12"),
                      ),
                    ],
                  ),
                  activeIcon:Stack(
                    children: <Widget>[
                      Image.asset(
                        item['activeIcon'],
                        width: 30.0,
                      )
                    ],
                  ) ,
                ))
            .toList(),
      ),
      body: _pages[_currentIndex],

//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
