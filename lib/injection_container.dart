import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsme/data/datasource/firebase_remote_datasource.dart';
import 'package:whatsme/data/datasource/firebase_remote_datasource_impl.dart';
import 'package:whatsme/data/repositories/firebase_repository_impl.dart';
import 'package:whatsme/domain/repositories/firbase_repository.dart';
import 'package:whatsme/domain/usecases/get_create_current_user_use_case.dart';
import 'package:whatsme/domain/usecases/get_current_uid_use_case.dart';
import 'package:whatsme/domain/usecases/is_sign_in_use_case.dart';
import 'package:whatsme/domain/usecases/sign_in_with_phone_number_use_case.dart';
import 'package:whatsme/domain/usecases/sign_out_use_case.dart';
import 'package:whatsme/domain/usecases/verifi_phone_number_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //future bloc

  //use case
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(() => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(() => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInWithPhoneNumberUseCase>(() => SignInWithPhoneNumberUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<VerifyPhoneNumberUseCase>(() => VerifyPhoneNumberUseCase(repository: sl.call()));
  //repository
  sl.registerLazySingleton<FirebaseRepository>(() => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //remote data
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(
      auth: sl.call(),
      firestore: sl.call(),
    ),
  );

  //external

  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
