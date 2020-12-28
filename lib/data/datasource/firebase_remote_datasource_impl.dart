import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:whatsme/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsme/data/model/user_model.dart';
import 'package:whatsme/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl extends FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({this.auth, this.firestore});

  String _verificationId = "";

  @override
  Future<void> SignInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection=firestore.collection("users");
    final uid=await getCurrentUID();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        status: user.status,
        profileUrl: user.profileUrl,
        isOnline: user.isOnline,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser.uid != null;

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber)async {
    final PhoneVerificationCompleted phoneVerificationCompleted = (
        AuthCredential authCredential) {
      print("phone verified : Token ${authCredential.token}");
    };
    final PhoneVerificationFailed phoneVerificationFailed = (
        FirebaseAuthException firebaseAuthException) {
      print("phone failed : ${firebaseAuthException
          .message},${firebaseAuthException.code}");
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout = (
        String verificationId) {
      this._verificationId = verificationId;
      print("timeout :$_verificationId");
    };
    final PhoneCodeSent phoneCodeSent=(String verificationId,int forceResendingToken){

    };
     await auth.verifyPhoneNumber(phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 10),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,);
  }
}
