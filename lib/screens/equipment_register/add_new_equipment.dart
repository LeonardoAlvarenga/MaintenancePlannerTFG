import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'package:tfg_app/providers/new_equipment_provider.dart';
import 'package:tfg_app/screens/equipment_register/add_edit_quantitative_screens/quantitatives_screen.dart';
import 'package:tfg_app/screens/equipment_register/add_edit_qualitative_screens/qualitatives_screen.dart';
import 'package:tfg_app/screens/equipment_register/general_form_screen.dart';

/* 
  Tela de Registro de Novo Equipamento
  Ela fará o gerenciamento dos Widgets(Screens) que estarão sendo exibidos na tela...
  Serão 3 Screens:
    - Geral
    - Quantitativos
    - Qualitativos

  Geral trata de dados gerais do equipamento. Formulário simples e fixo quanto à quantidade de atributos.
  
  As duas outras páginas tratam do plano de manutenção em si, estes devem ser mais flexíveis...
  Entretanto, no caso do Quantitativo, teremos limitações nas unidades de medidas que serão adotadas...
  
  Precisarei exibir, para o Engenheiro, a lista de unidades disponíveis para serem utilizadas. 
  E, de acordo com o escolhido, mostrar uma determinada saída de valor na tela...
 */

class AddNewEquipmentScreen extends StatelessWidget {
  static const routeName = '/add-new-equipment-screen';
  final AppBar _appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    double disponibleHeight =
        MediaQuery.of(context).size.height - _appBar.preferredSize.height - 60;
    final generalForm = GeneralFormScreen(disponibleHeight);

    final List<Widget> _addEquipScreens = [
      generalForm,
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
        length: 3,
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
              TabItem(icon: Icons.list, title: 'Geral'),
              TabItem(icon: Icons.insert_chart, title: 'Quantitativos'),
              TabItem(icon: Icons.edit, title: 'Qualitativos'),
            ],
          ),
        ),
      ),
    );
  }
}
