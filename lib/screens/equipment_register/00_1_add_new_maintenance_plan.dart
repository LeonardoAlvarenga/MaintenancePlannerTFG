import 'package:flutter/material.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/screens/loading_screen.dart';
import 'add_edit_qualitative_screens/qualitatives_screen.dart';
import 'add_edit_quantitative_screens/quantitatives_screen.dart';

class AddNewMaintenancePlan extends StatelessWidget {
  final DatabaseNivel databaseNivel;
  final MaintenancePlanModel maintenancePlanModelIncomplete;

  AddNewMaintenancePlan({
    @required this.databaseNivel,
    @required this.maintenancePlanModelIncomplete,
  });

  Future<void> saveMaintenancePlan() async {
    print('chamando');
    try {
      final maintenancePlanModelComplete = MaintenancePlanModel(
        id: maintenancePlanModelIncomplete.id,
        name: maintenancePlanModelIncomplete.name,
        listOfQualitatives: QualitativeListProvider().listOfQualitatives,
        listOfQuantitatives: QuantitativeListProvider().quantitativeList,
        frequencyInDays: maintenancePlanModelIncomplete.frequencyInDays,
        lastInspectionDateIso:
            maintenancePlanModelIncomplete.lastInspectionDateIso,
      );
      await DatabaseServices().addMaintenancePlan(
        databaseNivel: databaseNivel,
        maintenancePlanModel: maintenancePlanModelComplete,
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).pushNamed(LoadingScreen.routeName);
                  saveMaintenancePlan()
                      .then((_) => Navigator.of(context).pop());
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.save_alt),
                        Text(
                          'Salvar Plano de Manutenção',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
            SizedBox(width: 10),
          ],
          title: Text('Novo PM:  ${maintenancePlanModelIncomplete.name}'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.assessment),
            ),
            Tab(
              icon: Icon(Icons.border_color),
            )
          ]),
        ),
        body: TabBarView(children: [
          QuantitativesScreen(),
          QualitativesScreen(),
        ]),
      ),
    );
  }
}
