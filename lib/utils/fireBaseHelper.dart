import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _signIn = GoogleSignIn();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

Future<String> Createac(String em, String pw, String nm) async {
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

Future<String> Loginep(String em, String pw, String nm) async {
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

void insertdata(String id, String name, String mobile, String std) {
  CollectionReference collectionReference =
      firebaseFirestore.collection("Student");

  collectionReference
      .add({
        "id": "$id",
        "name": "$name",
        "mobile": "$mobile",
        "std": "$std",
      })
      .then((value) => print("success"))
      .catchError((error) => print("Error $error"));
}

Stream<QuerySnapshot<Map<String, dynamic>>> readdata() {
  return firebaseFirestore.collection("Student").snapshots();
}

void deleteData(String key) {
  firebaseFirestore.collection("Student").doc("$key").delete();
}

void updateData(String key, String id, String name, String mobile, String std) {
  firebaseFirestore.collection("Student").doc("$key").set({
    "id": "$id",
    "name": "$name",
    "mobile": "$mobile",
    "std": "$std",
  });
}
