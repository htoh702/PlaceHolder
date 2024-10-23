import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LandingPageWeb extends StatelessWidget {
  const LandingPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 930) {
            return buildWideLayout(context, constraints);
          } else {
            return buildNarrowLayout(context, constraints);
          }
        },
      ),
    );
  }

  Widget buildWideLayout(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/elephant.png',
                height: 150,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const SliderWidget(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 150),
                        ResponsiveText(
                          text: '고민 없는 약속 코스',
                          baseFontSize: 45,
                          maxWidth: constraints.maxWidth,
                        ),
                        ResponsiveText(
                          text: '이제 플레이스 홀더에서',
                          baseFontSize: 45,
                          maxWidth: constraints.maxWidth,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '90개의 핫플레이스 장소들로 AI를 통해 몇 분 만에 약속 코스를 만들어보세요.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 70),
                        const GoogleLoginButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNarrowLayout(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/elephant.png',
                height: 100,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const SliderWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        text: '고민 없는 약속 코스',
                        baseFontSize: 35,
                        maxWidth: constraints.maxWidth,
                      ),
                      ResponsiveText(
                        text: '이제 플레이스 홀더에서',
                        baseFontSize: 35,
                        maxWidth: constraints.maxWidth,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '90개의 핫플레이스 장소들로 AI를 통해 몇 분 만에 약속 코스를 만들어보세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const SizedBox(height: 50),
                      const GoogleLoginButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final double baseFontSize;
  final double maxWidth;

  const ResponsiveText({
    Key? key,
    required this.text,
    required this.baseFontSize,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fontSize = baseFontSize;
    if (maxWidth < 600) {
      fontSize = baseFontSize * 0.8;
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFE07A5F),
      ),
    );
  }
}

final List<String> imgList = [
  'assets/images/mainPage1.png',
  'assets/images/mainPage2.png',
  'assets/images/mainPage3.png',
];

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CarouselSlider(
            carouselController: _controller,
            items: imgList.map((imgLink) {
              int index = imgList.indexOf(imgLink);
              bool isCurrent = _current == index;
              double scale = isCurrent ? 1.0 : 0.8;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()..scale(scale),
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imgLink,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              enlargeCenterPage: true,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({Key? key}) : super(key: key);

  @override
  _GoogleLoginButtonState createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> signInWithWebUIProvider() async {
    try {
      SignInResult res =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
      safePrint('Result: $res');
      if (mounted) {
        context.go('/main');
      }
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        signInWithWebUIProvider();
      },
      child: Image.asset(
        'assets/images/android_light_sq_SI@4x.png',
        height: 50.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
