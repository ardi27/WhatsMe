import 'package:whatsme/domain/repositories/firbase_repository.dart';
class SignOutUseCase{
  final FirebaseRepository repository;
  SignOutUseCase(this.repository);

  Future<void> call() async {
    return await repository.signOut();
  }
}