import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/equipment_provider.dart';
import 'package:tfg_app/screens/equipment_register/add_edit_quantitative_screens/quantitatives_screen.dart';
import 'package:tfg_app/screens/equipment_register/add_edit_qualitative_screens/qualitatives_screen.dart';

/* 
  Tela de Registro do Plano de Manutenção
  Ela fará o gerenciamento dos Widgets(Screens) que estarão sendo exibidos na tela...
  Serão 2 Screens:
    - Quantitativos
    - Qualitativos

  As duas páginas tratam do plano de manutenção em si, estes devem ser mais flexíveis...
  Entretanto, no caso do Quantitativo, teremos limitações nas unidades de medidas que serão adotadas...
  
  Precisarei exibir, para o Engenheiro, a lista de unidades disponíveis para serem utilizadas. 
  E, de acordo com o escolhido, mostrar uma determinada saída de valor na tela...
 */

class MaintenancePlannerScreen extends StatelessWidget {
  static const routeName = '/maintenance-planner-screen';

  @override
  Widget build(BuildContext context) {
    final List<Widget> _addEquipScreens = [
      Consumer<QuantitativeListProvider>(
        builder: (context, quantitativeProvider, child) {
          return QuantitativesScreen();
        },
      ),
      Consumer<QualitativeListProvider>(
        builder: (context, qualitativeProvider, child) {
          return QualitativesScreen();
        },
      ),
    ];

    return MultiProvider(
      providers: [
        Provider(create: (ctx) => GeneralEquipmentProvider()),
      ],
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cadastrar Equipamento'),
            actions: <Widget>[
              IconButton(onPressed: () {}, icon: Icon(Icons.save))
            ],
          ),
          body: TabBarView(children: _addEquipScreens),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.reactCircle,
            backgroundColor: Theme.of(context).appBarTheme.color,
            items: [
              TabItem(icon: Icons.insert_chart, title: 'Quantitativos'),
              TabItem(icon: Icons.edit, title: 'Qualitativos'),
            ],
          ),
        ),
      ),
    );
  }
}
