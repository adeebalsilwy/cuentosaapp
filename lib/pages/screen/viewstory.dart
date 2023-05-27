import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share/share.dart';
import '../db/prodb.dart';

class ViewStory extends StatefulWidget {
  const ViewStory({Key? key, required this.data}) : super(key: key);

  final Stors data;

  @override
  _ViewStoryState createState() => _ViewStoryState();
}

class _ViewStoryState extends State<ViewStory> {
  double _fontSize = 18.0;
  final _scrollController = ScrollController();
  bool _isVisible = true;
  bool _isDarkMode = false;
  ThemeData? _themeData;
  @override
  void initState() {
    super.initState();
    _loadTheme();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      } else {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    });
  }

  void disopose() {
    _scrollController.dispose();
    super.dispose();
    _loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _themeData ?? ThemeData.light(),
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.purple,
              pinned: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'image_${widget.data.id}',
                  child: (() {
                    final file = File(widget.data.img.toString());
                    if (file.existsSync()) {
                      return Image.file(
                        file,
                        fit: BoxFit.cover,
                      );
                    } else {
                      if (widget.data.img.toString() == "") {
                        return Image.asset('asst/app/p4.jpg',
                            fit: BoxFit.cover);
                      } else {
                        return Image.asset(widget.data.img.toString(),
                            fit: BoxFit.cover);
                      }
                    }
                  })(),
                ),
                title: Text(
                  widget.data.title.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.data.story.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _fontSize,
                        shadows: [
                          Shadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(size: 22.0),
            backgroundColor: Colors.blue,
            activeBackgroundColor: Colors.red,
            visible: true,
            curve: Curves.bounceInOut,
            children: [
              SpeedDialChild(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                backgroundColor: Colors.purple,
                onTap: () {
                  Share.share(widget.data.title.toString() +
                      '\n\n' +
                      widget.data.story.toString());
                },
                label: 'مشاركة',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                labelBackgroundColor: Colors.blue,
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.redAccent,
                onTap: () {
                  setState(() {
                    _fontSize++;
                  });
                },
                label: 'تكبير الخط',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                labelBackgroundColor: Colors.redAccent,
              ),
              SpeedDialChild(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                backgroundColor: Colors.greenAccent,
                onTap: () {
                  setState(() {
                    _fontSize--;
                  });
                },
                label: 'تصغير الخط',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                labelBackgroundColor: Colors.greenAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
