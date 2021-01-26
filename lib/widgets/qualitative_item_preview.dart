import 'package:flutter/material.dart';

import 'package:tfg_app/providers/equipment_provider.dart';

class QualitativeItemPreview extends StatefulWidget {
  final QualitativeModel _qualiModel;

  QualitativeItemPreview(this._qualiModel);

  @override
  _QualitativeItemPreviewState createState() => _QualitativeItemPreviewState();
}

class _QualitativeItemPreviewState extends State<QualitativeItemPreview> {
  var _isExpanded = false;
  var _numOfAnswers;

  @override
  void initState() {
    _numOfAnswers = numberOfAnswers(widget._qualiModel.answers);
    super.initState();
  }

  int numberOfAnswers(List<String> listOfAnswers) {
    final realAnswers = listOfAnswers.where((answer) => answer != '').toList();
    final numOfAnswers = realAnswers.length;
    return numOfAnswers;
  }

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
                  widget._qualiModel.inspectionName,
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
                    Icons.list,
                    color: Colors.white,
                  ),
                  label: Text(
                    '$_numOfAnswers respostas adicionadas',
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
              height: MediaQuery.of(context).size.height * .30,
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .10,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(.7),
                      ),
                      child: Text(widget._qualiModel.description),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Respostas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .10,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white.withOpacity(.7),
                      ),
                      child: ListView(
                        children: <Widget>[
                          Text('1 - ${widget._qualiModel.answers[0]}'),
                          Text('2 - ${widget._qualiModel.answers[1]}'),
                          if (widget._qualiModel.answers[2] != '')
                            Text('3 - ${widget._qualiModel.answers[2]}'),
                          if (widget._qualiModel.answers[3] != '')
                            Text('4 - ${widget._qualiModel.answers[3]}'),
                          if (widget._qualiModel.answers[4] != '')
                            Text('5 - ${widget._qualiModel.answers[4]}'),
                        ],
                      ),
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
