import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meal_logger/blocs/menu_bloc.dart';
import 'package:meal_logger/dtos/menu.dart';
import 'package:meal_logger/presenters/screens/select_meal_for_menu_screen.dart';

import '../../constants/dinner_hours_type.dart';
import '../../states/loading_state.dart';

class TodayMenuScreen extends StatefulWidget {
  MenuBloc _menuBloc = GetIt.I<MenuBloc>();

  TodayMenuScreen({super.key});

  @override
  State<TodayMenuScreen> createState() => _TodayMenuScreenState();
}

class _TodayMenuScreenState extends State<TodayMenuScreen> {
  @override
  Widget build(BuildContext context) {
    widget._menuBloc.getTodayMenus();
    return Scaffold(
      appBar: AppBar(title: const Text('今日の献立')),
      body: StreamBuilder<LoadingState<List<Menu>>>(
        stream: widget._menuBloc.menuList,
        builder: (context, snapshot) {
          Widget component = const Text("");
          if(!snapshot.hasData){
            return component;
          }

          snapshot.data!.when(
            loading: (_) => {},
            completed: (content) {
              final dinnerHoursTypeToMenu = <DinnerHoursType, Menu>{};

              for(final menu in content) {
                dinnerHoursTypeToMenu.putIfAbsent(menu.dinnerHoursType, () => menu);
              }

              component = Column(
                children: <Widget>[
                  _MenuListExpansionTileComponent(
                    '朝食',
                    dinnerHoursTypeToMenu[DinnerHoursType.breakFast],
                    () => transitionToSelectMealForMenuScreen(DinnerHoursType.breakFast)
                  ),
                  _MenuListExpansionTileComponent(
                    '昼食',
                    dinnerHoursTypeToMenu[DinnerHoursType.lunch],
                    () => transitionToSelectMealForMenuScreen(DinnerHoursType.lunch)
                  ),
                  _MenuListExpansionTileComponent(
                    '夕食',
                    dinnerHoursTypeToMenu[DinnerHoursType.dinner],
                    () => transitionToSelectMealForMenuScreen(DinnerHoursType.dinner)
                  ),
                ]
              );
            },
            error: (exception) => {}
          );

          return component;
        }
      )
    );
  }

  void transitionToSelectMealForMenuScreen(DinnerHoursType type) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectMealForMenuScreen(type)));
  }
}

class _MenuListExpansionTileComponent extends StatelessWidget {
  final String _title;
  final Menu? _menu;
  final Function? _onTap;

  const _MenuListExpansionTileComponent(this._title, this._menu, this._onTap);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(_title),
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50), // fromHeight use double.infinity as width and 40 is the height
            ),
            onPressed: () {
              _onTap?.call();
            },
            child: const Text('料理を追加'),
          )
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _menu?.meals.length ?? 0,
          itemBuilder: (context, index) {
            final meal = _menu!.meals.elementAt(index);
            return ListTile(title: Text(meal.name));
          }
        )
      ]
    );
  }

}