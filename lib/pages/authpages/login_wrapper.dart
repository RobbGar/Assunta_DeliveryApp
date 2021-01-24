import 'package:assunta/classes/user_class.dart';
import 'package:assunta/pages/authpages/login_page.dart';
import 'package:assunta/pages/homepage/home_page_main.dart';
import 'package:assunta/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    if (user == null)
      return LoginPage();
    else{
      loadUserData(context);
      return HomePage();
    }
  }
}

void loadUserData(BuildContext context) async{
  var user = Provider.of<User>(context);
  try {
    var db = DatabaseService(uid: user.uid).userData;
    dynamic data = await db.then((value) => value.data);

    user.name = data['name'];
    user.surname = data['surname'];
  }
  catch(e){

  }


}


