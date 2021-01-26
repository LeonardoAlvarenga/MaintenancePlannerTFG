import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/widgets/list_of_systems_widget.dart';

class EquipmentsDetailsScreen extends StatelessWidget {
  static const routeName = '/equipment-details-screen';
  final DocumentSnapshot documentSnapshot;

  EquipmentsDetailsScreen(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    final _databaseServices =
        Provider.of<DatabaseServices>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${documentSnapshot['name']}'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.extension),
            ),
            Tab(
              icon: Icon(Icons.edit),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            ListOfSystemsSnapshots(
              databaseServices: _databaseServices,
              equipSnapshots: documentSnapshot,
              equipReference: documentSnapshot.reference,
            ),
            Center(
              child: Text('Equipment Details'),
            ),
          ],
        ),
      ),
    );
  }
}
