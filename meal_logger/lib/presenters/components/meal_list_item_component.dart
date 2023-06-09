import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_logger/presenters/builders/popupmenu_button_builder.dart';

import '../../dtos/meal.dart';

class MealListItemComponent extends StatefulWidget {
  final Meal _meal;
  final Function? _onTap;
  final Widget? _trailingWidget;
  final Color? _selectedColor;
  bool _isSelected = false;

  MealListItemComponent(
    this._meal,
    {
      super.key,
      Function? onTap,
      Widget? trailingWidget,
      Color? selectedColor,
      bool isSelected = false
    }) : _onTap = onTap, _trailingWidget = trailingWidget, _selectedColor = selectedColor, _isSelected = isSelected;

  @override
  State<StatefulWidget> createState() => _MealListItemComponentState();

}

class _MealListItemComponentState extends State<MealListItemComponent> {

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
                  child: widget._meal.imageFullPath.isNotEmpty ?
                  Image.file(File(widget._meal.imageFullPath)) :
                  const Text('No Image', style: TextStyle(color: Colors.white))
              ),
            )
          ),
          trailing: widget._trailingWidget,
          title: Text(widget._meal.name),
          subtitle: widget._meal.elapsedDateFromLastCookedDate != -1 ?
            Text('${widget._meal.elapsedDateFromLastCookedDate}日前') :
            const Text('料理記録なし'),
          tileColor: widget._isSelected ? widget._selectedColor : null,
          onTap: () {
            widget._onTap?.call();
            setState(() {
              widget._isSelected = !widget._isSelected;
            });
          }
      )
    );
  }

}