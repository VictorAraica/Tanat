part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginInitialLoading extends LoginState {}

final class LoginInitialLoaded extends LoginState {
  final bool haveBiometrics;

  LoginInitialLoaded({required this.haveBiometrics});
}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  LoginSuccess({required this.user, required this.token});

  final UserApp user;
  final String token;
}

final class LoginSuccessWithBiometrics extends LoginState {
  LoginSuccessWithBiometrics({required this.user, required this.token});

  final UserApp user;
  final String token;
}

final class LoginFailure extends LoginState {
  final String error;
  final bool isFromBiometrics;

  LoginFailure(this.error, {this.isFromBiometrics = false});
}

final class LoginUserNotVerified extends LoginState {
  final String account;

  LoginUserNotVerified(this.account);
}
