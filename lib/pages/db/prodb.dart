import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class database_st {
  Future<Database> v() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'str.db'),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE storys(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,story TEXT,img TEXT,state INTEGER DEFAULT 1, categoryId INTEGER DEFAULT 1)");
        await db.execute(
            "CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,img TEXT)");
        // Insert some initial data

        await insertdatacate(db);
        await insertdatastr_adventure(db);

        // Add more initial data as needed
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertdatacate(Database db) async {
    await db.insert(
      'category',
      {
        'name': 'روايتي الشخصية',
        'img': 'asst/cate/personal.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'مغامرة',
        'img': 'asst/cate/adventure.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'اطفال',
        'img': 'asst/cate/kids.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'كوميديا',
        'img': 'asst/cate/comedy.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'رعب',
        'img': 'asst/cate/horror.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'خيال علمي',
        'img': 'asst/cate/scifi.jpg',
      },
    );
    await db.insert(
      'category',
      {
        'name': 'غير مصنف',
        'img': 'asst/cate/other.jpg',
      },
    );
  }

  Future<void> insertdatastr_adventure(Database db) async {
    await db.insert(
      'storys',
      {
        'title': 'قصة الارنب',
        'story':
            'كان يعيش في أحدى الغابات أرنب صغير، يحب المغامرة واستكشاف المجهول ومعرفة الأسرار، وكان الأرنب على علاقة جيدة بالسلحفاة والديك، وفي أحد الأيام كان الأرنب يتجول في الغابة فوجد السلحفاة تجلس على شاطىء النهر، فذهب اليها مبتسماً وقال لها: يا صديقتي لقد رأيت اليوم شيئاً عجيباً لم أشاهده من قبل فتعجبت السلحفاة قائله: وماذا رأيت؟ فأشار الأرنب الى أحد الأشجار، وقال لها: هناك أسفل تلك الشجرة، يوجد حجر وتحته نفق مظلم ليس له نهاية، فخفت ورجعت فما رأيك أن تأتي معي داخل هذا النفق لنكتشف سوياً ما يوجد بداخله؟\nوافقت السلحفاة على الذهاب مع الأرنب، وعندما كانوا متجهين نحو النفق مروا على الديك وعرضوا عليه الأمر فوافق أن يذهب معهم، وعندما وصل الثلاثة إلى النفق تقدم الأرنب وسار خلفه الديك والسلحفاة كانت في الخلف، ومشوا داخل سرداب طويل حتى شعروا بالضيق والاضطراب وفجأة انحدر بهم السرداب إلى الأسفل فسقطوا جميعاً فوق بعضهم\nقاموا من الأرض فوجدوا عالم غريب داخل ساحة ممتلئة بالعشب وخالية تماماً من الناس أو الطيور أو الحيوانات، فجلس الثلاثة أصدقاء تحت أحد الأشجارقالت السلحفاة: يبدو أننا وصلنا إلى عالم مهجور بالفعل لم يكتشفه أحد قبلنا.قال الأرنب بعد لحظات كان صامتاً فيها: ما رأيكم أن نبقى هنا\nقالت السلحفاة: أوافقك الرأي وسوف أحضر أسرتي لنعيش هنا سوياً\nقال الديك: وأنا أيضا سأحضر أسرتي معي وأعيش معكم شعر الثلاثة بالسعادة تجاه العالم المثالي الجديد الذي سيعيشون به وهو العالم الذي يخلو من القتل والاعتداء والتلوث.\nاتفق ثلاثتهم على وضع قائمة بالطيور و الحيوانات التي يرغبون في احضارها للعيش معهم فقرروا أن يبقى الديك، ويصعد الارنب والسلحفاة إلى الأعلى لإحضار الحيوانات من الغابة والتي كانت تشكو في ذلك الوقت من قلة الطعام، فوافق بعضهم على النزول والتجربة، بينما خاف الآخرين من تغيير حياتهم فرفضوا النزول.تمنت مجموعة أخرى النزول والعيش في ذلك العالم الجديد المليء بالسلام والهدوء والغذاء الوفير، ولكن كبر سنها وضخامة حجمها منعها من تحقيق هذه الأمنية، فكر الأرنب والسلحفاة في حل لهذه الأزمة لمساعدة تلك الحيوانات في النزول معهم، فلم يجدوا سوى فكرة احضار الطعام من هذا العالم الجديد كل يوم والصعود به إلى تلك الحيوانات الكثيرة.\nقالت السلحفاة للأرنب: يا صديقي إن أغلب أفراد اسرتي وعشيرتي من الضعفاء كبار السن الذين لا يمكنهم المشي تلك المسافات الطويلة التي مشيناها، لذلك قررت أن أحمل بعض الغذاء الجيد لهم كل يوم.\nقال الأرنب: لا تفعلي فهذا الأمر شاق عليكn\قالت السلحفاة: ولكن لن استريح وأنا أعيش في رغد من الطعام والشراب وأهلي جائعين فالمحظوظين يجب ألا ينسوا غيرهم ولا أحد يضمن تقلب الأيام قد أصبح في يوماً ما مثلهم فأتمنى وقتها أن يساعدني أحد\n',
        'img': 'asst/str/1_1.png',
        'categoryId': 2,
      },
    );

    await db.insert(
      'storys',
      {
        'title': 'مغامرات سمكة',
        'story':
            '– كانت تعيش سمكة كبيرة مع ابنتها الصغيرة، في بحر أزرق هادئ، وذات يوم شاهدت السمكتان ثلاث سفن تبحر في البعيد فقالت السمكة الكبيرة لابنتها : إنهم البشر فصرخت السمكة الصغيرة منفعلة: لطالما حلمت أن أعرف إلى أين هم يذهبون ودائماً أتمنى أن أقوم برحلة معهم لأتعرف على بحار ومحيطات أخرى. فأجابتها أمها: سأدعك تذهبين في يوم ما ولكن ليس الآن يا بنتي، فأنت ما زلت صغيرة على ذلك ردت عليها: أنا لست صغيرة يا أمي فقالت الأم :أقصد عندما تكبرين أكثر يا ابنتي ،حينها ستكتشفين فيه ما تشائين فأجابت الصغيرة متذمرة: كيف يكون ذلك وأنا لم أجد من يساعدني حتى الآن فسمع السرطان حديث السمكة الصغيرة مع أمها، فسألها: ما بالك تتذمرين؟ أجابت الصغيرة : هل اللهو في رأيك غلطة؟ فأنا لا أعرف ولكني أرغب في القيام برحلة استكشافية وأمي تقول أن انتظر حتى أكبر. جاء طائر النورس وشاركهم في الحديث قائلاً: أمك على حق. السمكة الصغيرة: أنت أيضاً أيها النورس تقف أمام رغبتي ولا تريد مساعدتي طائر النورس: خوفاً عليك فقد تتوهين أو تضلين طريقك وتضيعي السمكة الصغيرة: لن أضل طريقي ولن أضيع فأنا كبيرة بما يكفي لأقوم بالمغامرة التي أريد؟ أصرت السمكة على رأيها ودون أن تعلم أحد خرجت خارج الخليج باتجاه لا تعلمه، فلمحت واحدة من سفن البحر المبحرة، فسبحت مسرعة لتصل إليها وصاحت انتظريني أيتها السفينة/nولكن لم يسمعها أحد من البحارة، وفي لحظات اختفت السفينة وراء الأفق، فشعرت السمكة الصغيرة بالخيبة والتعب، فقررت أن تعود إلى أمها، لكنها وجدت نفسها ضائعة، فكل ما حولها كان غريب./n– أخذت السمكة الصغيرة تسبح وهي قلقة حتى صادفت في طريقها أخطبوط فسألته: هل تعرف أين الطريق إلى بيتي؟‏/nفتجاهل الأخطبوط السؤال فأسرعت نحو بعض المحار النائم، وقالت لهم أنها قد أضاعت الطريق إلى بيتها وسألتهم :هل يمكن أن تساعدوني لأجده؟ وأيضاً لم يرد عليها أحد، فلجأت السمكة بعد ذلك إلى قنديل بحر وتوسلت إليه: ليتك تدلني إلى طريق يوصلني إلى بيتي؟ ولم يرد عليها/n– لم تجد من يساعدها للوصول إلى أمها فحزنت السمكة وظلت تتسائل ماذا أفعل الآن، وما هو مصيري؟ لقد كان الكل على حق فأنا صغيرة على القيام بمغامرة بمفردي.‏/n– لاحظت السمكة الصغيرة أن الأسماك التي حولها تسبح بسرعة مذهلة، فوجدت ظل كبير يسقط عليها، وشعرت بسكون المياه وبرودتها، وعرفت أن القادم هو سمكة القرش/n–  حاولت سمكة القرش أن يمسك بالسمكة الصغيرة ويبتلعها، فأدخلت نفسها بين الصخور حتى يصعب على سمكة القرش أن تدخل لها، وحينما شعرت بزوال الخطر خرجت من مكانها، وسبحت بكل قوتها بعيداً ودون أن تلتفت وراءها، وفجأة وجدت السمكة الصغيرة نفسها بين أهلها وأصدقائها فهي لا تعرف كيف وصلت، لكنها قررت أنها لن تعود للمغامرة من جديد وهي في هذه السن الصغيرة/n',
        'img': 'asst/str/1_2.png',
        'categoryId': 2,
      },
    );
  }

  ////////////////////////////////////////////
  Future<void> insertStors(Stors stors) async {
    final Database db = await v();
    await db.insert(
      'storys',
      stors.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCategory(Category category) async {
    final Database db = await v();
    await db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  ///////////////////////////////////////
  Future<void> updateCategory(Category category) async {
    final Database db = await v();
    await db.update(
      'category',
      category.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
    );
  }

  Future<void> updateStors(Stors stors) async {
    final Database db = await v();
    await db.update(
      'storys',
      stors.toMap(),
      where: "id = ?",
      whereArgs: [stors.id],
    );
  }

  Future<void> updateState(Stors story) async {
    final db = await v();
    await db.update(
      'storys',
      {
        'state': story.state, // update the state value with the new value
      },
      where: 'id = ?',
      whereArgs: [story.id],
    );
  }

  ///////////////////////////////////////////
  Future<void> deleteStors(int id) async {
    final Database db = await v();
    await db.delete(
      'storys',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteCategory(int id) async {
    final Database db = await v();
    await db.delete(
      'category',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //////////////////////////////////////////
  Future<List<Category>> cateview() async {
    final Database db = await v();
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
        img: maps[i]['img'],
      );
    });
  }

  Future<List<Stors>> storview() async {
    final Database db = await v();
    final List<Map<String, dynamic>> maps = await db.query('storys');
    return List.generate(maps.length, (i) {
      return Stors(
        id: maps[i]['id'],
        title: maps[i]['title'],
        story: maps[i]['story'],
        img: maps[i]['img'],
        state: maps[i]['state'],
        categoryId: maps[i]['categoryId'],
      );
    });
  }

  //////////////////////////////////////
  Future<List<Stors>> getStoriesByCategory(int categoryId) async {
    final Database db = await v();
    final List<Map<String, dynamic>> maps = await db.query(
      'storys',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) {
      return Stors(
        id: maps[i]['id'],
        title: maps[i]['title'],
        story: maps[i]['story'],
        img: maps[i]['img'],
        state: maps[i]['state'],
        categoryId: maps[i]['categoryId'],
      );
    });
  }

  Future<List<Stors>> searchStories(String query) async {
    final Database db = await v();
    final List<Map<String, dynamic>> maps = await db.query(
      'storys',
      where: "title LIKE ?",
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) {
      return Stors(
        id: maps[i]['id'],
        title: maps[i]['title'],
        story: maps[i]['story'],
        img: maps[i]['img'],
        state: maps[i]['state'],
        categoryId: maps[i]['categoryId'],
      );
    });
  }

  Future<String> getCategoryName(int storyId) async {
    final Database db = await v();
    List<Map> maps = await db.query(
      'storys',
      where: 'id = ?',
      whereArgs: [storyId],
    );
    int categoryId = maps[0]['categoryId'];
    List<Map> categoryMaps = await db.query(
      'category',
      where: 'id = ?',
      whereArgs: [categoryId],
    );
    return categoryMaps[0]['name'];
  }
}

/////////////////////////////////////////////////////
class Category {
  final int id;
  final String name;
  final String img;

  Category({
    required this.id,
    required this.name,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'img': img};
  }

  @override
  String toString() {
    return 'category{id: $id, name: $name, img: $img}';
  }
}

class Stors {
  int? id;
  final String title;
  final String story;
  final String img;
  int state = 0;
  int categoryId;

  Stors({
    this.id,
    required this.title,
    required this.story,
    required this.img,
    required this.state,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'story': story,
      'img': img,
      'state': state,
      'categoryId': categoryId,
    };
  }

  @override
  String toString() {
    return 'storys{id: $id, title: $title, story: $story, img: $img, state: $state, categoryId: $categoryId}';
  }
}
