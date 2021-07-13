import 'package:assunta/pages/authpages/login_wrapper.dart';
import 'package:assunta/pages/homepage/home_page_main.dart';
import 'package:assunta/pages/orderpage/order_finished.dart';
import 'package:assunta/classes/food_class.dart';
import 'package:assunta/pages/authpages/login_page.dart';
import 'package:assunta/pages/authpages/signup_page.dart';
import 'package:assunta/services/auth.dart';
import 'package:assunta/services/database.dart';
import 'package:provider/provider.dart';
import 'classes/cart_class.dart';
import 'classes/user_class.dart';
import 'package:flutter/material.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                Cart()
        ),
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        StreamProvider<List<Food>>.value(
          value: DatabaseService().foodData,
          catchError: (e,ee) { print(e.toString()); print(ee.toString()); return null;},
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: "Montserrat",
            primaryColor: Color(0xffffc700),
            primaryColorLight: Color(0xffffff8b),
            primaryColorDark: Color(0xffc9bc1f),
            backgroundColor: Color(0xffECE9DE),
            buttonColor: Color(0xffffc700),
            accentColor: Color(0xff1565c0)
          //scaffoldBackgroundColor: Color(0xffECE9DE)
        ),
        initialRoute: '/wrapper',
        routes: {
          '/finished' : (context) => OrderFinished(),
          '/register': (context) => SignUpPage(),
          '/wrapper': (context) => Wrapper(),
          '/intro': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    ),
  );
}