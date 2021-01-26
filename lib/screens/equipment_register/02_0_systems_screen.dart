import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tfg_app/screens/loading_screen.dart';
import 'package:tfg_app/widgets/new_sistem_diaglog.dart';

class SystemsScreen extends StatefulWidget {
  static const routeName = '/systems-screen';

  final DocumentReference equipmentReference;
  final String equipmentName;

  SystemsScreen(this.equipmentReference, this.equipmentName);

  @override
  _SystemsScreenState createState() => _SystemsScreenState();
}

class _SystemsScreenState extends State<SystemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.equipmentName),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColorDark,
        label: Text(
          'Adicionar Sistema',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (ctx) {
              return NewSystemDialog(
                reference: widget.equipmentReference,
              );
            },
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SystemsList(widget.equipmentReference),
    );
  }
}

class SystemsList extends StatelessWidget {
  final DocumentReference equipmentReference;

  SystemsList(this.equipmentReference);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: equipmentReference.collection('systems').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return LoadingScreen(loadingMessage: 'Criando o Sistema');
          default:
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        child: Text(
                          'Nome do Sistema:',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      title: Text(
                        document['name'],
                        style: TextStyle(
                          // color: Colors.white,
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
