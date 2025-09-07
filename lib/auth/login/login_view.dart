import 'package:flutter/material.dart';
import 'package:tanat/utils/styles_values.dart';
import 'package:flutter/gestures.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  String username = "";
  String password = '';
  bool isPasswordVisible = false;
  String errorMessage = ' Error de inicio de sesión';

  @override
  Widget build(BuildContext context) {
    final visibilityOffIcon = Image.asset(
      'assets/icons/visibility_off.png',
      width: 15,
      height: 15,
      color: darkColor,
    );

    final visibilityOnIcon = Image.asset(
      'assets/icons/visibility_on.png',
      width: 15,
      height: 15,
      color: darkColor,
    );

    final alertIcon = Image.asset(
      'assets/icons/alert.png',
      width: 16,
      height: 16,
      color: darkColor,
    );

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset(
            'assets/icons/back_arrow.png',
            width: 15,
            height: 15,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Iniciar sesión.',
                style: TextStyle(
                  color: darkColor,
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),

              Image.asset(
                'assets/images/login_image.png',
                width: double.infinity,
              ),

              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(hintText: 'usuario'),
                  onChanged: (value) => setState(() => username = value),
                ),
              ),

              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'contraseña',
                    suffixIcon: IconButton(
                      icon:
                          isPasswordVisible
                              ? visibilityOnIcon
                              : visibilityOffIcon,
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  onChanged: (value) => setState(() => password = value),
                  obscureText: !isPasswordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
              ),

              const SizedBox(height: 15),

              FilledButton(onPressed: () => {}, child: Text('Iniciar sesión')),

              const SizedBox(height: 15),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: darkColor, fontSize: 12),
                    children: [
                      TextSpan(text: '¿Olvidaste tu contraseña? '),
                      TextSpan(
                        text: 'Recuperar',
                        style: TextStyle(
                          color: Color(0xFF93BE5C),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                print('Recuperar contraseña');
                              },
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    errorMessage.isNotEmpty
                        ? Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border(
                              top: BorderSide(color: darkColor),
                              bottom: BorderSide(color: darkColor),
                              left: BorderSide(width: 3, color: darkColor),
                              right: BorderSide(color: darkColor),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: darkColor,
                                  fontSize: 12,
                                ),
                                children: [
                                  WidgetSpan(child: alertIcon),

                                  WidgetSpan(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15.0,
                                      ),
                                    ),
                                  ),

                                  TextSpan(text: errorMessage),
                                ],
                              ),
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),

                    const SizedBox(height: 5),

                    Center(
                      child: Text(
                        "O",
                        style: TextStyle(
                          color: darkColorWithOpacity,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    FilledButton(
                      onPressed: () => {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0x0b000000),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/google.png',
                            width: 15,
                            height: 15,
                          ),

                          Expanded(
                            child: Center(
                              child: Text(
                                'Iniciar sesión con google',
                                style: TextStyle(
                                  color: darkColor,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
