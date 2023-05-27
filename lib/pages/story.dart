import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import '../pages/screen/viewstory.dart';
import '../pages/db/prodb.dart';

class stor extends StatefulWidget {
  const stor({Key? key}) : super(key: key);

  @override
  State<stor> createState() => _storState();
}

class _storState extends State<stor> {
  bool isInit = true;
  String cate = "";
  @override
  void initState() {
    super.initState();
    fetchStors();
  }

  Future<void> shareStory(Stors story) async {
    final String text = story.title + '\n\n' + story.story;

    await Share.share(text);
  }

  Future<void> fetchStors() async {
    await database_st().v();
    setState(() {
      isInit = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: StoryList(),
    );
  }
}

class StoryList extends StatefulWidget {
  const StoryList({Key? key}) : super(key: key);

  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  final database_st _database = database_st();
  List<Stors> updatedStories = [];
  List<Stors> filteredStories = [];
  String cate = "";

  @override
  void initState() {
    super.initState();
    filteredStories = [];
    getStories();
  }

  Future<void> getStories() async {
    final stories = await _database.storview();
    setState(() {
      filteredStories = stories;
    });

  }

  Future<void> refreshStories() async {
    final stories = await _database.storview();
    setState(() {
      filteredStories = stories;
    });
  }

  Future<void> shareStory(Stors story) async {
    final String text = story.title + '\n\n' + story.story;

    await Share.share(text);
  }

  void updateStoryState(Stors story) async {
    setState(() {
      story.state = story.state == 1 ? 0 : 1;
      updatedStories.add(story);
    });

  }

  void performSearch(String query) async {
    final List<Stors> results = await _database.searchStories(query);
    setState(() {
      filteredStories = results;
    });

  }
  @override
  void dispose() {
    super.dispose();
    for (final story in updatedStories) {
      database_st().updateState(story);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (query) {
                  performSearch(query);
                },
                decoration: InputDecoration(
                  hintText: 'ابحث في القصص...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child:filteredStories.isEmpty ?
              Center( child: Text('عذرا لم يتم العثور علئ اي قصة !',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,fontSize: 20,
              )),
              )
              :RefreshIndicator(
                onRefresh: refreshStories,
                child: ListView.builder(
                  padding: const EdgeInsets.all(13.0),
                  itemCount: filteredStories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final story = filteredStories[index];
                    final isFavorite = story.state == 0;
                    return buildGestureDetector(context, story, isFavorite);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  GestureDetector buildGestureDetector(BuildContext context, Stors story, bool isFavorite) {
    return GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),

                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.purple,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'تأكيد الحذف',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'هل أنت متأكد أنك تريد حذف هذه القصة؟',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: Text(
                                        'إلغاء',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 32.0),
                                    TextButton(
                                      onPressed: () async {
                                        final file = File(story.img);
                                        if (await file.exists()) {
                                          await file.delete();
                                        }
                                        await _database.deleteStors(story.id!);
                                        Navigator.pop(context, 'OK');

                                        refreshStories();

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'تم حذف القصة بنجاح',
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor: Colors.redAccent,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'حذف',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewStory(
                      data: story,
                    ),
                  ),
                );
              },
              child: Card(
                margin:
                const EdgeInsets.symmetric(vertical: 10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5.0,
                child: ListTile(

                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  leading: Hero(
                    tag: 'image_${story.id}',
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: (() {

                            final file = File(story.img);
                            if (file.existsSync()) {
                              return FileImage(file);
                            }
                             if (story.img =="") {
                               return AssetImage("asst/app/p4.jpg");

                            }else{
                               return AssetImage(story.img);
                            }
                      })()as ImageProvider<Object>?,
                    ),
                  ),

                  title: Text(
                    story.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: FutureBuilder(
                    future:
                    _database.getCategoryName(story.id!),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Text('');
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        );
                      }
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await shareStory(story);
                        },
                        icon: Icon(
                          Icons.share,
                          size: 30,
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      IconButton(
                        onPressed: () async {
                         updateStoryState(story);

                          final message = isFavorite
                              ? 'تمت إزالة القصة من المفضلة.'
                              : 'تمت إضافة القصة إلى المفضلة.';
                          final icon = isFavorite
                              ? Icons.favorite_border
                              : Icons.favorite;
                          final color = isFavorite
                              ? Colors.redAccent
                              : Colors.red;

                          await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 200,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      icon,
                                      size: 50,
                                      color: color,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      message,
                                      style: const TextStyle(
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Colors.redAccent,
                          size: 30,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}