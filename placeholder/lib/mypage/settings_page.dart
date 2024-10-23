import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:placeholder/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _signOut() async {
    try {
      await Amplify.Auth.signOut();
      print('Signed out successfully');
      context.go('/');
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDark.value ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFFDD6E5B), Color(0xFFFFB299)],
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                      title: "Dark Mode",
                      icon: Icons.dark_mode_outlined,
                      trailing: Switch(
                        value: isDark.value,
                        onChanged: (value) {
                          setState(() {
                            isDark.value = value;
                          });
                        },
                      ),
                    ),
                    const _CustomListTile(
                      title: "Notifications",
                      icon: Icons.notifications_none_rounded,
                    ),
                    const _CustomListTile(
                      title: "Security Status",
                      icon: CupertinoIcons.lock_shield,
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  title: "Organization",
                  children: [
                    _CustomListTileWithImage(
                        imagePath: 'assets/withus/spoid.png',
                        title: 'Spoid',
                        description:
                            '컴퓨터 견적의 최저가로 최적의 성능을 뽑아주는 Spoid 입니다. 여러 사이트의 가격 추세를 확인하고 알람을 통해 최저가로 견적 생성을 손쉽게 하세요!',
                        webUrl: "https://www.spoid.shop"),
                    _CustomListTileWithImage(
                        imagePath: 'assets/withus/interviewmaster.png',
                        title: 'InterviewMaster',
                        description:
                            'InterviewMaster는 AI 기술을 활용하여 구직자들의 면접 준비를 돕는 혁신적인 서비스를 제공합니다. 개인 맞춤형 피드백과 실전 같은 모의 면접 경험을 제공하여, 당신의 면접 실력을 한 단계 끌어올리는 데 도움을 드립니다.',
                        webUrl: "https://www.interviewmaster.store"),
                    _CustomListTileWithImage(
                        imagePath: 'assets/withus/dapanda.png',
                        title: 'DAPANDA',
                        description:
                            '네고에 지친 당신, DAPANDA에서 최적의 중고 거래를 경험해보세요. 경매의 재미와 다양한 물품 거래로 스트레스 없이 할 수 있는 중고거래, Welcome to DAPANDA!',
                        webUrl: "https://awscloudschool.online"),
                    _CustomListTileWithImage(
                        imagePath: 'assets/withus/quickcatch.png',
                        title: 'QuickCatch',
                        description:
                            'QuickCatch는 실시간 홈쇼핑 방송과 상품 정보, 그리고 해당 상품의 인터넷 최저가를 제공합니다. 또한, 알찬 리뷰 요약과 할인율 순위를 통해 최적의 쇼핑 환경을 제공합니다.',
                        webUrl: "https://quickcath.store"),
                    _CustomListTileWithImage(
                        imagePath: 'assets/withus/mylittel.png',
                        title: '마이 리틀 레시피',
                        description:
                            '1인 가구를 위한 스마트 요리 비서 My Little Recipe Book! 쉽고 빠른 레시피 검색, 인기 유튜브 요리 영상, 영양 정보, 냉장고 커스터마이징으로 유통기한 관리까지, 마리레와 함께 혼자서도 두렵지 않은 즐거운 요리를 경험하세요!',
                        webUrl: "https://mylittle.recipes"),
                  ],
                ),
                const Divider(),
                _SingleSection(
                  children: [
                    const _CustomListTile(
                      title: "Help & Feedback",
                      icon: Icons.help_outline_rounded,
                    ),
                    const _CustomListTile(
                      title: "About",
                      icon: Icons.info_outline_rounded,
                    ),
                    _CustomListTile(
                      title: "Sign out",
                      icon: Icons.exit_to_app_rounded,
                      onTap: _signOut,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _CustomListTileWithImage extends StatelessWidget {
  final String title;
  final String imagePath;
  final String description;
  final String webUrl;

  const _CustomListTileWithImage({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.webUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
      ),
      title: Text(title),
      onTap: () async {
        if (await canLaunch(webUrl)) {
          await launch(webUrl);
        } else {
          throw 'Could not launch $webUrl';
        }
      },
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}

class DescriptionPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const DescriptionPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFFDD6E5B), Color(0xFFFFB299)],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: double.infinity, // 고정된 너비
                height: 400, // 고정된 높이
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
