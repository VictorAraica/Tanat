// import 'package:tanat/auth/login/login_view.dart';
// import 'package:tanat/auth/register/check_email_view.dart';
// import 'package:tanat/utils/navigations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tanat/utils/styles_values.dart';

class InitialView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<InitialView> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final backgroundColor = _current == 0 ? primaryColor : darkColor;
    final textColor = _current == 0 ? darkColor : Colors.white;
    return Stack(
      children: [
        Positioned.fill(
          child: CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              // enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items:
                [InitialViewBackground1(), InitialViewBackground2()].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return i;
                    },
                  );
                }).toList(),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.only(bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: textColor,
                        ),
                        onPressed: () {
                          // navigationPush(context, const LoginView());
                        },
                        child: Text(
                          'registrarse',
                          style: TextStyle(color: backgroundColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          side: BorderSide(width: 3.0, color: textColor),
                          backgroundColor: Colors.black.withOpacity(0.05),
                        ),
                        onPressed: () {
                          // navigationPush(context, const CheckEmailView());
                        },
                        child: Text(
                          'iniciar sesión',
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            [1, 2].asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap:
                                    () => _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (_current == 1
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4,
                                        ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InitialViewBackground1 extends StatelessWidget {
  const InitialViewBackground1({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/initial_view_image.png';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: primaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(color: darkColor, fontSize: 25),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Escoge ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      TextSpan(text: 'un '),
                      TextSpan(
                        text: 'destino ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'especial '),
                      TextSpan(
                        text: 'para ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'ti.'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              Image.asset(imagePath, width: double.infinity),

              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(color: darkColor, fontSize: 15),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Tanat ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),
                      TextSpan(text: 'es un lugar para '),
                      TextSpan(
                        text: 'descubrir, conectar ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'y '),
                      TextSpan(
                        text: 'compartir. ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'unete y vive la experiencia.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InitialViewBackground2 extends StatelessWidget {
  const InitialViewBackground2({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = 'assets/images/initial_view_image_2.png';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: darkColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 28),
                    children: const <TextSpan>[
                      TextSpan(
                        text: 'Únete ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'a una '),
                      TextSpan(
                        text: 'comunidad ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'de gente '),
                      TextSpan(
                        text: 'que ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'ama '),
                      TextSpan(
                        text: 'viajar,',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(
                        text: 'compartir ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'y '),
                      TextSpan(
                        text: 'apoyarse',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '\n'),
                      TextSpan(text: 'mutuamente.'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
              Image.asset(imagePath, width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
