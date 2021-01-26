import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/widgets/quantitative_item_preview.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import './add_quantitative_item_sheet.dart';
import './edit_quantitative_item_sheet.dart';

class QuantitativesScreen extends StatelessWidget {
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
                  'QUANTITATIVOS',
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
                    return AddItemBottomSheet();
                  },
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: ListOfQuantitativeParameters(),
          ),
        ],
      ),
    );
  }
}

// Lista de Parâmetros... O "body"...

class ListOfQuantitativeParameters extends StatelessWidget {
  Future<void> _resultDismiss(
      DismissDirection direction, BuildContext context, String itemId) async {
    try {
      final result = await showModalBottomSheet(
        context: context,
        builder: (ctx) => EditItemBottomSheet(
          Provider.of<QuantitativeListProvider>(context, listen: false)
              .getItemById(itemId),
        ),
      );
      if (result != null) {
        Provider.of<QuantitativeListProvider>(context, listen: false)
            .editQuantitative(result);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deleteItem =
        Provider.of<QuantitativeListProvider>(context, listen: false)
            .deleteQuantitative;
    final _listOfQuantitatives =
        Provider.of<QuantitativeListProvider>(context).quantitativeList;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .7,
      child: ListView.builder(
        itemCount: _listOfQuantitatives.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                return true;
              } else {
                await _resultDismiss(
                  direction,
                  context,
                  _listOfQuantitatives[index].id,
                );
                return false;
              }
            },
            key: Key(_listOfQuantitatives[index].id),
            child: QuantitativeItemPreview(_listOfQuantitatives[index]),
            onDismissed: (direction) {
              if (direction == DismissDirection.startToEnd) {
                _deleteItem(_listOfQuantitatives[index].id);
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
