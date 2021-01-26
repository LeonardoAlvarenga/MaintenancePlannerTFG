import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/widgets/list_of_equipments_widget.dart';

class EquipmentsViewScreen extends StatelessWidget {
  static const routeName = '/equipments-view-screen';

  @override
  Widget build(BuildContext context) {
    final databaseServices = Provider.of<DatabaseServices>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipamentos Registrados'),
      ),
      body: ListOfEquipments(
        databaseServices,
      ),
    );
  }
}
