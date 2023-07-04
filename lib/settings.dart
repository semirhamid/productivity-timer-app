import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Settings());
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;
  late SharedPreferences prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController(); // controllerun initialize aregnew
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 24);
    return Container(
        child: GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: <Widget>[
        Text("Work", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
        TextField(
            style: textStyle,
            controller: txtWork,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtShort,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
        Text(
          "Long",
          style: textStyle,
        ),
        Text(""),
        Text(""),
        SettingsButton(Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            controller: txtLong,
            keyboardType: TextInputType.number),
        SettingsButton(Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
      ],
      padding: const EdgeInsets.all(20.0),
    ));
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME);
    if (workTime == null) {
      await prefs.setInt(WORKTIME, int.parse('30'));
      workTime = 30;
    }
    shortBreak = prefs.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs.setInt(SHORTBREAK, int.parse('5'));
      shortBreak = 5;
    }
    longBreak = prefs.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs.setInt(LONGBREAK, int.parse('20'));
      longBreak = 20;
    }
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          workTime = prefs.getInt(WORKTIME)!;
          workTime = workTime! + value;
          if (workTime! >= 1 && workTime! <= 180) {
            prefs.setInt(WORKTIME, workTime!);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          shortBreak = prefs.getInt(SHORTBREAK);
          shortBreak = shortBreak! + value;
          if (shortBreak! >= 1 && shortBreak! <= 120) {
            prefs.setInt(SHORTBREAK, shortBreak!);
            setState(() {
              txtShort.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          longBreak = prefs.getInt(LONGBREAK);
          longBreak = longBreak! + value;
          if (longBreak! >= 1 && longBreak! <= 180) {
            prefs.setInt(LONGBREAK, longBreak!);
            setState(() {
              txtLong.text = longBreak.toString();
            });
          }
        }
        break;
    }
  }
}
