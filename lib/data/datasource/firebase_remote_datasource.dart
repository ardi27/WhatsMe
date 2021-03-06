import 'package:whatsme/domain/entities/user_entity.dart';
abstract class FirebaseRemoteDataSource{
  Future<void> verifyPhoneNumber(String phoneNumber);
  Future<void> SignInWithPhoneNumber(String smsPinCode);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUID();
  Future<void> getCreateCurrentUser(UserEntity user);
}