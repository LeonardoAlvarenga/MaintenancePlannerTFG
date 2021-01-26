// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

// import './equipment_details_screen.dart';

// class InspectionScreenQR extends StatefulWidget {
//   static const routeName = '/inspection-screen-QR';

//   @override
//   _InspectionScreenQRState createState() => _InspectionScreenQRState();
// }

// class _InspectionScreenQRState extends State<InspectionScreenQR> {
//   String _scanQRText = 'Scan QR';

//   final _inputIdController = TextEditingController();

//   void _selectedEquipment(BuildContext ctx) {
//     Navigator.of(ctx).pushReplacementNamed(ViewEquipScreen.routeName,
//         arguments: _scanQRText);
//   }

//   Future _scanQR(BuildContext ctx) async {
//     try {
//       String qrResult = await BarcodeScanner.scan();
//       _scanQRText = qrResult;
//       _selectedEquipment(ctx);
//     } on PlatformException catch (exeption) {
//       if (exeption.code == BarcodeScanner.CameraAccessDenied) {
//         setState(() {
//           _scanQRText = 'Permissão de Acesso à Câmera Negada';
//         });
//       } else {
//         setState(() {
//           _scanQRText = 'Erro Desconhecido $exeption';
//         });
//       }
//     } on FormatException {
//       setState(() {
//         _scanQRText = 'Scan Cancelado Antes De Sua Finalização';
//       });
//     } catch (exeption) {
//       setState(() {
//         _scanQRText = 'Erro Desconhecido $exeption';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     MediaQueryData mQCtx = MediaQuery.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Realizar Inspeção'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         children: <Widget>[
//           SizedBox(
//             height: 20,
//           ),
//           InkWell(
//             borderRadius: BorderRadius.circular(15),
//             splashColor: Colors.teal,
//             onTap: () => _scanQR(context),
//             child: Container(
//               width: mQCtx.size.width * .5,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 gradient: LinearGradient(
//                   begin: Alignment.topRight,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     // Colors.amber[700].withOpacity(.9),
//                     Theme.of(context).primaryColorDark.withOpacity(.9),
//                     Theme.of(context).primaryColorDark.withOpacity(.8),
//                     Theme.of(context).primaryColorDark.withOpacity(.75),
//                     Theme.of(context).primaryColorDark.withOpacity(.8),
//                     Theme.of(context).primaryColorDark.withOpacity(.9),
//                     // Colors.amber[700].withOpacity(.9),
//                   ],
//                 ),
//               ),
//               height: mQCtx.size.height * 0.4,
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: mQCtx.size.height * 0.03),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Text(
//                       _scanQRText,
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(height: mQCtx.size.height * 0.05),
//                   Icon(
//                     Icons.camera_alt,
//                     size: mQCtx.size.height * 0.18,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: InkWell(
//               onTap: () {
//                 showModalBottomSheet(
//                     context: context,
//                     builder: (ctx) {
//                       return Container(
//                         color: Theme.of(context).accentColor,
//                         child: Column(
//                           children: <Widget>[
//                             TextField(
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'EquipID',
//                                 icon: Icon(Icons.subtitles),
//                               ),
//                               controller: _inputIdController,
//                             ),
//                             RaisedButton.icon(
//                               onPressed: () {},
//                               icon: Icon(Icons.search),
//                               label: Text('Pesquisar'),
//                             )
//                           ],
//                         ),
//                       );
//                     });
//               },
//               splashColor: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 child: Text(
//                   'Selecionar Manualmente',
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
