import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/widgets/qualitative_item_preview.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import './add_qualitative_item_sheet.dart';
import './edit_qualitative_item_sheet.dart';

class QualitativesScreen extends StatelessWidget {
  static const routeName = '/quantitatives-screen';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'QUALITATIVOS',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Deslize para a DIREITA para excluir um item...',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  'Ou para a ESQUERDA para editá-lo.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            child: FloatingActionButton(
              backgroundColor:
                  Theme.of(context).appBarTheme.color.withOpacity(.9),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return AddQualitativeItemSheet();
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: ListOfQualitativeParameters(),
          ),
        ],
      ),
    );
  }
}

class ListOfQualitativeParameters extends StatelessWidget {
  Future<void> _resultDismiss(
      DismissDirection direction, BuildContext context, String itemId) async {
    try {
      final result = await showModalBottomSheet(
        context: context,
        builder: (ctx) => EditQualitativeItemSheet(
            Provider.of<QualitativeListProvider>(context, listen: false)
                .getQualitativeById(itemId)),
      );
      if (result != null) {
        Provider.of<QualitativeListProvider>(context, listen: false)
            .updateQualitative(result);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deleteItem =
        Provider.of<QualitativeListProvider>(context, listen: false)
            .deleteQualitativeByItemId;
    final _listOfQualitatives =
        Provider.of<QualitativeListProvider>(context).listOfQualitatives;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: ListView.builder(
        itemCount: _listOfQualitatives.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return true;
              } else {
                await _resultDismiss(
                  direction,
                  context,
                  _listOfQualitatives[index].id,
                );
                return false;
              }
            },
            key: Key(_listOfQualitatives[index].id),
            child: QualitativeItemPreview(_listOfQualitatives[index]),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                _deleteItem(_listOfQualitatives[index].id);
              }
            },
            background: Card(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 15),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
            ),
            secondaryBackground: Card(
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
