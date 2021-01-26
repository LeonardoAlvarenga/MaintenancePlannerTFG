import 'package:flutter/material.dart';

import './plano_de_manutencao_screen.dart';
import '../models/register_option.dart';
import '../widgets/textfield_custom.dart';

class RegisterEquipmentScreen extends StatelessWidget {
  static const routeName = '/register-equipment-screen';

  final List<RegisterOption> registerOptions = [
    RegisterOption(id: 're1', optionName: 'Nome do Equipamento'),
    RegisterOption(id: 're2', optionName: 'Localização'),
    RegisterOption(id: 're3', optionName: 'Conjunto/Sistema'),
    RegisterOption(id: 're4', optionName: 'Subconjunto/Subsistema'),
    RegisterOption(id: 're5', optionName: 'Componente'),
    RegisterOption(id: 're6', optionName: 'Início do Funcionamento'),
    RegisterOption(id: 're7', optionName: 'Criticidade (1 à 5)'),
  ];

  void maintenancePlanScreen(BuildContext context) {
    Navigator.of(context).pushNamed(
      MaintenancePlanScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Equipamento'),
      ),
      body: ListView(
        padding: EdgeInsets.only(right: 10, left: 10, top: 10),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.amberAccent[400],
                  Colors.amberAccent[400],
                  Colors.amberAccent[700],
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: registerOptions.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            labelText: registerOptions[index].optionName,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                RaisedButton.icon(
                  color: Colors.teal[900],
                  textColor: Colors.white,
                  onPressed: () => maintenancePlanScreen(context),
                  icon: Icon(Icons.add),
                  label: Text('Adicionar Plano de Manutenção'),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Text('Salvar'),
        icon: Icon(Icons.save_alt),
      ),
    );
  }
}
