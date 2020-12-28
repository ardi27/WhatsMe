import 'package:whatsme/domain/repositories/firbase_repository.dart';
class IsSignInUseCase{
  final FirebaseRepository repository;
  IsSignInUseCase({this.repository});

  Future<bool> call() async {
    return await repository.isSignIn();
  }
}