import 'dart:async';
import 'package:tanat/auth/initial_view.dart';
// import 'package:tanat/auth/login/login_view.dart';
import 'package:tanat/core/user_session/user_session_cubit.dart';
// import 'package:tanat/home/home_view_with_session_handler.dart';
import 'package:tanat/service_locator.dart';
import 'package:tanat/utils/dio_helper.dart';
import 'package:tanat/utils/navigations.dart';
import 'package:tanat/utils/navigator_global_key.dart';
import 'package:tanat/utils/styles_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await initAppServices();
  runApp(const MyApp());
}

Future<void> initAppServices() async {
  await setupServiceLocator();
  await initDioService();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final UserSessionCubit _userSessionCubit;

  @override
  void initState() {
    super.initState();
    _userSessionCubit = UserSessionCubit();
    WidgetsBinding.instance.addPostFrameCallback((_) => _setOrientation());
  }

  void _setOrientation() {
    if (!isTablet(context)) {
      // Permite la orientación vertical para teléfonos
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  bool isTablet(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return width >= 600;
  }

  @override
  void dispose() {
    _userSessionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _userSessionCubit..initialize()),
      ],
      child: Listener(
        onPointerDown: (_) {
          _userSessionCubit.handleUserActivityTimer();
        },
        child: MaterialApp(
          navigatorKey: navigatorGlobalKey,
          title: 'Tanat',
          debugShowCheckedModeBanner: false,
          theme: clientTheme(context),
          builder: (context, child) {
            /* const maxScaleFactor = 1.2; // Set your max scale factor here
            final currentScaleFactor = MediaQuery.of(context).textScaleFactor;*/
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
          home: BlocListener<UserSessionCubit, UserSessionState>(
            listener: (context, state) {
              if (state is UserUnauthenticated) {
                navigationPushReplaceAll(
                  context,
                  InitialView(),
                  // state.loginView ? const LoginView() : const InitialView(),
                );
              }

              // if (state is UserAuthenticated) {
              //   navigationPushReplaceAll(
              //     context,
              //     const HomeViewWithSessionHandler(),
              //   );
              // }
            },
            child: InitialView(),
          ),
        ),
      ),
    );
  }
}

ThemeData clientTheme(BuildContext context) => ThemeData(
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: BorderSide.none,
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
    alignLabelWithHint: true,
    labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    contentPadding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 0.0),
    fillColor: const Color(0x0b000000),
  ),
  textTheme: GoogleFonts.soraTextTheme(),
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
  scaffoldBackgroundColor: whiteColor,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      textStyle: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
      backgroundColor: darkColor,
      minimumSize: const Size.fromHeight(50),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.sora(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  useMaterial3: true,
);
