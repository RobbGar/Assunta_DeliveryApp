import 'package:assunta/pages/authpages/waves.dart';
import 'package:assunta/pages/authpages/loading_page.dart';
import 'package:assunta/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as validator;


class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final pswController = TextEditingController();
  bool loading = false;
  String _errorString = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Center(
              child: Text(
                "Registrati",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
            SizedBox(height: 20,),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text("Nome"),

                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder()
                      ),
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci il nome';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20,),
                    Text("Cognome"),

                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Cognome",
                          border: OutlineInputBorder()
                      ),
                      controller: surnameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci il cognome';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 20,),
                    Text("Email"),

                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder()
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci la mail';
                        }
                        else if (!validator.isEmail(value)){
                          return 'Inserisci una Mail valida';
                        }
                        return null;
                      },

                    ),

                    SizedBox(height: 20,),
                    Text("Password"),

                    SizedBox(height: 5,),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder()
                      ),
                      obscureText: true,
                      controller: pswController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci la password';
                        }
                        if(value.length < 6) return 'La password deve essere lunga almeno 6 caratteri';
                        return null;
                      },

                    ),
                    SizedBox(height: 10,),
                    FlatButton(
                      color: Theme.of(context).buttonColor,
                      child: Text("Registrati"),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmail(nameController.text, surnameController.text, emailController.text, pswController.text);

                          if (result == null) {
                            setState(() {
                              loading = false;
                              _errorString = 'Errore nella registrazione, Riprovare';
                            });
                          }
                          else{
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                    Text(_errorString, style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            ),
            CustomWaves(),


          ],
        ),
      ),
    );
  }
}
