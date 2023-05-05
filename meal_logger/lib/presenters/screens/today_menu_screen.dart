import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_logger/presenters/screens/select_meal_for_menu_screen.dart';

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('今日の献立')),
      body: Column(
        children: <Widget>[
          ExpansionTile(
            title: const Text('朝食'),
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    transitionToSelectMealForMenuScreen();
                  },
                  child: const Text('料理を追加'),
                )
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(title: Text('サンプル')),
                  ListTile(title: Text('サンプル2'))
                ],
              )
            ],),
          ExpansionTile(
            title: const Text('昼食'),
            children: [
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {

                    },
                    child: Text('料理を追加'),
                  )
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('夕食'),
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {

                  },
                  child: Text('料理を追加'),
                )
              ),
            ]
          ),
        ],
      )
    );
  }

  void transitionToSelectMealForMenuScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectMealForMenuScreen()));
  }
}