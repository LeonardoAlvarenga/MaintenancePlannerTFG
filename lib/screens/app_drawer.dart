import 'package:flutter/material.dart';

import './auth/account_settings_screen.dart';
import '../providers/services/auth.dart';

class AppDrawer extends StatelessWidget {
  final _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Menu'),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
              leading: Icon(
                Icons.home,
                size: 35,
              ),
              title: Text(
                'Menu Principal',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[800],
                ),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AccountSettingsScreen.routeName);
              },
              leading: Icon(
                Icons.settings,
                size: 35,
              ),
              title: Text(
                'Configurações da Conta',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[800],
                ),
              ),
            ),
            Divider(),
            ListTile(
              onTap: () async {
                try {
                  Navigator.of(context).pop();
                  await _authServices.signOut();
                  Navigator.of(context).pushReplacementNamed('/');
                } catch (error) {
                  await showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Error'),
                      content: Text('Algo deu errado...'),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        )
                      ],
                    ),
                  );
                }
              },
              leading: Icon(
                Icons.exit_to_app,
                size: 35,
              ),
              title: Text(
                'Sair',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.teal[800],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
