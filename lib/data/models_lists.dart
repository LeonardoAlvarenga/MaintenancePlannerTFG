import 'package:flutter/material.dart';
import 'package:tfg_app/screens/all_equipments_screen.dart';
import 'package:tfg_app/screens/equipment_register/add_new_equipment.dart';
import 'package:tfg_app/tests/screens/tester_screen.dart';

import '../screens/inspection_screen_QR.dart';
// import '../screens/register_equipment_screen.dart';
import '../models/home_menu_option.dart';

final List<HomeMenuOption> homeMenuOptions = [
  HomeMenuOption(
    id: 'hmo1',
    title: 'Cadastrar Equipamento',
    icon: Icon(Icons.add_to_queue, size: 50),
    routeName: AddNewEquipmentScreen.routeName,
  ),
  HomeMenuOption(
    id: 'hmo2',
    title: 'Realizar Inspeção',
    icon: Icon(Icons.playlist_add_check, size: 50),
    routeName: InspectionScreenQR.routeName,
  ),
  HomeMenuOption(
    id: 'hmo3',
    title: 'Controle de Ativos',
    icon: Icon(Icons.visibility, size: 50),
    routeName: AllEquipmentsScreen.routeName,
  ),
  HomeMenuOption(
    id: 'hmo4',
    title: 'Testes',
    icon: Icon(Icons.device_unknown, size: 50),
    routeName: TesterScreen.routeName,
  ),
];
