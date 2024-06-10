// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mapfeature_project/helper/constants.dart';
import 'package:mapfeature_project/screens/QuoteScreen.dart';

class QuotesCategoryScreen extends StatelessWidget {
  const QuotesCategoryScreen({super.key});

  Widget _labelText(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        labelText,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 18.0,
          fontFamily: AlegreyaFont,
          color: Color(0xff1F5D6B),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 242, 242),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 242, 242),
          automaticallyImplyLeading: false,
          title: const Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25.0,
              fontFamily: AlegreyaFont,
              color: Color.fromARGB(255, 167, 201, 209),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _labelText('For You'),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-15-38-removebg-preview.png',
                        text: 'Practise faith',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['faith']),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-15-44-removebg-preview.png',
                        text: 'focus on your health',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['health']),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-15-55-removebg-preview.png',
                        text: 'Grow your business',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                'business',
                                // 'communication',
                                // 'learning',
                                // 'success'
                              ]),
                            ),
                          );
                        },
                      ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-02-17_21-16-01-removebg-preview.png',
                      //   text: 'Card 5',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 6',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _labelText('Improve your mindset'),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-01-removebg-preview.png',
                        text: 'self care',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                'change',
                                // 'life',
                                // 'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-18-removebg-preview.png',
                        text: 'Be confident ',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                'love',
                                // 'change',
                                // 'life',
                                // 'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-23-removebg-preview.png',
                        text: 'love yourself',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                // 'change',
                                // 'life',
                                'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 4',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 5',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 6',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _labelText('Take Care of Yourself'),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-29-removebg-preview.png',
                        text: 'life with chronic pain',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                'alone',
                                // 'fear',
                                // 'life',
                                // 'freedom',
                                // 'failure'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-41-removebg-preview.png',
                        text: 'stop smoking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                // 'change',
                                'life',
                                // 'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-16-55-removebg-preview.png',
                        text: 'Conqurer addiction',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                // 'change',
                                // 'life',
                                'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-07-removebg-preview.png',
                        text: 'Fitness',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['fitness']),
                            ),
                          );
                        },
                      ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 5',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 6',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _labelText('Stay Mentally Strong')),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-14-removebg-preview.png',
                        text: 'Fight depression',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: [
                                    'love',
                                    'change',
                                    'life',
                                    'freedom'
                                  ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-22-removebg-preview (1).png',
                        text: 'Stop overthinking',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                // 'change',
                                'life',
                                // 'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-29-removebg-preview (1).png',
                        text: 'Overcome hard times',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                // 'love',
                                // 'change',
                                // 'life',
                                'freedom'
                              ]),
                            ),
                          );
                        },
                      ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 4',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 5',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 6',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _labelText('Breathe & Relax')),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-35-removebg-preview (1).png',
                        text: 'Find Calm',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const QuoteScreen(selectedCategories: [
                                'love',
                                'change',
                              ]),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-46-removebg-preview (1).png',
                        text: 'Control stress & anxiety',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['faith']),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-51-removebg-preview (1).png',
                        text: 'Handle Panic attacks',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['faith']),
                            ),
                          );
                        },
                      ),
                      CardWidget(
                        image:
                            'images/photo_2024-02-17_21-17-57-removebg-preview (1).png',
                        text: 'Fall asleep',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuoteScreen(
                                  selectedCategories: ['faith']),
                            ),
                          );
                        },
                      ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 5',
                      // ),
                      // CardWidget(
                      //   image:
                      //       'images/photo_2024-01-17_04-14-54-removebg-preview.png',
                      //   text: 'Card 6',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ));
  }
}

class CardWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback? onTap;

  const CardWidget(
      {super.key, required this.image, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          // Use InkWell instead of GestureDetector for the ripple effect
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors:
                    backgroundsoothe, // Replace with your desired gradient colors
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 15, left: 8, right: 8, bottom: 7),
              child: Column(
                children: [
                  Image.asset(
                    image,
                    width: 130,
                    height: 70,
                    // fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontFamily: 'Langar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
