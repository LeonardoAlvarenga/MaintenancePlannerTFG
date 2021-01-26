import 'package:flutter/material.dart';

import '../models/equipment_model.dart';

class Equipments with ChangeNotifier {
  List<EquipmentModel> _listOfEquipments = [
    EquipmentModel(
      equipID: 'equip0001',
      equipName: 'Caminhão',
      equipCriticity: EquipCriticity.HighlyImportant,
      equipImageUrl:
          'http://www.vale.com/PT/aboutvale/news/PublishingImages/caminhao_de_frente.jpg',
      equipLocalization: 'Itabira',
    ),
    EquipmentModel(
      equipID: 'equip0002',
      equipName: 'Torno',
      equipCriticity: EquipCriticity.LessImportant,
      equipImageUrl:
          'https://img.olx.com.br/images/58/588823106764177.jpg',
      equipLocalization: 'Belo Horizonte',
    ),
    EquipmentModel(
      equipID: 'equip0003',
      equipName: 'Retroescavadeira',
      equipCriticity: EquipCriticity.HighlyImportant,
      equipImageUrl:
          'https://russelservicos.com.br/wp-content/uploads/2015/11/operador-retroescavadeira-operador-maquinas-construcao-civil.jpg',
      equipLocalization: 'Itabira',
    ),
    EquipmentModel(
      equipID: 'equip0004',
      equipName: 'Hilux',
      equipCriticity: EquipCriticity.Normal,
      equipImageUrl:
          'https://diariodocomercio.com.br/wp-content/uploads/2018/12/Hilux.jpg',
      equipLocalization: 'Itabira',
    ),
  ];

  List<EquipmentModel> get listOfEquipments {
    return [..._listOfEquipments];
  }

  void addEquipment(EquipmentModel newEquipment) {
    _listOfEquipments.add(newEquipment);
    notifyListeners();
  }

  EquipmentModel findByEquipId(String searchId){
    return _listOfEquipments.firstWhere((equip) => equip.equipID == searchId);
  }
}
