import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/screens/loading_screen.dart';
import 'package:tfg_app/screens/system_details_screen.dart';

class ListOfSystemsSnapshots extends StatelessWidget {
  final DatabaseServices databaseServices;
  final DocumentSnapshot equipSnapshots;
  final DocumentReference equipReference; //equipamento selecionado

  ListOfSystemsSnapshots({
    @required this.databaseServices,
    @required this.equipSnapshots,
    @required this.equipReference,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: equipReference.collection('systems').orderBy('name').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingScreen();
          default:
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: snapshot.data.documents
                  .map((DocumentSnapshot systemSnapshot) {
                return SystemItem(
                  systemSnapshot: systemSnapshot,
                  equipSnapshots: equipSnapshots,
                );
              }).toList(),
            );
        }
      },
    );
  }
}

class SystemItem extends StatefulWidget {
  final DocumentSnapshot systemSnapshot;
  final DocumentSnapshot equipSnapshots;

  SystemItem({this.systemSnapshot, this.equipSnapshots});

  @override
  _SystemItemState createState() => _SystemItemState();
}

class _SystemItemState extends State<SystemItem> {
  bool _isExpanded = true;

  void toogleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;

    return Column(
      key: ValueKey(widget.systemSnapshot.documentID),
      children: [
        Container(
          color: _isExpanded
              ? primaryColorDark.withOpacity(.1)
              : Colors.transparent,
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            children: [
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.systemSnapshot['name'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                onPressed: toogleExpanded,
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        if (_isExpanded) Divider(color: Colors.black, height: 0),
        if (_isExpanded)
          Container(
            color: _isExpanded
                ? primaryColorDark.withOpacity(.1)
                : Colors.transparent,
            height: MediaQuery.of(context).size.height * .2,
            child: Stack(
              children: [
                Center(
                  child: Text('Lista de Manutenções'),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => SystemDetailsScreen(
                            equipSnapshot: widget.equipSnapshots,
                            systemSnapshot: widget.systemSnapshot,
                          ),
                        ),
                      );
                    },
                    child: Chip(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 3,
                        right: 8,
                      ),
                      labelPadding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 8,
                        right: 3,
                      ),
                      elevation: 5,
                      avatar: Icon(Icons.edit),
                      label: Text('Editar'),
                    ),
                  ),
                )
              ],
            ),
          ),
        if (_isExpanded) SizedBox(height: 15),
        Divider(
          color: primaryColorDark,
        ),
      ],
    );
  }
}
