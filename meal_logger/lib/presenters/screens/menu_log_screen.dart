import 'package:flutter/cupertino.dart';

class MenuLogScreen extends StatefulWidget {
  const MenuLogScreen({super.key});

  @override
  State<MenuLogScreen> createState() => _MenuLogScreenState();
}

class _MenuLogScreenState extends State<MenuLogScreen> {
  @override
  Widget build(BuildContext context) {
    return Text('献立履歴');
  }
}