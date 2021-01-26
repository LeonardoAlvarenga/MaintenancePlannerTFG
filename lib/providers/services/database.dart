/*
  Essa classe contem todas as funções e valores necessárias para a comunicação e registo de dados no Database
  O nosso Banco contem a seguinte organização:

  - Database:
    - Equipaments (Lista de Equipamentos)
      - Equipamento A
        - ...
      - Equipamento B
        - ...
      - Equipamento X
        - Systems (Lista de Systems referentes ao Equipamento X) => Assim, para acessá-lo, preciso chamar pelo equipamento antes... (equipmentId/systems)
          - System 1
            - ...
          - System 2
            - ...
          - System 1008
            - MaintenancePlans (Lista de planos de manutenção adicionados para o SISTEMA N)
              - REFERÊNCIA DO PLANO 1 (como uma URL)
              - REFERÊNCIA DO PLANO 5 (como uma URL)
              - ...
              - REFERÊNCIA DO PLANO 1023 (como uma URL)
            - SubSystems (Lista de SubSystems referentes ao System 1008 do Equipamento X)
              - SubSystem A
                - ...
              - SubSystem B
                - ...
              - SubSystem ...
                - ...
              - SubSystem Z
                - MaintenancePlans (Lista de planos de manutenção adicionados para o SUBSISTEMA Z)
                  - REFERÊNCIA DO PLANO 10 (como uma URL)
                  - REFERÊNCIA DO PLANO 52 (como uma URL)
                  - ...
                  - REFERÊNCIA DO PLANO 923 (como uma URL)
                - Components (Lista Componentes do SubSystem Z referente ao System 1008 do Equipamento X)
                  - Componente 1
                  - Componente 2
                  - ...
                  - Componente 2032
                    - MaintenancePlans (Lista de planos de manutenção adicionados para o COMPONENTE 2032)
                      - REFERÊNCIA DO PLANO 100 (como uma URL)
                      - REFERÊNCIA DO PLANO 526 (como uma URL)
                      - ...
                      - REFERÊNCIA DO PLANO 996 (como uma URL)

    - Lista de Planos de Manutenção (TODOS os planos estão aqui)
      - Plano 1
      - Plano 2
      - Plano ...
      - Plano 1023
      - Plano 1024
      - ...

  Informações:
    - Os planos de manutenção possuem NOME, DATA DE INSPEÇÃO, e recebem a ID do equipamento ao qual elas se relacionam
    - Os planos de manutenção também estão no nível primário, de modo que se torna fácil acessá-los em demais partes do código (imagino que será útil para verificar as inspeções do dia)

*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tfg_app/models/errors/firebase_auth_expection.dart';
import 'package:tfg_app/providers/equipment_provider.dart';

enum DatabaseNivel {
  Equipment,
  System,
  SubSystem,
  Component,
  MaintenancePlan,
}

class DatabaseServices {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  DocumentReference _equipReference;
  DocumentReference _systemReference;
  DocumentReference _subSystemReference;
  DocumentReference _componentReference;
  DocumentReference _maintenancePlanReference;

/*
  Resources functions




*/

  DocumentReference get equipReference {
    return _equipReference;
  }

  DocumentReference get systemReference {
    return _systemReference;
  }

  DocumentReference get subSystemReference {
    return _subSystemReference;
  }

  DocumentReference get componentReference {
    return _componentReference;
  }

  DocumentReference get maintenancePlanReference {
    return _maintenancePlanReference;
  }

  void updateEquipReference(DocumentReference newReference) {
    _equipReference = newReference;
  }

  void updateSystemReference(DocumentReference newReference) {
    _systemReference = newReference;
  }

  void updateSubSystemReference(DocumentReference newReference) {
    _subSystemReference = newReference;
  }

  void updateComponentReference(DocumentReference newReference) {
    _componentReference = newReference;
  }

  void updateMaintenancePlanReference(DocumentReference newReference) {
    _maintenancePlanReference = newReference;
  }

  Map<String, Object> _maintenancePlanGeneralData(
      DatabaseNivel databaseNivel, String maintenancePlanName) {
    switch (databaseNivel) {
      case (DatabaseNivel.Equipment):
        return {
          'databaseNivel': 'equipment',
          'referedById': _equipReference.documentID,
          'name': maintenancePlanName,
          'equipment': _equipReference,
          'system': null,
          'subSystem': null,
          'component': null,
        };
        break;
      case (DatabaseNivel.System):
        return {
          'databaseNivel': 'system',
          'referedById': _systemReference.documentID,
          'name': maintenancePlanName,
          'equipment': _equipReference,
          'system': _systemReference,
          'subSystem': null,
          'component': null,
        };
        break;
      case (DatabaseNivel.SubSystem):
        return {
          'databaseNivel': 'subSystem',
          'referedById': _subSystemReference.documentID,
          'name': maintenancePlanName,
          'equipment': _equipReference,
          'system': _systemReference,
          'subSystem': _subSystemReference,
          'component': null,
        };
        break;
      default:
        return {
          'databaseNivel': 'component',
          'referedById': _componentReference.documentID,
          'name': maintenancePlanName,
          'equipment': _equipReference,
          'system': _systemReference,
          'subSystem': _subSystemReference,
          'component': _componentReference,
        };
    }
  }

