part of 'user_session_cubit.dart';

@immutable
sealed class UserSessionState {}

final class UserSessionInitial extends UserSessionState {}

final class UserSessionLoading extends UserSessionState {}

final class UserAuthenticated extends UserSessionState {}

final class UserUnauthenticated extends UserSessionState {
  UserUnauthenticated({
    this.skipOnBoarding = false,
    this.loginView = false,
  });

  final bool skipOnBoarding;
  final bool loginView;
}
