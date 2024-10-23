import 'dart:math';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/globals.dart';

class PageData {
  final String? title;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final double borderWidth;
  final List<String> buttons;
  final bool isLastPage;
  final int maxSelectedButtons;
  final List<String> disabledButtons;

  const PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.borderWidth = 1.0,
    required this.buttons,
    this.isLastPage = false,
    required this.maxSelectedButtons,
    this.disabledButtons = const [],
  });
}

final pages = [
  const PageData(
    icon: Icons.map,
    title: "하나의 지역를 선택해 주세요!",
    bgColor: Color(0xFFF67E7F),
    textColor: Colors.white,
    borderWidth: 2.5,
    buttons: [
      "용산구",
      "서초구",
      "강남구",
      "송파구",
      "강동구",
      "광진구",
      "중랑구",
      "노원구",
      "도봉구",
      "강북구",
      "성북구",
      "동대문구",
      "성동구",
      "중구",
      "종로구",
      "서대문구",
      "은평구",
      "마포구",
      "강서구",
      "양천구",
      "영등포구",
      "구로구",
      "금천구",
      "관악구",
      "동작구"
    ],
    isLastPage: false,
    maxSelectedButtons: 1,
  ),
  const PageData(
    icon: Icons.person,
    title: "누구와 함께 떠나볼까요?",
    bgColor: Colors.white,
    textColor: Color(0xFFFF9C7B),
    borderWidth: 2.5,
    buttons: ["친구들과", "가족들과", "혼자", "연인과"],
    isLastPage: false,
    maxSelectedButtons: 1,
  ),
  const PageData(
    icon: Icons.beach_access,
    title: "테마 3곳을 골라주세요!",
    bgColor: Color(0xFFFF9C7B),
    textColor: Colors.white,
    borderWidth: 2.5,
    buttons: [
      "다이어트 실패 하기 좋은",
      "대화하기 좋은",
      "SNS 자랑하기 좋은",
      "땡땡이 치기 좋은",
      "놀기 좋은",
      "카페가기 좋은"
    ],
    isLastPage: true,
    maxSelectedButtons: 3,
    disabledButtons: ["놀기 좋은", "카페가기 좋은"],
  ),
];

class ConcentricAnimationOnboarding extends StatefulWidget {
  const ConcentricAnimationOnboarding({Key? key}) : super(key: key);

  @override
  _ConcentricAnimationOnboardingState createState() =>
      _ConcentricAnimationOnboardingState();
}

class _ConcentricAnimationOnboardingState
    extends State<ConcentricAnimationOnboarding> {
  final List<Set<String>> _selectedButtonsPerPage = List.generate(
    pages.length,
    (_) => <String>{},
  );
  final PageController _pageController = PageController();

  void _handleFinish() {
    for (int i = 0; i < pages.length; i++) {
      if (_selectedButtonsPerPage[i].length < pages[i].maxSelectedButtons) {
        _showAlertDialog(context,
            "${pages[i].title ?? "이 페이지"}에서 ${pages[i].maxSelectedButtons}개의 버튼을 선택해 주세요.");
        return;
      }
    }

    final firstPageSelections = _selectedButtonsPerPage[0].toList();
    if (firstPageSelections.isNotEmpty) {
      sharedData.value = firstPageSelections[0];
    }

    final lastPageSelections =
        _selectedButtonsPerPage[pages.length - 1].toList();
    if (lastPageSelections.isNotEmpty) {
      param1.value = lastPageSelections.length > 0 ? lastPageSelections[0] : "";
      param2.value = lastPageSelections.length > 1 ? lastPageSelections[1] : "";
      param3.value = lastPageSelections.length > 2 ? lastPageSelections[2] : "";
    }
    print(sharedData.value);
    print(param1.value);
    print(param2.value);
    print(param3.value);
    context.go('/main/emergency', extra: {
      'selectedGu': sharedData.value,
      'selectedParams': [param1.value, param2.value, param3.value]
    });
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("알림"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _goToPreviousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    final currentPageIndex = _pageController.page!.toInt();
    if (_selectedButtonsPerPage[currentPageIndex].length <
        pages[currentPageIndex].maxSelectedButtons) {
      _showAlertDialog(context,
          "${pages[currentPageIndex].title ?? "이 페이지"}에서 ${pages[currentPageIndex].maxSelectedButtons}개의 버튼을 선택해 주세요.");
    } else {
      if (currentPageIndex == pages.length - 1) {
        _handleFinish();
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double maxButtonSize = 50.0;

    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: IconButton(
            icon: Icon(
              Icons.navigate_next,
              size: min(screenWidth * 0.08, maxButtonSize),
            ),
            onPressed: _goToNextPage,
          ),
        ),
        scaleFactor: 2,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: pages.length,
        onFinish: _handleFinish,
        pageController: _pageController,
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: PageContent(
              page: page,
              selectedButtons: _selectedButtonsPerPage[index],
              onPrevious: _goToPreviousPage,
              showBackButton: index > 0,
            ),
          );
        },
      ),
    );
  }
}

class PageContent extends StatefulWidget {
  final PageData page;
  final Set<String> selectedButtons;
  final VoidCallback onPrevious;
  final bool showBackButton;

  const PageContent({
    Key? key,
    required this.page,
    required this.selectedButtons,
    required this.onPrevious,
    required this.showBackButton,
  }) : super(key: key);

  @override
  _PageContentState createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 80) / 4;
    final buttonHeight = max(screenHeight * 0.05, 40.0);

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.page.textColor,
                ),
                child: Icon(
                  widget.page.icon,
                  size: screenHeight * 0.1,
                  color: widget.page.bgColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.page.title ?? "",
                    style: TextStyle(
                      color: widget.page.textColor,
                      fontSize: screenHeight * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                runSpacing: 8.0,
                children: widget.page.buttons
                    .map((buttonText) => SizedBox(
                          width: buttonWidth,
                          height: buttonHeight,
                          child: OutlinedButton(
                            onPressed: widget.page.disabledButtons
                                    .contains(buttonText)
                                ? null
                                : () {
                                    setState(() {
                                      if (widget.selectedButtons
                                          .contains(buttonText)) {
                                        widget.selectedButtons
                                            .remove(buttonText);
                                      } else if (widget.selectedButtons.length <
                                          widget.page.maxSelectedButtons) {
                                        widget.selectedButtons.add(buttonText);
                                      } else if (widget
                                              .page.maxSelectedButtons ==
                                          1) {
                                        widget.selectedButtons.clear();
                                        widget.selectedButtons.add(buttonText);
                                      }
                                    });
                                  },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  widget.selectedButtons.contains(buttonText)
                                      ? widget.page.bgColor
                                      : widget.page.disabledButtons
                                              .contains(buttonText)
                                          ? Colors.grey.shade400
                                          : widget.page.textColor,
                              side: BorderSide(
                                color: widget.page.textColor,
                                width: widget.page.borderWidth,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                  color: widget.selectedButtons
                                          .contains(buttonText)
                                      ? widget.page.textColor
                                      : widget.page.bgColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          if (widget.showBackButton)
            Positioned(
              top: 20.0,
              left: 20.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: widget.page.textColor),
                onPressed: widget.onPrevious,
              ),
            ),
        ],
      ),
    );
  }
}