/*
  Equipments




*/

  // Collection Reference - Equipments
  final CollectionReference _equipmentCollection =
      Firestore.instance.collection('equipments');

  // Add New Equipment - Equipments
  Future<DocumentReference> addNewEquipment(
      EquipmentGeneralData newEquip) async {
    try {
      final user = await _firebaseAuth.currentUser();
      final userId = user.uid;

      final equipReference = await _equipmentCollection.add({
        'creatorId': userId,
        'name': newEquip.name,
        'acquisitionDateIsoString': newEquip.acquisitionDateIsoString,
        'location': newEquip.location,
        'equipCriticity': newEquip.equipCriticity,
      });

      _equipReference = equipReference;

      return equipReference;
    } catch (error) {
      throw FbAuthException(error);
    }
  }

/*
  Systems
    



*/

  // Adicionar novo System para um dado equipamento (informado)
  Future<DocumentReference> addNewSystem({String systemName}) async {
    try {
      final pathString = '${_equipReference.path}/systems';
      final systemReference =
          await _fireStore.collection(pathString).add({'name': systemName});

      _systemReference = systemReference;
      return systemReference;
    } catch (error) {
      throw error;
    }
  }

/*
  SubSystems




*/

  // Adicionar novo System para um dado equipamento (informado)
  Future<DocumentReference> addNewSubSystem({String subSystemName}) async {
    try {
      final pathString = '${_systemReference.path}/systems';
      final subSystemReference =
          await _fireStore.collection(pathString).add({'name': subSystemName});

      _subSystemReference = subSystemReference;
      return subSystemReference;
    } catch (error) {
      throw error;
    }
  }

/*
  Components
  



*/

  // Adicionar novo System para um dado equipamento (informado)
  Future<DocumentReference> addNewComponentSystem(
      {String componentName}) async {
    try {
      final pathString = '${_subSystemReference.path}/systems';
      final componentReference =
          await _fireStore.collection(pathString).add({'name': componentName});

      _componentReference = componentReference;
      return componentReference;
    } catch (error) {
      throw error;
    }
  }

/*
  Planos de Manutenção



*/

  // Collection Reference - Maintenance Plans
  final CollectionReference _maintenancePlansCollection =
      Firestore.instance.collection('maintenancePlans');

  // Cria um novo Plano de Manutenção na coleção de nível primário(maintenancePlans)
  // e adiciona uma referencia do mesmo ao System informado
  Future<void> addMaintenancePlan({
    DatabaseNivel databaseNivel,
    MaintenancePlanModel maintenancePlanModel,
    // Map<String, String>
  }) async {
    try {
      final maintenancePlanReference = await _maintenancePlansCollection.add(
        _maintenancePlanGeneralData(
          databaseNivel,
          maintenancePlanModel.name,
        ),
      );

      _maintenancePlanReference = maintenancePlanReference;

      final qualitativeCollection =
          maintenancePlanReference.collection('qualitatives');
      final quantitativeCollection =
          maintenancePlanReference.collection('quantitatives');

      maintenancePlanModel.listOfQualitatives.forEach((qualitativeModel) {
        qualitativeCollection.add({
          'inspectionName': qualitativeModel.inspectionName,
          'description': qualitativeModel.description,
          'answers': qualitativeModel.answers,
        });
      });

      maintenancePlanModel.listOfQuantitatives.forEach((quantitativeModel) {
        quantitativeCollection.add({
          'inspectionName': quantitativeModel.inspectionName,
          'measureEquipment': quantitativeModel.measureEquipment,
          'description': quantitativeModel.description,
          'greatness': quantitativeModel.greatness,
          'chosenUnit': quantitativeModel.chosenUnit,
          'minValue': quantitativeModel.minValue,
          'maxValue': quantitativeModel.maxValue,
        });
      });
    } catch (error) {
      throw error;
    }
  }
}
