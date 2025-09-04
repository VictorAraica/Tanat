import 'package:tanat/utils/standar_exception_class.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';

class LocalAuthService {
  LocalAuthService._(this.auth);

  factory LocalAuthService() {
    return LocalAuthService._(LocalAuthentication());
  }

  final LocalAuthentication auth;

  final AuthenticationOptions options = const AuthenticationOptions(
    useErrorDialogs: true,
    stickyAuth: true,
    biometricOnly: false,
    sensitiveTransaction: false,
  );

  bool deviceSupportsBiometrics = false;
  bool deviceSupportsOtherThanBiometrics = false;

  bool get supportAuthsMethods =>
      deviceSupportsBiometrics || deviceSupportsOtherThanBiometrics;

  Future<void> init() async {
    deviceSupportsBiometrics = await auth.canCheckBiometrics;
    deviceSupportsOtherThanBiometrics = await auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      if (!(await haveBiometrics())) {
        throw const StandardException(
          'No tienes configurado ningún método de autenticación en tu dispositivo\nConfigura uno para continuar',
        );
      }

      return await auth.authenticate(
        authMessages: [
          const IOSAuthMessages(cancelButton: 'Cancelar'),
          const AndroidAuthMessages(
            cancelButton: "Cancelar",
            biometricRequiredTitle: "Autenticación requerida",
            signInTitle: "Verificación de identidad",
          ),
        ],
        localizedReason: 'Por favor, autentícate para continuar',
        options: options,
      );
    } on PlatformException catch (e) {
      if (e.code == passcodeNotSet) {
        throw const StandardException(
          'Configura un PIN o patrón en tu dispositivo para continuar',
        );
      }
      throw const StandardException('Error al autenticar');
    }
  }

  Future<bool> haveBiometrics() async {
    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    final bool hasBiometrics = await auth.isDeviceSupported();

    return canCheckBiometrics && hasBiometrics;
  }
}
