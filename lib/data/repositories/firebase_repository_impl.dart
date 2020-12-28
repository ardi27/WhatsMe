import 'package:whatsme/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsme/domain/entities/user_entity.dart';
import 'package:whatsme/domain/repositories/firbase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository{
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({this.remoteDataSource});

  @override
  Future<void> SignInWithPhoneNumber(String smsPinCode) async=>await remoteDataSource.SignInWithPhoneNumber(smsPinCode);

  @override
  Future<void> getCreateCurrentUser(UserEntity user)async => await remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUID() async=>await remoteDataSource.getCurrentUID();

  @override
  Future<bool> isSignIn() async=>await remoteDataSource.isSignIn();

  @override
  Future<void> signOut() async=>await remoteDataSource.signOut();

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async=>await remoteDataSource.verifyPhoneNumber(phoneNumber);

}