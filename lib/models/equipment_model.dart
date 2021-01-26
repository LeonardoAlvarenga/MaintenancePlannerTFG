import 'package:flutter/material.dart';

enum EquipCriticity {
  LessImportant,
  Normal,
  HighlyImportant,
}

class EquipmentModel {
  final String equipID;
  final String equipName;
  final String equipLocalization;
  // final String equipSystem;
  // final String equipeSubSystem;
  // final String equipComponent;
  // final String equipStartOperation;
  final EquipCriticity equipCriticity;
  final String equipImageUrl;

  EquipmentModel({
    @required this.equipID,
    // @required this.equipComponent,
    @required this.equipCriticity,
    // @required this.equipeSubSystem,
    @required this.equipImageUrl,
    @required this.equipLocalization,
    @required this.equipName,
    // @required this.equipStartOperation,
    // @required this.equipSystem,
  });
}
