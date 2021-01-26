import 'package:flutter/material.dart';

import './quantitative_screen.dart';
import './qualitative_screen.dart';

class MaintenancePlanScreen extends StatefulWidget {
  static const routeName = '/add-maintenance-plan-screen';
  @override
  _MaintenancePlanScreenState createState() => _MaintenancePlanScreenState();
}

class _MaintenancePlanScreenState extends State<MaintenancePlanScreen> {
  int _currentIndex = 0;

  List<Widget> quantQualiScreens = [
    QuantitativeScreen(),
    QualitativeScreen(),
  ];

  void _changeIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final String newEquipName = ModalRoute.of(context).settings.arguments;

    final AppBar appBar = AppBar(
      title: Text('Novo Equipamento'),
    );
    return Scaffold(
      appBar: appBar,
      body: quantQualiScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(size: 30),
        selectedFontSize: 16,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: _currentIndex,
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(
              title: Text('Quantitativos'),
              icon: Icon(Icons.format_list_numbered)),
          BottomNavigationBarItem(
              title: Text('Qualitativos'),
              icon: Icon(Icons.format_list_bulleted)),
        ],
      ),
    );
  }
}

// void _addNewQuantitative(
//     String parameterNameRecieved,
//     double minValueRecieved,
//     double maxValueRecieved,
//     String unitNameRecieved,
//   ) {
//     final newTx = Quantitative(
//       parameterName: parameterNameRecieved,
//       maxValue: maxValueRecieved,
//       minValue: minValueRecieved,
//       unitName: unitNameRecieved,
//       id: DateTime.now(),
//     );

//     setState(() {
//       _quantitativeList.add(newTx);
//     });
//   }

//   void _addNewQualitative(
//     String parameterNameRecieved,
//     String descriptionRecieved,
//   ) {
//     final newQualitative = Qualitative(
//       parameterName: parameterNameRecieved,
//       parameterDescription: descriptionRecieved,
//       id: DateTime.now(),
//     );

//     setState(() {
//       _qualitativeList.add(newQualitative);
//     });
//   }

//   void _startAddNewQuantitative(BuildContext ctx) {
//     showModalBottomSheet(
//       backgroundColor: Theme.of(context).cardColor,
//       context: ctx,
//       builder: (bCtx) {
//         return GestureDetector(
//           onTap: () {},
//           child: AddQuantitative(
//             selectHandler: _addNewQuantitative,
//           ),
//         );
//       },
//     );
//   }

//   void _startAddNewQualitative(BuildContext ctx) {
//     showModalBottomSheet(
//       backgroundColor: Theme.of(context).cardColor,
//       context: ctx,
//       builder: (bCtx) {
//         return GestureDetector(
//           onTap: () {},
//           child: AddQualitative(
//             selectHandler: _addNewQualitative,
//           ),
//         );
//       },
//     );
//   }

//   void _deleteQuantitative(String parameterName, DateTime id) {
//     setState(() {
//       _quantitativeList.removeWhere((element) =>
//           element.parameterName == parameterName && element.id == id);
//     });
//   }

//   void _deleteQualitative(String nameParameter, DateTime id) {
//     setState(() {
//       _qualitativeList.removeWhere((element) =>
//           element.parameterName == nameParameter && element.id == id);
//     });
//   }
