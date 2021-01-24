import 'package:assunta/classes/user_class.dart';
import 'package:assunta/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  /*Stream User*/
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebase);
  }

  /*Sign in Anon*/
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e){
      print(e.toString());
      return null;
    }

  }


  /*Sign in w email*/
  Future signInWithEmail(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fireUser = result.user;


      return _userFromFirebase(fireUser);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  /*register*/
  Future registerWithEmail(String name, String surname, String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser fireUser = result.user;
      await DatabaseService(uid: fireUser.uid).updateUserData(name, surname);

      return _userFromFirebase(fireUser);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  /*log out*/
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;

    }
  }



}