import 'package:flutter/cupertino.dart';

class TodayMenuScreen extends StatefulWidget {
  const TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('今日の献立');
  }
}