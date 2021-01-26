import 'package:flutter/foundation.dart';

class SystemModel {
  final String systemName;
  final List<String> subSystems;

  SystemModel({
    this.systemName,
    this.subSystems,
  });
}

class RegisteredSystems {
  // Map<String, SystemModel> _registeredSystems = {};

}

//
// Dados Gerais
//

class EquipmentGeneralData {
  String id;
  final String name;
  final String acquisitionDateIsoString;
  final String location;
  final int equipCriticity;

  EquipmentGeneralData({
    this.id = '',
    this.name = '',
    this.acquisitionDateIsoString = '',
    this.location = '',
    this.equipCriticity = 1,
  });
}

class GeneralEquipmentProvider {
  var _equipmentGeneralData = EquipmentGeneralData();

  void changeGeneralData(EquipmentGeneralData newValue) {
    _equipmentGeneralData = newValue;
  }

  EquipmentGeneralData get existingValues {
    return [_equipmentGeneralData][0];
  }

  void resetValue() {
    _equipmentGeneralData = EquipmentGeneralData();
  }
}

//
//
// Maintenance Plan Model
//
//

class MaintenancePlanModel {
  final String id;
  final String name;
  final List<QualitativeModel> listOfQualitatives;
  final List<QuantitativeModel> listOfQuantitatives;
  final int frequencyInDays;
  final String lastInspectionDateIso;

  MaintenancePlanModel({
    @required this.id,
    @required this.name,
    @required this.listOfQualitatives,
    @required this.listOfQuantitatives,
    @required this.frequencyInDays,
    @required this.lastInspectionDateIso,
  });
}

//
//
// Quantitative
//
//

class QuantitativeModel {
  final String id;
  final String inspectionName;
  final String measureEquipment;
  final String description;
  final String greatness;
  final String chosenUnit;
  final String minValue;
  final String maxValue;

  QuantitativeModel({
    @required this.id,
    @required this.inspectionName,
    @required this.measureEquipment,
    @required this.greatness,
    @required this.chosenUnit,
    @required this.minValue,
    @required this.maxValue,
    @required this.description,
  });
}

class QuantitativeListProvider with ChangeNotifier {
  List<QuantitativeModel> _quantitativeList = [];

  List<QuantitativeModel> get quantitativeList {
    return [..._quantitativeList];
  }

  void addNewQuantitative(QuantitativeModel newQuantitative) {
    _quantitativeList.add(newQuantitative);
    notifyListeners();
  }

  void deleteQuantitative(String quantId) {
    _quantitativeList.removeWhere((quantItem) => quantItem.id == quantId);
    notifyListeners();
  }

  void editQuantitative(QuantitativeModel updatedItem) {
    final index =
        _quantitativeList.indexWhere((item) => item.id == updatedItem.id);
    _quantitativeList[index] = updatedItem;
    notifyListeners();
  }

  QuantitativeModel getItemById(String itemId) {
    return _quantitativeList.firstWhere((quantItem) => quantItem.id == itemId);
  }
}

//
//
// Qualitative
//
//

class QualitativeModel {
  final String id;
  final String inspectionName;
  final String description;
  final List<String> answers;

  QualitativeModel({
    @required this.id,
    @required this.inspectionName,
    @required this.description,
    @required this.answers,
  });
}

class QualitativeListProvider with ChangeNotifier {
  List<QualitativeModel> _listOfQualitatives = [];

  List<QualitativeModel> get listOfQualitatives {
    return [..._listOfQualitatives];
  }

  QualitativeModel getQualitativeById(String id) {
    return _listOfQualitatives.firstWhere((item) => item.id == id);
  }

  void addNewQualitative(QualitativeModel newItem) {
    _listOfQualitatives.add(newItem);
    notifyListeners();
  }

  void updateQualitative(QualitativeModel updatedItem) {
    final index =
        _listOfQualitatives.indexWhere((item) => item.id == updatedItem.id);
    if (index >= 0) {
      _listOfQualitatives[index] = updatedItem;
      notifyListeners();
    }
  }

  void deleteQualitativeByItemId(String itemId) {
    _listOfQualitatives.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }
}
