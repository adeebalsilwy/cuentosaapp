import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuentosaapp/pages/fiva.dart';
import 'package:cuentosaapp/pages/homes.dart';
import 'package:cuentosaapp/pages/story.dart';

// Define the title variable here
String title = 'الرئيسية';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = false;
  ThemeData? _themeData;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    });
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = !_isDarkMode;
      _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
      prefs.setBool('isDarkMode', _isDarkMode);
    });
  }

  String dark = "تفعيل الوضع المعتم";
  String light = "تفعيل الوضع الفاتح";
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _themeData ?? ThemeData.light(),
      child: DefaultTabController(
        animationDuration: Duration(milliseconds: 300),
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              HomeInter(),
              stor(),
              fav(),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.purple,
            color: Colors.white,
            activeColor: Colors.white,
            style: TabStyle.reactCircle,
            elevation: 3,
            items: const [
              TabItem(
                icon: Icon(Icons.home, color: Colors.blueAccent, size: 30),
                activeIcon: Icon(Icons.home, color: Colors.blue, size: 35),
                title: 'الرئيسية',
              ),
              TabItem(
                icon: Icon(Icons.book, color: Colors.white, size: 30),
                activeIcon:
                    Icon(Icons.book, color: Colors.purpleAccent, size: 35),
                title: 'القصص',
              ),
              TabItem(
                icon: Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                activeIcon: Icon(Icons.favorite, color: Colors.red, size: 35),
                title: 'المفضلة',
              ),
            ],
            onTap: (int index) {},
          ),
          floatingActionButton: IconButton(
            tooltip: _isDarkMode ? light : dark,
            icon: _isDarkMode ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
            onPressed: () {
              _toggleTheme();
            },
          ),
        ),
      ),
    );
  }
}
