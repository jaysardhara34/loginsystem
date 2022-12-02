import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _signIn = GoogleSignIn();

Future<String> Createac(String em, String pw) async {
  try {
    await _auth.createUserWithEmailAndPassword(email: em, password: pw);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == "weak-password") {
      return "Password atleast 6 Char";
    } else if (e.code == "email-already-in-use") {
      return "Email already Exist";
    }
  }
  return "not_found";
}

Future<String> Loginep(String em, String pw) async {
  try {
    await _auth.signInWithEmailAndPassword(email: em, password: pw);
    return "Success";
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      return "No User Data Found";
    } else if (e.code == 'wrong-password') {
      return '!! Wrong password !!';
    }
  }
  return "not_found";
}

bool checkUser() {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return true;
  }
  return false;
}

void logout() {
  _auth.signOut();
  _signIn.signOut();
}

Future<bool> googlelogin() async {
  GoogleSignInAccount? account = await _signIn.signIn();
  GoogleSignInAuthentication? authentication = await account?.authentication;
  var cred = GoogleAuthProvider.credential(
      accessToken: authentication!.accessToken,
      idToken: authentication.idToken);
  await _auth
      .signInWithCredential(cred)
      .then((value) => print("Success"))
      .catchError((e) => print(e));

  return checkUser();
}

Future<List> userprofile() async {
  User? user = await _auth.currentUser;
  return [user!.email, user.displayName, user.photoURL];
}
