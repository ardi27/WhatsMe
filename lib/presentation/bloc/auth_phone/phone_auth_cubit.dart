import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsme/domain/entities/user_entity.dart';
import 'package:whatsme/domain/usecases/get_create_current_user_use_case.dart';
import 'package:whatsme/domain/usecases/sign_in_with_phone_number_use_case.dart';
import 'package:whatsme/domain/usecases/verifi_phone_number_use_case.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  PhoneAuthCubit({
    this.signInWithPhoneNumberUseCase,
    this.verifyPhoneNumberUseCase,
    this.getCreateCurrentUserUseCase,
  }) : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber(String phoneNumber) async {
    emit(PhoneAuthLoading());
    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthInitial());
    } catch (_) {
      emit(PhoneAuthInitial());
    }
  }

  Future<void> submitSmsCode(String smsCode) async {
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthInitial());
    } catch (_) {
      emit(PhoneAuthInitial());
    }
  }

  Future<void> submitProfileInfo(
      {String name, String profileUrl, String phoneNumber}) async {
    try {
      await getCreateCurrentUserUseCase.call(UserEntity(
        uid: "",
        name: name,
        email: "",
        phoneNumber: phoneNumber,
        isOnline: true,
        profileUrl: profileUrl,
      ));
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthInitial());
    } catch (_) {
      emit(PhoneAuthInitial());
    }
  }
}
