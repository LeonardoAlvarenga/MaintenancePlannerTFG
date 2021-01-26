import 'package:flutter/material.dart';

import 'package:tfg_app/providers/services/auth.dart';

enum PassOrEmail {
  Pass,
  Email,
}

class ChangePassOrEmail extends StatefulWidget {
  static const routeName = '/change-pass-or-email';

  final PassOrEmail selected;
  ChangePassOrEmail(
    this.selected,
  );
  @override
  _ChangePassOrEmailState createState() => _ChangePassOrEmailState();
}

class _ChangePassOrEmailState extends State<ChangePassOrEmail> {
  final _authServices = AuthServices();
  bool _isEmail = true;
  bool _obscureText = false;
  bool _isLoading = false;
  final _formStateKey = GlobalKey<FormState>();

  String firstNew = '';
  String secondNew = '';

  @override
  void initState() {
    if (widget.selected == PassOrEmail.Pass) {
      _isEmail = false;
      _obscureText = true;
    } else {
      _isEmail = true;
      _obscureText = false;
    }
    super.initState();
  }

  Future<void> _tryToChangeUserInfo() async {
    if (_formStateKey.currentState.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        if (_isEmail) {
          await _authServices.updateEmail(firstNew);
        } else {
          await _authServices.updatePassword(firstNew);
        }
        setState(() {
          _isLoading = false;
        });
        await showDialog(
          context: context,
          child: AlertDialog(
            content: Text(
              'Alteração realizada com sucesso!',
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
        Navigator.of(context).pop();
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Erro'),
            content: Text(
              error.toString(),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEmail ? 'Alterar Email' : 'Alterar Senha')),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formStateKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 10, right: 30, left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Center(
                  child: Text(
                    'É necessário ter realizado login há pouco tempo para realizar esta operação!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (!_isEmail)
                Container(
                  child: Text(
                    'Sua senha deve ter pelo menos 6 dígitos.',
                  ),
                ),
              SizedBox(height: 25),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Campo Vazio.';
                  }
                  if (_isEmail) {
                    if (!value.contains('@')) {
                      return 'Informe um email válido.';
                    } else {
                      return null;
                    }
                  } else {
                    if (value.length < 6) {
                      return 'Senhas possuem, no mínimo, 6 dígitos.';
                    } else {
                      return null;
                    }
                  }
                },
                obscureText: _obscureText,
                onChanged: (value) => firstNew = value,
                decoration: InputDecoration(
                  prefixIcon: _isEmail ? Icon(Icons.mail) : Icon(Icons.lock),
                  suffixIcon: _isEmail
                      ? null
                      : IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                  border: OutlineInputBorder(),
                  labelText: _isEmail ? 'Novo Email' : 'Nova Senha',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return 'Campo Vazio.';
                  } else if (value != firstNew) {
                    return 'Dados informados não são idênticos.';
                  }
                  return null;
                },
                obscureText: _obscureText,
                onChanged: (value) => firstNew = value,
                decoration: InputDecoration(
                  prefixIcon: _isEmail
                      ? Icon(Icons.mail_outline)
                      : Icon(Icons.lock_outline),
                  suffixIcon: _isEmail
                      ? null
                      : IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                  border: OutlineInputBorder(),
                  labelText: _isEmail
                      ? 'Confirmar Novo Email'
                      : 'Confirmar Nova Senha',
                ),
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      onPressed: _tryToChangeUserInfo,
                      child: Text('Confirmar'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
