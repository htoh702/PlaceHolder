import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/globals.dart' as globals;

class SelectLocation extends StatefulWidget {
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  double _scale = 0.5;
  double _previousScale = 1.0;

  void _onButtonTap(String imageName) {
    globals.sharedData.value = imageName;
    context.go('/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFFFFE4B5),
            child: GestureDetector(
              onScaleStart: (details) {
                _previousScale = _scale;
              },
              onScaleUpdate: (details) {
                setState(() {
                  _scale = (_previousScale * details.scale).clamp(0.5, 4.0);
                });
              },
              child: InteractiveViewer(
                constrained: false,
                minScale: 0.5,
                maxScale: 4.0,
                scaleEnabled: true,
                panEnabled: true,
                child: Stack(
                  children: [
                    Transform.scale(
                      scale: _scale,
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Center(
                          child: Image.asset('assets/seoul/seoul.png'),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 200,
                        left: 450,
                        child: Transform.scale(
                            scale: _scale,
                            child: const Text("기준 지역을 선택해 주세요",
                                style: TextStyle(fontSize: 90)))),
                    Positioned(
                      top: 361,
                      left: 559,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Eunpyeong.png',
                          width: 440,
                          height: 440,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 271,
                      left: 817,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Dobong.png',
                          width: 363,
                          height: 363,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 739,
                      left: 656,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Dongjak.png',
                          width: 325,
                          height: 325,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 309,
                      left: 766,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gangbuk.png',
                          width: 390,
                          height: 390,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 610,
                      left: 1074,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gangdong.png',
                          width: 320,
                          height: 320,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 486,
                      left: 318,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gangseo.png',
                          width: 485,
                          height: 485,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 852,
                      left: 579,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Geumcheon.png',
                          width: 290,
                          height: 290,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 717,
                      left: 444,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Guro.png',
                          width: 383,
                          height: 383,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 810,
                      left: 640,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gwanak.png',
                          width: 356,
                          height: 356,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 636,
                      left: 986,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gwangjin.png',
                          width: 252,
                          height: 252,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 464,
                      left: 740,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Jongno.png',
                          width: 329,
                          height: 329,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 609,
                      left: 785,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Jung.png',
                          width: 267,
                          height: 267,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 506,
                      left: 1000,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Jungnang.png',
                          width: 263,
                          height: 263,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 522,
                      left: 544,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Mapo.png',
                          width: 416,
                          height: 416,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 271,
                      left: 880,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Nowon.png',
                          width: 424,
                          height: 424,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 723,
                      left: 772,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Seocho.png',
                          width: 482,
                          height: 482,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 542,
                      left: 658,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Seodaemun.png',
                          width: 272,
                          height: 272,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 412,
                      left: 783,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Seongbuk.png',
                          width: 400,
                          height: 400,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 621,
                      left: 883,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Seongdong.png',
                          width: 270,
                          height: 270,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 548,
                      left: 915,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Dongdaemun.png',
                          width: 245,
                          height: 245,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 697,
                      left: 966,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Songpa.png',
                          width: 405,
                          height: 405,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 691,
                      left: 856,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Gangnam.png',
                          width: 435,
                          height: 435,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 676,
                      left: 482,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Yangcheon.png',
                          width: 298,
                          height: 298,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 668,
                      left: 569,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Yeongdeungpo.png',
                          width: 350,
                          height: 350,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: 658,
                      left: 747,
                      child: Transform.scale(
                        scale: _scale,
                        child: HoverButton(
                          imagePath: 'assets/seoul/Yongsan.png',
                          width: 291,
                          height: 291,
                          onTap: () {},
                        ),
                      ),
                    ),
                    Positioned(
                        top: 550,
                        left: 710,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('은평구');
                              },
                              child: const Text(
                                '은평구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 430,
                        left: 935,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('도봉구');
                              },
                              child: const Text(
                                '도봉구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 855,
                        left: 760,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('동작구');
                              },
                              child: const Text(
                                '동작구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 490,
                        left: 880,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('강북구');
                              },
                              child: const Text(
                                '강북구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 730,
                        left: 1170,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('강동구');
                              },
                              child: const Text(
                                '강동구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 690,
                        left: 500,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('강서구');
                              },
                              child: const Text(
                                '강서구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 960,
                        left: 655,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('금천구');
                              },
                              child: const Text(
                                '금천구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 885,
                        left: 540,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('구로구');
                              },
                              child: const Text(
                                '구로구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 950,
                        left: 760,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('관악구');
                              },
                              child: const Text(
                                '관악구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 730,
                        left: 1050,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('광진구');
                              },
                              child: const Text(
                                '광진구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 640,
                        left: 820,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('종로구');
                              },
                              child: const Text(
                                '종로구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 705,
                        left: 865,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('중구');
                              },
                              child: const Text(
                                '중구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 606,
                        left: 1060,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('중랑구');
                              },
                              child: const Text(
                                '중랑구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 730,
                        left: 700,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('마포구');
                              },
                              child: const Text(
                                '마포구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 471,
                        left: 1025,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('노원구');
                              },
                              child: const Text(
                                '노원구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 923,
                        left: 890,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('서초구');
                              },
                              child: const Text(
                                '서초구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 662,
                        left: 700,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('서대문구');
                              },
                              child: const Text(
                                '서대문구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 600,
                        left: 893,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('성북구');
                              },
                              child: const Text(
                                '성북구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 721,
                        left: 963,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('성동구');
                              },
                              child: const Text(
                                '성동구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 648,
                        left: 955,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('동대문구');
                              },
                              child: const Text(
                                '동대문구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 857,
                        left: 1100,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('송파구');
                              },
                              child: const Text(
                                '송파구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 891,
                        left: 986,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('강남구');
                              },
                              child: const Text(
                                '강남구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 810,
                        left: 562,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('양천구');
                              },
                              child: const Text(
                                '양천구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 810,
                        left: 649,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('영등포구');
                              },
                              child: const Text(
                                '영등포구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                    Positioned(
                        top: 765,
                        left: 830,
                        child: Transform.scale(
                            scale: _scale,
                            child: TextButton(
                              onPressed: () {
                                _onButtonTap('용산구');
                              },
                              child: const Text(
                                '용산구',
                                style: TextStyle(fontSize: 45),
                              ),
                            ))),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                context.go('/main');
              },
              child: Image.asset(
                'assets/images/exit_icon.png',
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HoverButton extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;
  final double width;
  final double height;

  const HoverButton({
    Key? key,
    required this.imagePath,
    required this.onTap,
    this.width = 174,
    this.height = 174,
  }) : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: _isHovered ? widget.width + 10 : widget.width,
              height: _isHovered ? widget.height + 10 : widget.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.contain,
                  colorFilter: _isHovered
                      ? ColorFilter.mode(
                          Colors.orange.withOpacity(0.5), BlendMode.srcATop)
                      : null,
                ),
              ),
            ),
            Positioned(
              child: Container(
                width: widget.width / 2,
                height: widget.height / 2,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
