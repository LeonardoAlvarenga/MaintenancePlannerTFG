import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MaintenancePlansList extends StatefulWidget {
  final DocumentReference reference;

  MaintenancePlansList(this.reference);

  @override
  _MaintenancePlansListState createState() => _MaintenancePlansListState();
}

class _MaintenancePlansListState extends State<MaintenancePlansList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('maintenancePlans')
          .where('referedBy', isEqualTo: widget.reference.documentID)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Carregando...');
          default:
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        document['referedBy'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              print('');
                            },
                            color: Colors.black,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              print('');
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
