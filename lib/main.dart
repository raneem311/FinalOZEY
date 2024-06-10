// ignore_for_file: depend_on_referenced_packages, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mapfeature_project/helper/cach_helper.dart';

import 'package:mapfeature_project/models/music.dart';
import 'package:mapfeature_project/screens/OTP_Screen.dart';
import 'package:mapfeature_project/screens/QuotesCategoryScreen.dart';
import 'package:mapfeature_project/screens/activities.dart';
import 'package:mapfeature_project/screens/moviesscreen.dart';
import 'package:mapfeature_project/screens/musicScreen.dart';
import 'package:mapfeature_project/screens/notifications.dart';
import 'package:mapfeature_project/screens/soothe_screen.dart';
import 'package:mapfeature_project/NavigationBar.dart';
import 'package:mapfeature_project/moodTracer/sentiment.dart';
import 'package:mapfeature_project/screens/ChatScreen.dart';
import 'package:mapfeature_project/screens/LogInScreen.dart';
import 'package:mapfeature_project/screens/SignUpScreen.dart';
import 'package:mapfeature_project/Todo/todo.dart';
import 'package:mapfeature_project/screens/test.dart';
import 'package:mapfeature_project/views/music_list.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

int userScore = 0;
int cognitiveScore = 0;
int somaticScore = 0;
late Box<Map<String, dynamic>> _messagesBox;
final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications.init();

  LocalNotifications.onClickNotification.stream.listen((payload) {
    if (payload == "Chat bot") {
      navigatorKey.currentState!.pushNamed('chatbot');
    } else if (payload == "recommendations") {
      navigatorKey.currentState!.pushNamed('recommendations');
    } else if (payload == "Quotes") {
      navigatorKey.currentState!.pushNamed('quotes');
    }
  });
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await CachHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  final String? token;
  final String? email;
  final String? userId;
  final String? userName;

  const MyApp({Key? key, this.token, this.userId, this.userName, this.email})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SentimentRecording> moodRecordings = [];
  late List<Music> playlist;

  @override
  void initState() {
    playlist = [
      Music(trackId: '1NwgMwC2ian0sJMaOVL1N4'),
      Music(trackId: '479py8vgzAA5yBI2cpG0mf'),
      Music(trackId: '04JXK1GuqYWZHaRPpdIiv9'),
      Music(trackId: '23rqBG7JfLr8TUXuuCGhma'),
      Music(trackId: '4525Hx49ZxzUeeaKrlYlaS'),
      Music(trackId: '4ngBvPg9frf9pq6pJsZ2eF'),
      Music(trackId: '039xzKjVgqdnmoUOCXuEI2'),
      Music(trackId: '30MQSL5JdjYhhWQKwudYt3'),
      Music(trackId: '5PMC9hoPaC1dixpvpcbV38'), //8
      Music(trackId: '1aeKotbZ2wBYuOspDawtwo'),
      Music(trackId: '7bnUdrfAos6Co3IyR1Id6z'),
      Music(trackId: '07QsOZfpuoSgPFXr0r5Ugj'),
      Music(trackId: '6WLF4Ckt5UKqzmF8MKA04s'),
      Music(trackId: '5wSOHIQZQQO5khFcjATSJC'),
      Music(trackId: '0dkg15gHdh9NiauS5p5A4Q'),
      Music(trackId: '0nwLGUFABAh3gDYvfWhydj'),
      Music(trackId: '5aVgYTCatT8LiNZcpSqmsF'),
      Music(trackId: '6neX7UddFHWZPfnMdwlYGy'),
      Music(trackId: '5mjiOiFFqOI2JgD7vjOEfz'),
      Music(trackId: '317a0LTruoeLNQuew4ulJW'),
      Music(trackId: '16D6Oez22cNa57hkCy0AdO'),
      Music(trackId: '4NSW5d7cEqneY2csfwxwmG'),
      Music(trackId: '2Qe6G6xhpXOrmb38xpknJo'),
      Music(trackId: '37K1OCMlu7tBZx3lz6hGP6'),
      Music(trackId: '6mg7SM5eDp6HzTBwoqkQIn'),
      Music(trackId: '3uK3G29no1DduH1wpVXXtc'), //Oak Island
      Music(trackId: '3T2eXi6Ivi1ZO7pInx3PVC'), //Brand New Day
      Music(trackId: '4Ht8HnNrI7sAYqjybljyHr'),
      Music(trackId: '46Smq12dhbzHYbbSHTZXNR'),
      Music(trackId: '0gknUCR8bue9XTlRjrJeb4'),
      Music(trackId: '6goXs4H0gp9rwKKuzkioGX'),
      Music(trackId: '3xdDoLDyvsMgyl1BwVaZ5E'),
      Music(trackId: '6xld6bFu5ST7nickcSK1lP'),
      Music(trackId: '1UhZB9MRMqes7At9ZBtuYb'),
      Music(trackId: '4KiuT6lph1fSy19AFjHwYE'), //To be loved
      Music(trackId: '41HAiAdjlQV99bxgoZQJic'),
      Music(trackId: '38wJYcJAUKYzRY7MOuA4RZ'),
      Music(trackId: '0jEcYgYvVUCWUSqzbgjQz0'),
      Music(trackId: '38wJYcJAUKYzRY7MOuA4RZ'),
      Music(trackId: '3QPHj5X122ZaSJqulZgpQ1'),
      Music(trackId: '7wv9hOKaKRm5eq9hlQs9M0'),
      Music(trackId: '35g0VTDilkxPVes4IWzpJ3'),
      Music(trackId: '6xYoQ0EtHqtvhgm8zlxHUa'),
      Music(trackId: '5vpgqLPc6SFZU9R2Tok6Uj'),
      Music(trackId: '00gUVjpXxzvLSGQWrqs64P'),
      Music(trackId: '1juGuaPbXZrGTv5STnGhe8'),
      Music(trackId: '1RZCcssySOuMua51d8Kjmn'),
      Music(trackId: '6mDVGG1YdTBveBhL8HEnd0'),
      Music(trackId: '2GKreH8xrOLstyJiB3UqqT'),
      Music(trackId: '6Bj4giIhhImr801fRVMkwa'),
      Music(trackId: '4gpjTvrSADGgcxBhgLkzOE'),
      Music(trackId: '1BYZmYI9UFlfXgcu0Z8CFO'),
      Music(trackId: '3MumRAm3t8hiJGR0mfVVD3'),
      Music(trackId: '1LvTkhsAnii0SHie08LT2e'),
      Music(trackId: '0sw38SQxeJvM9UDgKy6mPM'),
      Music(trackId: '2ww5QdvHAoCLKKGwtF749c'),
      Music(trackId: '0tfY0fIhfRlWXCih8fGKUT'),
      Music(trackId: '14xa42q2VXdEY5OiYjJuJN'),
      Music(trackId: '2GKreH8xrOLstyJiB3UqqT'),
      Music(trackId: '6uEfbWVms8WEkAor1lCF32'),
      Music(trackId: '1LvTkhsAnii0SHie08LT2e'),
      Music(trackId: '00TZ1ds7glf3qrIiN51Uic'),
      Music(trackId: '6Bj4giIhhImr801fRVMkwa'),
      Music(trackId: '4gpjTvrSADGgcxBhgLkzOE'),
      Music(trackId: '7MXVkk9YMctZqd1Srtv4MB'), //Kafrun
      Music(trackId: '3WOiSsqfXPZAtGTr2PFj6S'),
      Music(trackId: '11dFghVXANMlKmJXsNCbNl'),
      Music(trackId: '6V74b74rZQQNyQ8VHq6IKR'),
      Music(trackId: '5K9DCY2iSG4JkY0hZpd2X2'),
      Music(trackId: '3nAAHU0tSNfWVj8lWXzk9K'),
      Music(trackId: '50pKOEBQqfsEJgA1cyXazT'),
      Music(trackId: '3lVAkecZVvyVRN53fDEASP'),
      Music(trackId: '2HnZ5pp0T0vhjMW8m2x6Hs'),
      Music(trackId: '7KRICZbYxrxBrBTClIZcBo'),
      Music(trackId: '2BAeqkE0AKWTajWXbNUUyz'),
      Music(trackId: '36Cjfu2S4G6jHkpYmJqUYs'),
      Music(trackId: '5NCtQmyp47aPi0luJKLwPm'),
      Music(trackId: '29CvytNz97GUizS5nepd1j'),
      Music(trackId: '0QVS7EEH4VPQCuBQLkGdNf'),
      Music(trackId: '0BBWKfGu2F1YrFWaZEwiil'),
      Music(trackId: '78PEAdrjwrZIbcmMAZOKgL'),
      Music(trackId: '1eId10kDzzYZaEd263nboS'),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(playlist: playlist),
      navigatorKey: navigatorKey,
      routes: {
        'login': (context) => const LogInScreen(),
        'signup': (context) => const SignUpScreen(),
        // 'map':(context) {
        // final token = ModalRoute.of(context)!.settings.arguments as String;
        // return  MapScreen(token: token,);},

        'otp_screen': (context) {
          final userId = ModalRoute.of(context)!.settings.arguments as String?;
          return OtpScreen(userId: userId);
        },
        'chatbot': (context) => ChatBot(
              userId: widget.userId ?? "",
              userName: widget.userName ?? "",
            ),
        'test': (context) => const TestScreen(),
        'QCategory': (context) => const QuotesCategoryScreen(),
        'sothee': (context) => const sotheeScreen(),
        'movies': (context) => const MoviesScreen(),
        'music': (context) => const musicScreen(),
        'recommendation': (context) =>
            RecommendationsScreen(playlist: playlist),
        'Todo': (context) => HomePage(),
        'navigator': (context) => NavigationTabs(
              userId: widget.userId,
              moodRecordings: moodRecordings,
              onMoodSelected: (moodRecording) {
                setState(() {
                  moodRecordings.add(moodRecording);
                });
              },
              selectedMoodPercentage: 0.0,
              token: widget.token ?? '',
              email: widget.email ?? "",
              name: widget.userName ?? "",
            ),
      },
      initialRoute: 'sothee',
    );
  }
}
