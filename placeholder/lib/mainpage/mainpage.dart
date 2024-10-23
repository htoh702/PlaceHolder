import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/services/api.dart';
import 'package:placeholder/widget/googlemap.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/widget/filter.dart';
import 'package:placeholder/globals.dart' as globals;
import 'package:placeholder/widget/kopo_model.dart';
import 'package:placeholder/widget/search_address.dart';
import 'package:placeholder/widget/hotplacedropdown.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InteractiveViewer(
                panEnabled: true,
                scaleEnabled: true,
                minScale: 0.5,
                maxScale: 3.0,
                child: Image.asset('assets/images/summary.png'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem(String assetPath, String description) {
    return Row(
      children: [
        Image.asset(
          assetPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: globals.startAddress,
              builder: (context, startAddress, _) {
                return TopAppBar(startAddress: startAddress);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          child: GoogleMapWidget(),
                        ),
                        SizedBox(height: 120),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 0,
                    right: 0,
                    child: ValueListenableBuilder<String>(
                      valueListenable: globals.sharedData,
                      builder: (context, imageName, _) {
                        return TopWidget(imageName: imageName);
                      },
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 15,
                    child: Builder(
                      builder: (context) {
                        return IconButton(
                          icon:
                              const Icon(Icons.info, color: Colors.blueAccent),
                          onPressed: () => _showPopup(context),
                          iconSize: 36.0,
                        );
                      },
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CircularButtonSlider(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopAppBar extends StatelessWidget {
  final String startAddress;
  const TopAppBar({required this.startAddress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/placeholder_elephant.png',
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
          const Spacer(),
          Text(
            startAddress,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          RemediKopo(
            callback: (KopoModel result) async {
              globals.startAddress.value = result.address;
              try {
                final memberData =
                    await fetchStartLocationUpData(subID.value, result.address);

                print('Member Data: ${memberData!.mapX}, ${memberData.mapY}');

                startX.value = double.parse(memberData.mapX);
                startY.value = double.parse(memberData.mapY);
              } catch (e) {
                print('Error: $e');
              }
            },
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  final String imageName;

  const TopWidget({required this.imageName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        context.go("/main/location");
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 370,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  imageName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 30,
                child: HotPlaceDropdown(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircularButtonSlider extends StatefulWidget {
  const CircularButtonSlider({super.key});

  @override
  _CircularButtonSliderState createState() => _CircularButtonSliderState();
}

class _CircularButtonSliderState extends State<CircularButtonSlider> {
  int _current = 1;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rotateCarousel();
    });
  }

  @override
  void dispose() {
    _controller.stopAutoPlay();
    super.dispose();
  }

  void _rotateCarousel() async {
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (_controller.ready) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [
      _buildCircularButton(
          'assets/images/course_create.png', 'Create', context, 0),
      _buildCircularButton(
          'assets/images/course_list.png', 'Course', context, 1),
      _buildCircularButton('assets/images/filter.png', 'Filter', context, 2),
      _buildCircularButton('assets/images/mypage.png', 'Mypage', context, 3),
    ];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        print("Carousel tapped");
      },
      child: Center(
        child: SizedBox(
          width: 220,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 130,
              enlargeCenterPage: true,
              viewportFraction: 0.38,
              enlargeFactor: 0.00001,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: buttons,
          ),
        ),
      ),
    );
  }

  void showTemporaryOverlay(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: Text(
                '출발지를 입력해 주세요!',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  void showCourseCreationOverlay(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                '코스를 먼저 생성해주세요',
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  Widget _buildCircularButton(
      String assetPath, String title, BuildContext context, int index) {
    double size = index == _current ? 38 : 20;

    return GestureDetector(
      onTap: () {
        if (assetPath == 'assets/images/course_create.png') {
          if (globals.startAddress.value == '출발지를 입력하세요.') {
            showTemporaryOverlay(context);
          } else {
            context.go('/main/select');
          }
        } else if (assetPath == 'assets/images/course_list.png') {
          if (!globals.isCreateCourse.value) {
            showCourseCreationOverlay(context);
          } else {
            context.go('/main/real');
          }
        } else if (assetPath == 'assets/images/mypage.png') {
          context.go('/main/mypage');
        } else {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                minChildSize: 0.5,
                maxChildSize: 1.0,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: const Filter(),
                  );
                },
              );
            },
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: size,
            backgroundColor: Colors.white,
            child: Image.asset(
              assetPath,
              width: size * 1.5,
              height: size * 1.5,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 20,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
