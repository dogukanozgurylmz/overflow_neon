part of 'signin_cubit.dart';

enum SignInStatus {
  init,
  loading,
  success,
  fail,
}

class SigninState extends Equatable {
  final SignInStatus status;
  final bool isSignIn;

  const SigninState({
    required this.status,
    required this.isSignIn,
  });

  SigninState copyWith({
    SignInStatus? status,
    bool? isSignIn,
  }) {
    return SigninState(
      status: status ?? this.status,
      isSignIn: isSignIn ?? this.isSignIn,
    );
  }

  @override
  List<Object> get props => [
        status,
        isSignIn,
      ];
}
