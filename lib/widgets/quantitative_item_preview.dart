import 'package:flutter/material.dart';

import 'package:tfg_app/providers/equipment_provider.dart';

class QuantitativeItemPreview extends StatefulWidget {
  final QuantitativeModel _quantModel;

  QuantitativeItemPreview(this._quantModel);

  @override
  _QuantitativeItemPreviewState createState() =>
      _QuantitativeItemPreviewState();
}

class _QuantitativeItemPreviewState extends State<QuantitativeItemPreview> {
  var _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget._quantModel.inspectionName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Chip(
                  padding: const EdgeInsets.only(left: 10),
                  labelPadding: const EdgeInsets.only(right: 12, left: 5),
                  backgroundColor: Theme.of(context).primaryColorDark,
                  avatar: Icon(
                    Icons.network_check,
                    color: Colors.white,
                  ),
                  label: Text(
                    '[${widget._quantModel.minValue}, ${widget._quantModel.maxValue}] ${widget._quantModel.chosenUnit}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Column(
              children: <Widget>[
                SizedBox(height: 4),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    size: 30,
                  ),
                  onPressed: _toggleExpanded,
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Divider(
              height: 0,
              thickness: 2,
              color: Theme.of(context).primaryColorDark,
            ),
          if (_isExpanded)
            Container(
              height: MediaQuery.of(context).size.height * .20,
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${widget._quantModel.measureEquipment}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .10,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(.7),
                      ),
                      child: widget._quantModel.description == ''
                          ? Text('Nenhuma descrição adicionada.')
                          : Text(widget._quantModel.description),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
