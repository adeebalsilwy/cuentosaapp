import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../home.dart';
import '../db/prodb.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddStoryScreen extends StatefulWidget {
  @override
  _AddStoryScreenState createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _storyController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  List<Category> _categories = [];
  bool _isDarkMode = false;
  ThemeData? _themeData;
  int _selectedCategoryId = 1; // القيمة الافتراضية هي الفئة الأولى
  Future<void> _fetchCategories() async {
    _categories = await database_st().cateview();
    _categories = _categories.toSet().toList(); // إزالة العناصر المكررة
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _loadTheme();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();
    });
  }

  void _onAddButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      String _img = '';
      if (_image != null) {
        final ByteData imageData = await _image!
            .readAsBytes()
            .then((value) => ByteData.view(Uint8List.fromList(value).buffer));
        final String fileName =
            '${DateTime.now().toIso8601String()}.jpg'; // Set the file name to the current date and time
        final appDirectoryPath = await getExternalStorageDirectory();
        final appDirectory = Directory('${appDirectoryPath!.path}/asst');
        if (!appDirectory.existsSync()) {
          appDirectory.createSync();
        }
        final String imagePath =
            '${appDirectory.path}/$fileName'; // Use the appDirectory path to store the image file
        final File newImage = File(imagePath);
        if (newImage.existsSync()) {
          print('The image already exists in the external folder');
        } else {
          await newImage.create();
          await newImage.writeAsBytes(imageData.buffer.asUint8List());
          print('The image has been copied to the external folder');
        }
        _img = imagePath.replaceAll(
            '""', ''); // Set the _img variable to the image file name
      }

      String _title = _titleController.text;
      String _story = _storyController.text;
      int _categoryId = _selectedCategoryId;

      final story = Stors(
        id: null,
        title: _title,
        story: _story,
        img: _img,
        state: 1,
        categoryId: _categoryId,
      );
      await database_st().insertStors(story);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تمت اضافة روايتك الئ القصص بنجاح',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 2),
        ),
      );
      Permission.storage.request();
      _titleController.clear();
      _storyController.clear();
      _image = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _themeData ?? ThemeData.light(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.purple,
            title: Text('إضافة رواية'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('إضافة صورة'),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              final pickedFile = await picker.getImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                if (pickedFile != null) {
                                  _image = File(pickedFile.path);
                                }
                              });
                            },
                            child: _image == null
                                ? const CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    minRadius: 50,
                                    child: Icon(
                                      Icons.image,
                                      color: Colors.white,
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundImage: Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ).image,
                                    minRadius: 100,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        controller: _titleController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent, width: 2.0),
                          ),
                          labelText: 'العنوان',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال عنوان';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        cursorColor: Colors.blue,
                        controller: _storyController,
                        maxLines: null,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent, width: 2.0),
                          ),
                          labelText: 'القصة',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'يرجى إدخال قصة';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: DropdownButtonFormField<Category>(
                        value: _categories.isNotEmpty ? _categories[0] : null,
                        items: _categories.map((Category category) {
                          return DropdownMenuItem<Category>(
                            value: category,
                            child: Center(
                                child: Text(
                              category.name,
                            )),
                          );
                        }).toList(),
                        onChanged: (Category? value) {
                          setState(() {
                            _selectedCategoryId = value!.id;
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent, width: 2.0),
                          ),
                          labelText: 'الفئة',
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار فئة';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      child: ElevatedButton(
                        child: Text(
                          'إضافة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: _onAddButtonPressed,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => ahome()),
                          );
                        },
                        child: Text(
                          'رجوع',
                          style: TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
