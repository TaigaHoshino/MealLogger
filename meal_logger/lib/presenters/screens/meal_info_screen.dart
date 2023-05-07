import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/dtos/meal_ref_url.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/meal_bloc.dart';
import '../../dtos/meal.dart';

class MealInfoScreen extends StatefulWidget {
  final Meal _meal;
  File? _mealPicture;
  final MealBloc _mealBloc = GetIt.I<MealBloc>();

  MealInfoScreen(this._meal, {super.key});

  @override
  State<MealInfoScreen> createState() => _MealInfoScreenState();
}

class _MealInfoScreenState extends State<MealInfoScreen> {
  @override
  void initState() {
    super.initState();
    if(widget._meal.imageFullPath.isNotEmpty) {
      widget._mealPicture = File(widget._meal.imageFullPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('料理を新規追加'),
          leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);})),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(decoration: const BoxDecoration(color: Colors.black),
                      child: Stack(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 16/9,
                            child: Container(
                              width: double.infinity,
                              child: Center(
                                  child: widget._mealPicture != null ?
                                    Image.file(widget._mealPicture!) :
                                    const Text('No Image', textScaleFactor: 2.5, style: TextStyle(color: Colors.white))
                              ),
                            )
                          ),
                          IconButton(
                            onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                                if (result != null) {
                                  setState(() {
                                    widget._mealPicture = File(result.files.single.path.toString());
                                  });
                                } else {
                                  // User canceled the picker
                                }
                              },
                            icon: const Icon(Icons.add_photo_alternate, color: Colors.white))
                        ]
                      )
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('料理名：', textScaleFactor: 1.5),
                            TextFormField(initialValue: widget._meal.name, onChanged: (text) {widget._meal.name = text;})
                          ],
                        )
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: [
                            const Text('参考URL：', textScaleFactor: 1.5),
                            const Spacer(),
                            IconButton(onPressed: () {
                                setState(() {
                                  widget._meal.refUrls.add(MealRefUrl(url: ''));
                                });
                              }, icon: const Icon(Icons.add))]),
                          ListView.builder(
                            itemCount: widget._meal.refUrls.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
                                child: ListTile(
                                  title: TextFormField(
                                    initialValue: widget._meal.refUrls[index].url,
                                    onChanged: (text) {widget._meal.refUrls[index].url = text;}),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      final url = Uri.parse(
                                        widget._meal.refUrls[index].url,
                                      );
                                      if (await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      } else {
                                        // ignore: avoid_print
                                        print("Can't launch $url");
                                      }
                                    },
                                    icon: const Icon(Icons.search))
                                )
                              );
                            }
                          )
                        ],
                      )
                    )
                  ]
                )
              )
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () async {
                    await widget._mealBloc.saveMeal(widget._meal, newMealImage: widget._mealPicture);
                  },
                  child: const Text('保存する'),
                )
            )
          ],
        )
      )
    );
  }
}