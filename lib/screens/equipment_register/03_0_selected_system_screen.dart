import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/screens/equipment_register/00_1_add_new_maintenance_plan.dart';
import '00_0_add_new_maintenance_sheet.dart';
import 'package:tfg_app/screens/equipment_register/maintenance_plans_list.dart';

class SelectedSystem extends StatelessWidget {
  static const routeName = '/selected-system-screen';

  final DocumentReference systemReference;
  final String systemName;
  SelectedSystem({this.systemReference, this.systemName});

  Future<void> addNewMaintenancePlan(BuildContext context) async {
    try {
      final MaintenancePlanModel maintenancePlanModel = await showDialog(
          context: context,
          builder: (context) {
            return AddNewMaintenanceSheet(documentReference: systemReference);
          });
      if (maintenancePlanModel != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: QuantitativeListProvider()),
                ChangeNotifierProvider.value(value: QualitativeListProvider()),
              ],
              child: AddNewMaintenancePlan(
                databaseNivel: DatabaseNivel.System,
                maintenancePlanModelIncomplete: maintenancePlanModel,
              ),
            ),
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColorDark = Theme.of(context).primaryColorDark;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(systemName),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.apps)),
            Tab(icon: Icon(Icons.extension)),
          ]),
        ),
        body: TabBarView(
          children: [
            MaintenancePlansList(systemReference),
            Center(child: Text('Subsistemas')),
          ],
        ),
        floatingActionButton: FabCircularMenu(
          fabOpenIcon: Icon(Icons.add, color: Colors.white),
          fabColor: primaryColorDark,
          fabOpenColor: Theme.of(context).accentColor,
          ringColor: primaryColorDark,
          ringDiameter: 350,
          children: [
            InkWell(
              onTap: () {
                addNewMaintenancePlan(context);
              },
              child: Container(
                width: 45,
                child: Stack(
                  children: [
                    Icon(
                      Icons.apps,
                      color: Colors.white,
                      size: 35,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 10,
                        child: FittedBox(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 45,
                child: Stack(
                  children: [
                    Icon(
                      Icons.extension,
                      color: Colors.white,
                      size: 35,
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 10,
                        child: FittedBox(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
