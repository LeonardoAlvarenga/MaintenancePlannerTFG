import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/services/auth.dart';
import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/providers/services/database.dart';
import 'package:tfg_app/screens/auth/wrapper.dart';
import 'package:tfg_app/screens/equipment_register/01_equipment_register_screen.dart';
import 'package:tfg_app/screens/equipment_register/maintenance_planner_screen.dart';
import 'package:tfg_app/screens/auth/account_settings_screen.dart';
import 'package:tfg_app/screens/loading_screen.dart';
import 'package:tfg_app/screens/equipments_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: DatabaseServices()),
        StreamProvider<UserFb>.value(
          value: AuthServices().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            bodyText2: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            headline3: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline4: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            color: Colors.teal[900],
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.teal[900],
            textTheme: ButtonTextTheme.primary,
          ),
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
          primaryColorDark: Colors.teal[900],
          primaryColorLight: Colors.tealAccent[700],
          accentColor: Colors.amber,
          errorColor: Colors.red,
          backgroundColor: Colors.grey[100],
          scaffoldBackgroundColor: Colors.grey[300],
          cardColor: Colors.teal[800],
          buttonColor: Colors.amber,
          cursorColor: Colors.black,
          focusColor: Colors.black,
          indicatorColor: Colors.teal[900],
        ),
        title: 'Maintenance App',
        home: Wrapper(),
        routes: {
          LoadingScreen.routeName: (ctx) => LoadingScreen(),
          AccountSettingsScreen.routeName: (ctx) => AccountSettingsScreen(),
          EquipmentsViewScreen.routeName: (ctx) => EquipmentsViewScreen(),
          MaintenancePlannerScreen.routeName: (ctx) => MultiProvider(
                providers: [
                  ChangeNotifierProvider.value(
                    value: QuantitativeListProvider(),
                  ),
                  ChangeNotifierProvider.value(
                    value: QualitativeListProvider(),
                  )
                ],
                child: MaintenancePlannerScreen(),
              ),
          EquipmentRegisterScreen.routeName: (ctx) => MultiProvider(
                providers: [
                  Provider.value(
                    value: GeneralEquipmentProvider(),
                  ),
                ],
                child: EquipmentRegisterScreen(),
              ),
        },
      ),
    );
  }
}
