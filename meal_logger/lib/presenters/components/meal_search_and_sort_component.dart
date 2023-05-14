import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/meal_bloc.dart';
import 'package:meal_logger/constants/dinner_hours_type.dart';

import '../../constants/meal_sort_target.dart';
import '../../constants/sort_order.dart';
import '../../dtos/meal_search_and_sort.dart';

class MealSearchAndSortComponent extends StatefulWidget {
  final MealSearchAndSort _mealSearchAndSort;

  const MealSearchAndSortComponent(this._mealSearchAndSort, {super.key});

  @override
  State<MealSearchAndSortComponent> createState() => _MealSearchAndSortComponentState();
  
}

class _MealSearchAndSortComponentState extends State<MealSearchAndSortComponent> {

  final _mealBloc = GetIt.I<MealBloc>();
  String _textForSearchMeal = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Row(
            children :[
              Expanded(
                child: TextFormField(
                  onChanged: (text) => _textForSearchMeal = text,
                  initialValue: widget._mealSearchAndSort.keywordsForTitle.join(' '),
                  decoration: const InputDecoration(hintText: '料理名を検索'))),
              IconButton(onPressed: () async {
                List<String> words = _textForSearchMeal.split(RegExp(r'\s+'));
                widget._mealSearchAndSort.keywordsForTitle.clear();
                widget._mealSearchAndSort.keywordsForTitle.addAll(words);
                await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
              }, icon: const Icon(Icons.search))
            ],
          ),
          const Spacer(),
          _SortSelectComponent(
            '追加順',
            () async {
              widget._mealSearchAndSort
                .setSortTarget(MealSortTarget.createDate, SortOrder.ascending);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            () async {
              widget._mealSearchAndSort
                .setSortTarget(MealSortTarget.createDate, SortOrder.descending);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            () async {
              widget._mealSearchAndSort
                .removeSortTarget(MealSortTarget.createDate);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            sortOrder: widget._mealSearchAndSort.sortTargetToOrder[MealSortTarget.createDate],
          ),
          const Spacer(),
          _SortSelectComponent(
            '料理日順',
            () async {
              widget._mealSearchAndSort
                .setSortTarget(MealSortTarget.cookedDate, SortOrder.ascending);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            () async {
              widget._mealSearchAndSort
                .setSortTarget(MealSortTarget.cookedDate, SortOrder.descending);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            () async {
              widget._mealSearchAndSort
                .removeSortTarget(MealSortTarget.cookedDate);
              await _mealBloc.getMeals(searchAndSort: widget._mealSearchAndSort);
            },
            sortOrder: widget._mealSearchAndSort.sortTargetToOrder[MealSortTarget.cookedDate],
          ),
          const Spacer()
        ],
      )
    );

  }
  
}

class _SortSelectComponent extends StatefulWidget {
  final String _title;
  final Function _onAscendingSelected;
  final Function _onDescendingSelected;
  final Function _onUnselected;

  bool _isAscendingSelected = false;
  bool _isDescendingSelected = false;

  _SortSelectComponent(
    this._title,
    this._onAscendingSelected,
    this._onDescendingSelected,
    this._onUnselected,
    {SortOrder? sortOrder})
  {
    if(sortOrder == null) {
      return;
    }

    if(sortOrder == SortOrder.ascending){
      _isAscendingSelected = true;
    }
    else {
      _isDescendingSelected = true;
    }
  }

  @override
  State<_SortSelectComponent> createState() => _SortSelectComponentState();
}

class _SortSelectComponentState extends State<_SortSelectComponent> {
  @override
  Widget build(BuildContext context) {
    return
      Row(
        children :[
          Expanded(
            flex: 5,
            child: Text(widget._title, style: const TextStyle(fontSize: 25))),
          const Spacer(),
          Ink(
            color: widget._isAscendingSelected ? Colors.blue : Colors.white,
            child:
              IconButton(
                onPressed: () {
                  setState(() {
                    widget._isAscendingSelected = !widget._isAscendingSelected;
                    widget._isDescendingSelected = false;
                    if(widget._isAscendingSelected) {
                      widget._onAscendingSelected();
                    }
                    else {
                      widget._onUnselected();
                    }
                  });
                },
                icon: const Icon(Icons.arrow_upward))
          ),
          const Spacer(),
          Ink(
            color: widget._isDescendingSelected ? Colors.blue : Colors.white,
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget._isDescendingSelected = !widget._isDescendingSelected;
                  widget._isAscendingSelected = false;
                  if(widget._isDescendingSelected) {
                    widget._onDescendingSelected();
                  }
                  else {
                    widget._onUnselected();
                  }
                });
              },
              icon: const Icon(Icons.arrow_downward)),
          ),
          const Spacer(),
        ],
      );
  }

}