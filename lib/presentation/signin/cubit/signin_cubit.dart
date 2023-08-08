import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neon_overflow/data/model/user_model.dart';
import 'package:neon_overflow/data/repository/auth_repository.dart';
import 'package:neon_overflow/data/repository/user_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const SigninState(
          status: SignInStatus.init,
          isSignIn: false,
        ));
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    await _authRepository.signInWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    emit(state.copyWith(isSignIn: true));
  }

  Future<bool> hasUserId() async {
    var result =
        await _userRepository.hasUser(_authRepository.currentUser!.uid);
    return result;
  }

  Future<void> createUser() async {
    var userModel = UserModel(
      id: _authRepository.currentUser!.uid,
      imageUrl: _authRepository.currentUser!.photoURL ?? "",
      createdAt: DateTime.now(),
      firstname: _authRepository.currentUser!.displayName ?? "",
      lastname: "",
      email: emailController.text.trim(),
    );
    await _userRepository.create(userModel);
  }

  Future<void> submit() async {
    emit(state.copyWith(status: SignInStatus.loading));
    await signInWithEmailAndPassword();
    var result = await hasUserId();
    if (!result) {
      await createUser();
    }
    emit(state.copyWith(status: SignInStatus.success));
  }
}
