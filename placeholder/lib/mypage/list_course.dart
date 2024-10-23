import 'package:flutter/material.dart';
import 'package:placeholder/globals.dart';
import 'package:placeholder/services/model.dart';
import 'package:placeholder/services/api.dart';

class ListCourse extends StatefulWidget {
  const ListCourse({Key? key}) : super(key: key);

  @override
  State<ListCourse> createState() => _ListCourseState();
}

class _ListCourseState extends State<ListCourse> {
  late Future<List<List<UserCourse>>> futurePlaces;

  @override
  void initState() {
    super.initState();
    futurePlaces = fetchMemberCourseDetail(subID.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course History"),
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
          constraints: const BoxConstraints(maxWidth: 500),
          child: FutureBuilder<List<List<UserCourse>>>(
            future: futurePlaces,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.hasData) {
                final sections = snapshot.data!;
                return ListView.builder(
                  itemCount: sections.length,
                  itemBuilder: (BuildContext context, int index) {
                    final section = sections[index];
                    final firstPlace = section.isNotEmpty ? section[0] : null;
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SecondPage(heroTag: index, section: section),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: index,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: firstPlace != null
                                    ? Image.network(
                                        firstPlace.imageUrl,
                                        width: 200,
                                      )
                                    : Container(
                                        width: 200,
                                        height: 150,
                                        color: Colors.grey,
                                        child: const Icon(
                                            Icons.image_not_supported),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                firstPlace!.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No data available"));
              }
            },
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int heroTag;
  final List<UserCourse> section;

  const SecondPage({Key? key, required this.heroTag, required this.section})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Detail"),
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
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWideScreen = constraints.maxWidth > 600;

            return ListView.builder(
              itemCount: section.length,
              itemBuilder: (context, index) {
                final place = section[index];
                bool showHeroImage = index == 0 && isWideScreen;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showHeroImage)
                          Hero(
                            tag: heroTag,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                place.imageUrl,
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        isWideScreen
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      place.imageUrl,
                                      width: 240,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          place.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(fontSize: 24),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          place.address,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 18),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Category: ${place.category}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 18),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Rating: ${place.rating}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Menus',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),
                                        ...place.menus.map((menu) => Text(
                                            '${menu.item}: ${menu.price}',
                                            style: TextStyle(fontSize: 18))),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Keywords',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(fontSize: 20),
                                        ),
                                        const SizedBox(height: 8),
                                        ...place.keywords.map((keyword) => Text(
                                            '${keyword.keyword} (${keyword.count})',
                                            style: TextStyle(fontSize: 18))),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      place.imageUrl,
                                      width: double.infinity,
                                      height: 240,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    place.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontSize: 24),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    place.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Category: ${place.category}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rating: ${place.rating}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontSize: 18),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Menus',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 8),
                                  ...place.menus.map((menu) => Text(
                                      '${menu.item}: ${menu.price}',
                                      style: TextStyle(fontSize: 18))),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Keywords',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 8),
                                  ...place.keywords.map((keyword) => Text(
                                      '${keyword.keyword} (${keyword.count})',
                                      style: TextStyle(fontSize: 18))),
                                ],
                              ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
