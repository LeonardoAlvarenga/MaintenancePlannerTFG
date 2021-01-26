import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './change_password_or_email.dart';
import '../app_drawer.dart';
import 'package:tfg_app/providers/services/auth.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const routeName = '/account-settings-screen';
  final _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    final userFb = Provider.of<UserFb>(context, listen: false);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Configurações da Conta'),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              if (userFb.profilePictureUrl != null)
                CircleAvatar(
                  backgroundImage: NetworkImage(userFb.profilePictureUrl),
                ),
              if (userFb.profilePictureUrl == null)
                CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      AssetImage('assets/images/profile_pic_null.png'),
                ),
              SizedBox(height: 20),
              if (userFb.email != null)
                Text(
                  userFb.email,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              SizedBox(height: 60),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ChangePassOrEmail(PassOrEmail.Email);
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.mail),
                    label: Text('Alterar Email')),
              ),
              SizedBox(height: 40),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) {
                            return ChangePassOrEmail(PassOrEmail.Pass);
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Alterar Senha')),
              ),
              SizedBox(height: 40),
              Container(
                height: 50,
                width: 200,
                child: RaisedButton.icon(
                    color: Colors.red[800],
                    onPressed: () async {
                      final response = await showDialog(
                        context: context,
                        child: AlertDialog(
                          title: Text('CUIDADO!'),
                          content: Text(
                            'Esse Processo é permanente. Você tem certeza que deseja apagar a sua conta? Todos os seus dados serão perdidos e o processo NÃO pode ser revertido.',
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              color: Colors.red,
                              child: Text('Apagar a conta'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(null);
                              },
                              color: Colors.green,
                              child: Text('NÃO apagar a conta'),
                            ),
                          ],
                        ),
                      );
                      if (response != null) {
                        try {
                          await _authServices.deleteUser();
                          Navigator.of(context).pushReplacementNamed('/');
                        } catch (error) {
                          await showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text('Erro'),
                              content: Text(error.toString()),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    },
                    icon: Icon(Icons.delete_forever),
                    label: Text('Apagar Conta')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
