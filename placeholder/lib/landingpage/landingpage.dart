import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:placeholder/amplifyconfiguration.dart';
import 'package:placeholder/widget/ontopbutton.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            TopOfApp(),
            SizedBox(height: 15),
            Expanded(child: SliderWidget()),
            MainText(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: 300,
            height: 70,
            child: SignButton(),
          ),
        ),
      ),
    );
  }
}

final List<String> imgList = [
  "assets/images/place1.png",
  "assets/images/place2.png",
  "assets/images/place3.png",
];

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imgList.map((imgLink) {
        return Builder(
          builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                imgLink,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgList.asMap().entries.map((entry) {
          return InkWell(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          sliderWidget(),
          sliderIndicator(),
        ],
      ),
    );
  }
}

class MainText extends StatelessWidget {
  const MainText({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "약속 일정은 이제\n플레이스 홀더에서",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "핫 플레이스 115개 지역 제공",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class SignButton extends StatelessWidget {
  const SignButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF9C7B),
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (context) => const AlertDialog(
          title: Center(child: Text('Sign')),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GoogleLoginButton(),
              ],
            ),
          ],
        ),
      ),
      child: const Text('시작하기'),
    );
  }
}

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({super.key});

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

bool _isAmplifyConfigured = false;

class _GoogleLoginButtonState extends State<GoogleLoginButton> {
  @override
  void initState() {
    super.initState();
    configureAmplify();
  }

  void configureAmplify() async {
    print(_isAmplifyConfigured);
    if (!_isAmplifyConfigured) {
      try {
        final authPlugin = AmplifyAuthCognito();
        await Amplify.addPlugin(authPlugin);
        await Amplify.configure(amplifyconfig);
        print('Successfully configured Amplify');
        _isAmplifyConfigured = true;
      } catch (e) {
        print('Error configuring Amplify: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          print('Signed in');
          SignInResult res =
              await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
          print('Signed in: ${res.isSignedIn}');
          if (res.isSignedIn) {
            print('Navigating to /main');
            context.go('/main');
          } else {
            print('Sign in failed');
          }
        } on AuthException catch (e) {
          print(e.message);
        }
      },
      child: Image.asset(
        'assets/images/web_light_rd_SI@4x.png',
        height: 50.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
