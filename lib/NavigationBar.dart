import 'package:flutter/material.dart';
import 'package:mapfeature_project/screens/MapScreen.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';
import 'package:mapfeature_project/screens/homeScreen.dart';
import 'package:mapfeature_project/screens/natificationScreen.dart';
import 'package:mapfeature_project/screens/profileScreen.dart';

class NavigationTabs extends StatefulWidget {
  final String? userId;
  final List<SentimentRecording> moodRecordings;
  final Function(SentimentRecording) onMoodSelected;
  final double selectedMoodPercentage;
  final String token;
  final String? email;
  final String? name;

  NavigationTabs({
    required this.userId,
    required this.moodRecordings,
    required this.onMoodSelected,
    required this.selectedMoodPercentage,
    required this.token,
    this.email,
    this.name, // Include it in the constructor
  });

  @override
  State<NavigationTabs> createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int selectedIndex = 0;
  late List<Widget> listScreens;

  @override
  void initState() {
    super.initState();
    listScreens = [
      HOMEScreen(
        onMoodSelected: widget.onMoodSelected,
        moodRecordings: widget.moodRecordings,
        selectedMoodPercentage: widget.selectedMoodPercentage,
        email: widget.email,
        token: widget.token ?? '',
        name: widget.name,
        userId: widget.userId ?? '',
      ),
      MapScreen(token: widget.token ?? ''), // Pass the token here
      // const Notifications(),
      EditProfilePage(
        userId: widget.userId ?? '',
        email: widget.email,
        token: widget.token ?? '',
        name: widget.name,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 225),
      body: listScreens[selectedIndex],
      bottomNavigationBar: ClipPath(
        clipper: CustomShapeClipper(),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xff7db2be),
          unselectedItemColor: const Color.fromARGB(255, 154, 156, 156),
          selectedLabelStyle: const TextStyle(fontSize: 1.0),
          unselectedLabelStyle: const TextStyle(fontSize: 1.0),
          iconSize: 25,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.notifications_none),
            //   label: '',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 30.0;
    Path path = Path();

    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(0, size.height, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}