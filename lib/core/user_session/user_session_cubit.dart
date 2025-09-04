import 'dart:async';

import 'package:tanat/auth/domain/auth_repository.dart';
import 'package:tanat/models/user_app.dart';
import 'package:tanat/utils/constants.dart';
import 'package:tanat/utils/dio_helper.dart';
import 'package:tanat/utils/log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_session_state.dart';

class UserSessionCubit extends Cubit<UserSessionState> {
  UserSessionCubit() : super(UserSessionInitial());

  final AuthRepository authRepository = AuthRepository();

  UserApp? _activeUser;
  String? _userToken;

  UserApp get getUserData => _activeUser!;

  String get userToken => _userToken!;

  Future<void> initialize() async {
    // check if session is still active
    final (user, token) = await authRepository.getCurrentUser();
    if (user == null || token == null) {
      final bool userHasEnableBioAuth =
          await authRepository.userHasEnableBioAuth();
      emit(UserUnauthenticated(loginView: userHasEnableBioAuth));
    } else {
      _initUserData(user, token);
      emit(UserAuthenticated());
    }
  }

  Future<void> refreshUserData() async {
    final (user, token) = await authRepository.getCurrentUser();
    _activeUser = user;
  }

  Future<void> authenticate(UserApp user, String token) async {
    _initUserData(user, token);
    emit(UserAuthenticated());
  }

  Future<void> logOut({bool deleteAllData = false}) async {
    _activeUser = null;
    _userToken = null;
    dioServiceInstance.removeUserDataFromHeaders();
    await authRepository.clearUserData(deleteAllData: deleteAllData);
    emit(UserUnauthenticated(skipOnBoarding: true));
  }

  void _initUserData(UserApp user, String token) {
    _activeUser = user;
    _userToken = token;
    /*FirebaseAnalytics.instance.setUserId(id: user.id!);
    FirebaseCrashlytics.instance.setUserIdentifier(user.id!);*/
    dioServiceInstance.addUserDataToHeaders(token);
    handleUserActivityTimer();
  }

  Timer? _inactivityTimer;
  final Duration _inactivityDuration = const Duration(
    minutes: maxInactivityDuration,
  );

  void handleUserActivityTimer() {
    if (_activeUser == null) return;
    LogUtils.logDebug('timer changed');
    _inactivityTimer?.cancel(); // Cancel any existing timer
    _inactivityTimer = Timer(_inactivityDuration, () {
      LogUtils.logDebug('calling timer logOut');
      logOut();
    }); // Start a new timer
  }

  @override
  Future<void> close() {
    _inactivityTimer?.cancel();
    return super.close();
  }
}
