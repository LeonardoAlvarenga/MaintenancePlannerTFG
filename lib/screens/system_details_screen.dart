import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/screens/equipment_details_screen.dart';

class SystemDetailsScreen extends StatelessWidget {
  static const routeName = '/equipment-details-screen';

  final DocumentSnapshot equipSnapshot;
  final DocumentSnapshot systemSnapshot;

  SystemDetailsScreen({
    @required this.equipSnapshot,
    @required this.systemSnapshot,
  });

  @override
  Widget build(BuildContext context) {
    final _databaseServices =
        Provider.of<DatabaseServices>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _databaseServices.updateSystemReference(null);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => EquipmentsDetailsScreen(equipSnapshot),
                  ),
                );
              }),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${equipSnapshot['name']}',
                style: TextStyle(color: Colors.grey[300], fontSize: 11),
              ),
              Text(
                '${systemSnapshot['name']}',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.extension),
            ),
            Tab(
              icon: Icon(Icons.list),
            ),
            Tab(
              icon: Icon(Icons.edit),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            // ListOfSystemsSnapshots(
            //   databaseServices: _databaseServices,
            //   documentReference: documentSnapshot.reference,
            // ),
            Center(
              child: Text('Subsystems List'),
            ),
            Center(
              child: Text('Maintenance Details'),
            ),
            Center(
              child: Text('System Details'),
            ),
          ],
        ),
      ),
    );
  }
}
