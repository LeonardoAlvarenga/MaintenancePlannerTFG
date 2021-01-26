import 'package:flutter/foundation.dart';

class EquipmentGeneralData {
  final String name;
  final String acquisitionDateIsoString;
  final String localization;
  final String system;
  final String subSystem;
  final String componente;
  final int equipCriticity;

  EquipmentGeneralData({
    this.name = '',
    this.acquisitionDateIsoString = '',
    this.localization = '',
    this.system = '',
    this.subSystem = '',
    this.componente = '',
    this.equipCriticity = 1,
  });
}

class GeneralEquipmentProvider {
  var _equipmentGeneralData = EquipmentGeneralData();

  void changeGeneralData(EquipmentGeneralData newValue) {
    _equipmentGeneralData = newValue;
    print('valueUpdated');
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
  List<QuantitativeModel> _quantitativeList = [
    QuantitativeModel(
      id: 'id1',
      inspectionName: 'Temperatura do Motor',
      measureEquipment: 'Termômetro Infravermelho',
      greatness: 'Temperatura',
      chosenUnit: 'ºC',
      minValue: '100',
      maxValue: '1200',
      description:
          'Medir a temperatura do motor do caminhão durante seu funcionamento.',
    ),
    QuantitativeModel(
      id: 'id2',
      inspectionName: 'Pressão Interna do Pneu',
      measureEquipment: 'Computador de Bordo do Caminhão',
      greatness: 'Pressão',
      chosenUnit: 'bar',
      minValue: '100',
      maxValue: '18500',
      description:
          'Verificar a pressão do pneu do caminhão. Disponível na tela interativa do caminhão.',
    ),
    QuantitativeModel(
      id: 'id3',
      inspectionName: 'Vibração',
      measureEquipment: 'Odômetro',
      greatness: 'Velocidade',
      chosenUnit: 'mm/s',
      minValue: '0',
      maxValue: '5',
      description: 'Verificar a velocidade de Vibração dessa treta aí.',
    ),
    QuantitativeModel(
      id: 'id4',
      inspectionName: 'Profundidade dos Sulcos do Pneu',
      measureEquipment: 'Paquímetro',
      greatness: 'Comprimento',
      chosenUnit: 'mm',
      minValue: '10',
      maxValue: '100',
      description: '',
    ),
  ];

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
  List<QualitativeModel> _listOfQualitatives = [
    QualitativeModel(
      id: DateTime.now().toString(),
      inspectionName: 'Furo Pneu',
      description: 'Observar se o Pneu está furado.',
      answers: [
        'Sim',
        'Não',
        '',
        '',
        '',
      ],
    ),
    QualitativeModel(
      id: DateTime.now().toString(),
      inspectionName: 'Partículas Magnéticas',
      description:
          'A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item... A descrição pode ser BASTANTE extensa, o que talvez se faça útil a utilização de uma SingleChildScrollView para visualizá-la... Dentro, é claro, de seu item...',
      answers: [
        'Nenhum problema encontrado.',
        'Necessário observar equipamento.',
        'Falhas encontradas.',
        '',
        '',
      ],
    ),
    QualitativeModel(
      id: DateTime.now().toString(),
      inspectionName: 'Líquidos Penetrantes',
      description: 'Nada.',
      answers: [
        'Nenhum problema encontrado.',
        'Necessário observar equipamento.',
        'Falhas encontradas.',
        '',
        '',
      ],
    ),
  ];

  List<QualitativeModel> get listOfQualitatives {
    return [..._listOfQualitatives];
  }

  QualitativeModel getQualitativeById(String id) {
    return _listOfQualitatives.firstWhere((item) => item.id == id);
  }

  void addNewQualitative(QualitativeModel newItem) {
    _listOfQualitatives.add(newItem);
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
