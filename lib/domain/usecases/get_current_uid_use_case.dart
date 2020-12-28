import 'package:whatsme/domain/repositories/firbase_repository.dart';
class GetCurrentUidUseCase{
  final FirebaseRepository repository;
  GetCurrentUidUseCase(this.repository);

  Future<String> call() async {
    return await repository.getCurrentUID();
  }
}