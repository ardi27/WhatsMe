import 'package:whatsme/domain/entities/user_entity.dart';
import 'package:whatsme/domain/repositories/firbase_repository.dart';
class GetCurrentUserUseCase{
  final FirebaseRepository repository;
  GetCurrentUserUseCase(this.repository);

  Future<void> call(UserEntity user) async {
    return await repository.getCreateCurrentUser(user);
  }
}