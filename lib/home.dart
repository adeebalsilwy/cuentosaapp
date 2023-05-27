import 'package:cuentosaapp/pages/botom.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/services.dart';
import 'pages/screen/add_stor.dart';

class ahome extends StatefulWidget {
  const ahome({Key? key}) : super(key: key);

  @override
  State<ahome> createState() => _ahomeState();
}

class _ahomeState extends State<ahome> {
  Future<void> showMessage(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'رسالة',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'مرحبا يمكنك اضافة روياتك في التطبيق من خلال الزر + في اعلئ القائمة كما يمكنك مشاركة الرويات الي من تحب اضغط مطولا علئ اي قصة لحذفها استمتع  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'حسنا',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.purple,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(vertical: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showMessageAbout(BuildContext context) {
    const String name = "Hossein Ahmed Qasspa";
    const String email = "hq84068@gmail.com";
    const String facebookUrl = 'https://www.facebook.com/hossein.qasspa';
    const String telegramUrl = 'https://t.me/O_2_y';
    const String whatsappUrl = "https://wa.me/+967776764455";

    Future<void> copyToClipboard(String url, String message) async {
      await Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.greenAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,
          backgroundColor: Colors.white,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "BY $name",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Email: $email"),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.email, color: Colors.orange),
                      onPressed: () async => await copyToClipboard(
                        email,
                        'تم نسخ الايميل',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.facebook, color: Colors.blueAccent),
                      onPressed: () async => await copyToClipboard(
                        facebookUrl,
                        'تم نسخ رابط الفيسبوك',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.telegram, color: Colors.blue),
                      onPressed: () async => await copyToClipboard(
                        telegramUrl,
                        'تم نسخ رابط التيليجرام',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.perm_phone_msg, color: Colors.green),
                      onPressed: () async => await copyToClipboard(
                        whatsappUrl,
                        'تم نسخ رابط الوتس اب ',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String show = " من هنا اضف روايتك";
  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
      appBar: BackdropAppBar(
        title: const Text('روايتي'),
        actions: <Widget>[
          IconButton(
            tooltip: show,
            icon: Icon(Icons.add_circle_outline_outlined, color: Colors.green),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddStoryScreen()));
            },
          ),
        ],
        centerTitle: true,
      ),
      backLayer: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage: Image.asset(
                  "asst/app/app.png",
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ).image,
                minRadius: 120,
              ),
            ),
          ),
          Center(
            child: Text(
              'مرحبا بكم في تطبيقنا المتواضع نرجو ان ينال اعجابكم ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.help, color: Colors.white),
            title: Text(
              'المساعدة',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              showMessage(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.app_shortcut, color: Colors.white),
            title: Text('عن التطبيق',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
            onTap: () async {
              setState(() {
                showMessageAbout(context);
              });
            },
          ),
        ],
      ),
      frontLayer: MyHomePage(),
    );
  }
}
