import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MealInfoScreen extends StatefulWidget {
  @override
  State<MealInfoScreen> createState() => _MealInfoScreenState();
}

class _MealInfoScreenState extends State<MealInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('料理を新規追加'), leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: () {Navigator.pop(context);})),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      child: Stack(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 16/9,
                            child: Container(
                              width: double.infinity,
                              child: const Center(child: Text('No Image', textScaleFactor: 2.5, style: TextStyle(color: Colors.grey))),
                            )
                          ),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.add_photo_alternate))
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
                            TextFormField(initialValue: 'サンプル',)
                          ],
                        )
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text('参考URL：', textScaleFactor: 1.5),
                          ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Container(
                                  decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                                  child: ListTile(
                                      title: TextFormField(initialValue: 'サンプル'),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            final url = Uri.parse(
                                              'https://www.youtube.com/',
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
                              ),
                            ],
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
                    minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {},
                  child: Text('保存する'),
                )
            )
          ],
        )
      )
    );
  }
}