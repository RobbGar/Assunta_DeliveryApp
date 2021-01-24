import 'package:flutter/material.dart';

class OrderFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Grazie Per aver effettuato un ordine!"),
          Text("Troverai gli aggiornamenti sul tuo ordine nella pagina profilo dell'app"),
          RaisedButton(
            color: Theme.of(context).buttonColor,
            child: Text("Torna alla Home"),
            onPressed: (){
              Navigator.popAndPushNamed(context, '/home');
            },
          )
        ],
      ),
    );
  }
}
