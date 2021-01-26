/*
  # Authentication Screen

  O primeiro widget gerencia o state que deve ser mostrado na tela, variando entre "Entrar" e "Cadastrar".
  Em seguida, temos o SignInForm Widget, onde seu formulário é utilizado para tentativa de login no Firebase...
   Mais abaixo, temos o SignUpForm Widget, onde temos um formulário para entrada de dados para tentativas de novos cadastros no Firebase...
*/

import 'package:flutter/material.dart';

import 'package:tfg_app/providers/services/auth.dart';
import 'package:tfg_app/widgets/main_planner_logo.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _showSignUp = false;
  var _isLoading = false;

  void _signUp() {
    setState(() {
      _showSignUp = true;
    });
  }

  void _signIn() {
    setState(() {
      _showSignUp = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQCtx = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        height: mQCtx.size.height,
        width: mQCtx.size.width,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/vale_logo_4k.png',
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 40,
              right: 0,
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  InkWell(
                    onTap: _signUp,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: .1,
                            offset: Offset(
                              1.0,
                              1.0,
                            ), // shadow direction: bottom right
                          )
                        ],
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(15)),
                        color: _showSignUp
                            ? Colors.amber.withOpacity(.9)
                            : Colors.teal[800].withOpacity(.9),
                      ),
                      child: Center(
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  InkWell(
                    onTap: _signIn,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: .1,
                            offset: Offset(
                              1.0,
                              1.0,
                            ),
                          )
                        ],
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(15)),
                        color: _showSignUp
                            ? Colors.teal[800].withOpacity(.9)
                            : Colors.amber.withOpacity(.9),
                      ),
                      child: Center(
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 100,
//
// SignIn/SignUp widgets call
//
              child: _isLoading
                  ? Container(
                      height: mQCtx.size.height * .4,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.teal[900],
                              ),
                            ),
                            SizedBox(height: 15),
                            Text('Realizando Acesso...'),
                          ],
                        ),
                      ),
                    )
                  : _showSignUp ? SignUpForm() : SignInForm(),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: Container(
                height: mQCtx.size.height * 0.1,
                child: FittedBox(
                  child: MainPlannerLogo(
                    fontFamilyString: 'Audiowide',
                    secundaryColor: Colors.teal[900],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*


  SignIn Form


*/

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _authServices = AuthServices();
  final GlobalKey<FormState> _signInFormKey = GlobalKey();

  String email = '';
  String password = '';

  var _isTryingToSignIn = false;
  var _hidePassword = true;
  double sizedBoxHeight = 5;

  Future<void> _trySignIn() async {
    if (_signInFormKey.currentState.validate()) {
      setState(() {
        _isTryingToSignIn = true;
      });
      try {
        await _authServices.signInWithEmailAndPassword(email, password);
      } catch (error) {
        setState(() {
          _isTryingToSignIn = false;
        });
        showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Erro'),
            content: Text(error.toString()),
            actions: [
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
    } else
      setState(() {
        sizedBoxHeight = 10;
      });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return _isTryingToSignIn
        ? Center(
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.teal[900],
                ),
              ),
              height: 40,
              width: 40,
            ),
          )
        : Form(
            key: _signInFormKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == '') {
                          return 'Campo Vazio.';
                        } else if (!value.contains('@')) {
                          return 'Informe um email válido.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == '') {
                          return 'Campo Vazio.';
                        } else if (value.length < 6) {
                          return 'Senhas possuem, no mínimo, 6 dígitos.';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            }),
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _trySignIn();
                    },
                    child: Text('Entrar'),
                  )
                ],
              ),
            ),
          );
  }
}

/*


  SignUp Form


*/

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _authServices = AuthServices();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

  String email = '';
  String password = '';
  String confirmPassword = '';

  var _isTryingToSignUp = false;
  var _hidePassword = true;
  double sizedBoxHeight = 5;

  Future<void> _trySignUp() async {
    if (_signUpFormKey.currentState.validate()) {
      setState(() {
        _isTryingToSignUp = true;
      });
      try {
        final result =
            await _authServices.registerWithEmailAndPassword(email, password);
        print(result.uid);
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
              )
            ],
          ),
        );
        setState(() {
          _isTryingToSignUp = false;
        });
      }
    } else
      setState(() {
        sizedBoxHeight = 10;
      });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return _isTryingToSignUp
        ? Center(
            child: Container(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.teal[900],
                ),
              ),
              height: 40,
              width: 40,
            ),
          )
        : Form(
            key: _signUpFormKey,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Campo Vazio.';
                        } else if (!value.contains('@')) {
                          return 'Informe um email válido.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Campo Vazio.';
                        } else if (value.length < 6) {
                          return 'Sua senha deve ter, ao menos, 6 dígitos.';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            }),
                        labelText: 'Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Container(
                    child: TextFormField(
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      validator: (value) {
                        if (value == '') {
                          return 'Campo Vazio.';
                        } else if (value != password) {
                          return 'As senhas informadas não são iguais.';
                        } else {
                          return null;
                        }
                      },
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            }),
                        labelText: 'Confirmar Senha',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      _trySignUp();
                    },
                    child: Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          );
  }
}
