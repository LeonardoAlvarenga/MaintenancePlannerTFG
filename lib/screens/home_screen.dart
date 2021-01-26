import 'package:flutter/material.dart';
import 'package:tfg_app/screens/equipments_view_screen.dart';

import '../widgets/menu_item.dart';
import './app_drawer.dart';
import 'package:tfg_app/screens/equipment_register/01_equipment_register_screen.dart';
import 'package:tfg_app/providers/services/auth.dart';
import 'package:tfg_app/screens/auth/account_settings_screen.dart';
import 'package:tfg_app/screens/loading_screen.dart';
// import 'package:tfg_app/screens/all_equipments_screen.dart';
// import '../screens/inspection_screen_QR.dart';

class HomeMenuOption {
  final String id;
  final String title;
  final Icon icon;
  final String routeName;

  const HomeMenuOption({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.routeName,
  });
}

final List<HomeMenuOption> homeMenuOptions = [
  HomeMenuOption(
    id: 'hmo1',
    title: 'Cadastrar Equipamento',
    icon: Icon(Icons.add_to_queue, size: 50),
    routeName: EquipmentRegisterScreen.routeName,
  ),
  HomeMenuOption(
    id: 'hmo4',
    title: 'Loading Screen',
    icon: Icon(Icons.visibility, size: 50),
    routeName: LoadingScreen.routeName,
  ),
  HomeMenuOption(
    id: 'hmo5',
    title: 'Equipamentos Registrados',
    icon: Icon(Icons.list, size: 50),
    routeName: EquipmentsViewScreen.routeName,
  ),
];

enum PopUpMenuValues {
  MinhaConta,
  Sair,
}

class HomeScreen extends StatelessWidget {
  final _authServices = AuthServices();

  final List<HomeMenuOption> menuOptions = homeMenuOptions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Menu Inicial'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              if (value == PopUpMenuValues.Sair) {
                _authServices.signOut();
              } else {
                Navigator.of(context)
                    .pushReplacementNamed(AccountSettingsScreen.routeName);
              }
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person_outline),
                      SizedBox(width: 15),
                      Text('Minha Conta'),
                    ],
                  ),
                  value: PopUpMenuValues.MinhaConta,
                ),
                PopupMenuItem(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 15),
                      Text('Sair'),
                    ],
                  ),
                  value: PopUpMenuValues.Sair,
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: homeMenuOptions.length,
          itemBuilder: (ctx, index) {
            return MenuItem(
              optionTitle: homeMenuOptions[index].title,
              optionIcon: homeMenuOptions[index].icon,
              routeName: homeMenuOptions[index].routeName,
            );
          },
        ),
      ),
    );
  }
}
