import 'file:///C:/Users/Roberto/flutter_projects/assunta/lib/pages/authpages/loading_page.dart';
import 'package:assunta/services/auth.dart';
import 'package:flutter/material.dart';
import 'waves.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  bool loading = false;
  String _errorString = '';
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sagra di Santa Maria del Campo",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 20,),
                    Text("Email"),
                    SizedBox(height: 3,),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'email'
                      ),
                      controller: firstController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci la mail';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Text("Password"),
                    SizedBox(height: 3,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'password'
                      ),
                      controller: secondController,
                      obscureText: true,
                      autocorrect: false,
                      textAlign: TextAlign.justify,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci la Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    Text(
                      _errorString,
                      style: TextStyle(
                          color: Colors.red
                      ),
                    ),

                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      child:Text("Accedi"),
                      onPressed: () async {
                        if (_formKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.signInWithEmail(firstController.text, secondController.text);
                          if (result == null){
                            setState(() {
                              loading = false;
                              _errorString = 'Email o Password errati';
                            });
                          }


                        }
                      },
                    ),
                    SizedBox(height: 10),

                    InkWell(
                      child: Text(
                          "Non hai un Account? Registrati",
                        style: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                  ],
                ),
              ),
            ),
            CustomWaves()
          ],
        ),
      ),
    );
  }
}



