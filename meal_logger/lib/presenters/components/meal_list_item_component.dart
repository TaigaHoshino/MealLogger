import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_logger/presenters/builders/popupmenu_button_builder.dart';

import '../../dtos/meal.dart';

class MealListItemComponent extends StatelessWidget {
  final Meal _meal;
  final Function? onTap;
  final PopupMenuButton? popupMenuButton;

  const MealListItemComponent(this._meal ,{super.key, this.onTap, this.popupMenuButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListTile(
          leading: AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black),
                child: Center(
                    child: _meal.imageFullPath.isNotEmpty ?
                    Image.file(File(_meal.imageFullPath)) :
                    const Text('No Image', style: TextStyle(color: Colors.white))
                ),
              )
          ),
          trailing: popupMenuButton,
          title: Text(_meal.name),
          onTap: () {
            onTap?.call();
          }
      )
    );
  }

}