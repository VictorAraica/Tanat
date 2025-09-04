import 'package:bloc/bloc.dart';
import 'package:tanat/auth/domain/auth_repository.dart';
import 'package:tanat/models/user_app.dart';
import 'package:tanat/service_locator.dart';
import 'package:tanat/utils/local_auth_service.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit([AuthRepository? authRepository])
    : authRepository = authRepository ?? AuthRepository(),
      super(LoginInitial());

  final AuthRepository authRepository;

  void login(String user, String password) async {
    emit(LoginLoading());
    try {
      final (UserApp loggedUser, String token) = await authRepository.login(
        user,
        password,
      );
      emit(LoginSuccess(user: loggedUser, token: token));
    } catch (e) {
      _handleLoginErrors(e);
    }
  }

  void loginWithBiometrics() async {
    bool popFromLoading = false;
    try {
      final successAuth =
          await serviceLocator<LocalAuthService>().authenticate();
      if (!successAuth) {
        // emit(LoginFailure('Error al autenticar con biometría'));
        return;
      }
      emit(LoginLoading());
      popFromLoading = true;
      final (UserApp loggedUser, String token) =
          await authRepository.loginWithBiometrics();
      emit(LoginSuccessWithBiometrics(user: loggedUser, token: token));
    } catch (e) {
      _handleLoginErrors(e, isFromBiometrics: !popFromLoading);
    }
  }

  void checkIfUserHaveBiometrics() async {
    emit(LoginInitialLoading());
    final bool supportedBiometrics =
        await serviceLocator<LocalAuthService>().haveBiometrics();
    final bool haveBiometrics = await authRepository.userHasEnableBioAuth();
    emit(
      LoginInitialLoaded(haveBiometrics: supportedBiometrics && haveBiometrics),
    );
  }

  void _handleLoginErrors(dynamic e, {bool isFromBiometrics = false}) {
    emit(LoginFailure(e.toString(), isFromBiometrics: isFromBiometrics));
  }
}
