import 'package:whatsme/domain/repositories/firbase_repository.dart';
class SignInWithPhoneNumberUseCase{
  final FirebaseRepository repository;

  SignInWithPhoneNumberUseCase({this.repository});
  Future<void> call(String smsPinCode) async {
    return await repository.SignInWithPhoneNumber(smsPinCode);
  }
}