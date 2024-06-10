// ignore_for_file: duplicate_import, library_private_types_in_public_api, unnecessary_to_list_in_spreads, use_super_parameters, use_build_context_synchronously, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapfeature_project/helper/constants.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dots_indicator/dots_indicator.dart';





class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int currentIndex = 0;
  final Map<int, String> selectedOptions = {};
  final Map<int, String?> previousOptions = {};
  int userScore = 0;
  int cognitiveScore = 0;
  int somaticScore = 0;
  final PageController _pageController = PageController();
  final int totalQuestions = 21;

  final List<String> correctAnswers = [
    'b',
    'd',
    'd',
    'c',
    'd',
    'd',
    'd',
    'd',
    'd',
    'd',
    'c',
    'd',
    'c',
    'd',
    'd',
    'd',
    'd',
    'd',
    'd',
    'd',
    'd'
  ];
  @override
  void initState() {
    super.initState();
    postDataToApi(
        userScore: userScore,
        cognitiveScore: cognitiveScore,
        somaticScore: somaticScore);
  }

  void postDataToApi({
    required int userScore,
    required int cognitiveScore,
    required int somaticScore,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');

    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token'
    };

    var response = await http.post(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/testscore'),
      body: {
        "totalscores": userScore.toString(), // Convert to String
        "mentalscores": cognitiveScore.toString(), // Convert to String
        "phyicalscores": somaticScore.toString(), // Convert to String
        "user_id": id, // Assuming '1' is the user ID and is already a string
        "date":
            DateFormat('yyyy/MM/dd').format(DateTime.now()).replaceAll('/', '-')
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

 void nextQuestion() {
    if (currentIndex < 20) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        currentIndex++;
      });
    }
  }

  // Navigate to the previous question
  void previousQuestion() {
    if (currentIndex > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top:90 ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: 21,
                itemBuilder: (context, index) {
                  return buildQuestion(index + 1);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                RawMaterialButton(
                onPressed: previousQuestion,
                elevation: 2.0,
                fillColor:primaryColor,
                child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20,),
          padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
             RawMaterialButton(
          onPressed: () {
            if (currentIndex < 20) {
        nextQuestion();
            } else {
        print('userScore: $userScore');
        print('cognitiveScore: $cognitiveScore');
        print('somaticScore: $somaticScore');
        postDataToApi(
            userScore: userScore,
            cognitiveScore: cognitiveScore,
            somaticScore: somaticScore);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MtResult(
              userScore: userScore,
              cognitiveScore: cognitiveScore,
              somaticScore: somaticScore,
            ),
          ),
        );
            }
          },
          elevation: 2.0,
          fillColor: primaryColor,
          child: Icon(Icons.navigate_next, color: Colors.white , size: 30,),
          padding: EdgeInsets.all(5.0),
          shape: CircleBorder(),
        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuestion(int questionNumber) {
    List<String> questionText = [
      'Sadness',
      'Pessimism',
      'Sense of failure',
      'Loss of pleasure',
      'Guilt',
      'Sense of punishment',
      'Loathing',
      'Self-incrimination',
      'Suicidal ideas',
      'Crying',
      'Irritability',
      'Social withdrawal',
      'Indecision',
      'Feelings of worthlessness',
      'Difficulty of concentration',
      'Change of sleep',
      'Fatigue',
      'Changes in appetite',
      'Weight changes',
      'Health',
      'Loss of interest in sex',
    ];
    List<List<String>> answers = [
      [
        'I do not feel sad.',
        'I feel sad.',
        'I am sad all the time and I can\'t snap out of it.',
        'I am so sad and unhappy that I can\'t stand it.'
      ],
      [
        'I am not particularly discouraged about the future.',
        'I feel discouraged about the future.',
        'I feel I have nothing to look forward to.',
        'I feel the future is hopeless and that things cannot improve.'
      ],
      [
        'I do not feel like a failure.',
        'I feel I have failed more than the average person.',
        'As I look back on my life, all I can see is a lot of failures.',
        'I feel I am a complete failure as a person.'
      ],
      [
        'I get as much satisfaction out of things as I used to.',
        'I don\'t enjoy things the way I used to.',
        'I don\'t get real satisfaction out of anything anymore.',
        'I am dissatisfied or bored with everything.'
      ],
      [
        'I don\'t feel particularly guilty.',
        'I feel guilty a good part of the time.',
        'I feel quite guilty most of the time.',
        'I feel guilty all of the time.'
      ],
      [
        'I don\'t feel I am being punished.',
        'I feel I may be punished.',
        'I expect to be punished.',
        'I feel I am being punished.'
      ],
      [
        'I don\'t feel disappointed in myself.',
        'I am disappointed in myself.',
        'I am disgusted with myself.',
        'I hate myself.'
      ],
      [
        'I don\'t feel I am any worse than anybody else.',
        'I am critical of myself for my weaknesses or mistakes.',
        'I blame myself all the time for my faults.',
        'I blame myself for everything bad that happens.'
      ],
      [
        'I don\'t have any thoughts of killing myself.',
        'I have thoughts of killing myself, but I would not carry them out.',
        'I would like to kill myself.',
        'I would kill myself if I had the chance.'
      ],
      [
        'I don\'t cry any more than usual.',
        'I cry more now than I used to.',
        'I cry all the time now.',
        'I used to be able to cry, but now I can\'t cry even though I want to.'
      ],
      [
        'I am no more irritated by things than I ever was.',
        'I am slightly more irritated now than usual.',
        'I am quite annoyed or irritated a good deal of the time.',
        'I feel irritated all the time.'
      ],
      [
        'I have not lost interest in other people.',
        'I am less interested in other people than I used to be.',
        'I have lost most of my interest in other people.',
        'I have lost all of my interest in other people.'
      ],
      [
        'I make decisions about as well as I ever could.',
        'I put off making decisions more than I used to.',
        'I have greater difficulty in making decisions more than I used to.',
        'I can\'t make decisions at all anymore.'
      ],
      [
        'I don\'t feel that I look any worse than I used to.',
        'I am worried that I am looking old or unattractive.',
        'I feel there are permanent changes in my appearance that make me look unattractive.',
        'I believe that I look ugly.'
      ],
      [
        'I can work about as well as before.',
        'It takes an extra effort to get started at doing something.',
        'I have to push myself very hard to do anything.',
        'I can\'t do any work at all.'
      ],
      [
        'I can sleep as well as usual.',
        'I don\'t sleep as well as I used to.',
        'I wake up 1-2 hours earlier than usual and find it hard to get back to sleep.',
        'I wake up several hours earlier than I used to and cannot get back to sleep.'
      ],
      [
        'I don\'t get more tired than usual.',
        'I get tired more easily than I used to.',
        'I get tired from doing almost anything.',
        'I am too tired to do anything.'
      ],
      [
        'My appetite is no worse than usual.',
        'My appetite is not as good as it used to be.',
        'My appetite is much worse now.',
        'I have no appetite at all anymore.'
      ],
      [
        'I haven\'t lost much weight, if any, lately.',
        'I have lost more than five pounds.',
        'I have lost more than ten pounds.',
        'I have lost more than fifteen pounds.'
      ],
      [
        'I am no more worried about my health than usual.',
        'I am worried about physical problems like aches, pains, upset stomach, or constipation.',
        'I am very worried about physical problems and it\'s hard to think of much else.',
        'I am so worried about my physical problems that I cannot think of anything else.'
      ],
      [
        'I have not noticed any recent change in my interest in sex.',
        'I am less interested in sex than I used to be.',
        'I have almost no interest in sex.',
        'I have lost interest in sex completely.'
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: Text(
            'Question $questionNumber',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: AlegreyaFont,
                  color: labelColor
                ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: StepProgressIndicator(
            totalSteps: 21,
            currentStep: questionNumber,
            size: 13,
            padding: 0,
            unselectedColor: Colors.white,
            roundedEdges: const Radius.circular(10),
            selectedGradientColor: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8ABAC5), Colors.white],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            'Choose the statement that best describes your situation:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: AlegreyaFont,
              color: Color(0xFF1F5D6B),
            ),
          ),
        ),
        buildOptionContainer(questionText[questionNumber - 1]),
        const SizedBox(height: 16.0),
        ...answers[questionNumber - 1].asMap().entries.map((entry) {
          int index = entry.key;
          String answer = entry.value;
          String value = String.fromCharCode('a'.codeUnitAt(0) + index);
          return buildRadioListTile(
            answer,
            value,
            index,
            selectedOptions[questionNumber] ?? '',
            (newValue) {
              updateScores(questionNumber, newValue);
              setState(() {
                selectedOptions[questionNumber] = newValue;
              });
            },
          );
        }).toList(),
      ],
    );
  }

  Widget buildOptionContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 4),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 19.0,
            fontFamily: AlegreyaFont,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildRadioListTile(String title, String value, int score,
      String groupValue, Function(String) onChanged) {
    return RadioListTile<String>(
      title: Text(title ),
      groupValue: groupValue,
      value: value,
      onChanged: (value) {
        setState(() {
          onChanged(value!);
        });
      },
      activeColor: const Color(0xFF8ABAC5),
    );
  }

  void updateScores(int question, String newValue) {
    String? previousOption = previousOptions[question];

    if (question <= 11) {
      // إذا كان السؤال في النطاق الأول (من 1 إلى 11)
      if (previousOption != null) {
        switch (previousOption) {
          case 'b':
            cognitiveScore -= 1;
            userScore -= 1;
            break;
          case 'c':
            cognitiveScore -= 2;
            userScore -= 2;
            break;
          case 'd':
            cognitiveScore -= 3;
            userScore -= 3;
            break;
        }
      }

      switch (newValue) {
        case 'b':
          cognitiveScore += 1;
          userScore += 1;
          break;
        case 'c':
          cognitiveScore += 2;
          userScore += 2;
          break;
        case 'd':
          cognitiveScore += 3;
          userScore += 3;
          break;
      }
    } else {
      // إذا كان السؤال في النطاق الثاني (من 12 إلى 21)
      if (previousOption != null) {
        switch (previousOption) {
          case 'b':
            userScore -= 1;
            somaticScore -= 1;
            break;
          case 'c':
            userScore -= 2;
            somaticScore -= 2;
            break;
          case 'd':
            userScore -= 3;
            somaticScore -= 3;
            break;
        }
      }

      switch (newValue) {
        case 'b':
          userScore += 1;
          somaticScore += 1;
          break;
        case 'c':
          userScore += 2;
          somaticScore += 2;
          break;
        case 'd':
          userScore += 3;
          somaticScore += 3;
          break;
      }
    }

    previousOptions[question] = newValue;
  }
}

class MtResult extends StatefulWidget {
  final int userScore;
  final int cognitiveScore;
  final int somaticScore;

  const MtResult({
    Key? key,
    required this.userScore,
    required this.cognitiveScore,
    required this.somaticScore,
  }) : super(key: key);

  @override
  State<MtResult> createState() => _MtResultState();
}

class _MtResultState extends State<MtResult> {
  @override
  Widget build(BuildContext context) {
    // Define the recommendation text based on userScore
    String recommendationText = '';
    if (widget.userScore < 9) {
      recommendationText =
          'Your score is below 9 so it is considered normal. Keep up the positive vibe!';
    } else if (widget.userScore >= 9 && widget.userScore < 24) {
      recommendationText =
          'Your score is above 9 which indicates a moderate level. Why not chat with ';
    } else if (widget.userScore >= 24) {
      recommendationText =
          'Your score surpasses 24, we strongly recommend that you seek guidance from a mental health professional for an accurate diagnosis. (view doctor map)';
    }

    // Define the severity of depression text based on userScore
    String additionalText = '';

    double percent = (widget.userScore / 63) * 100;
    int roundedPercent = percent.ceil();

    if (widget.userScore <= 10 && widget.userScore >= 0) {
      additionalText =
          'THE SEVERITY OF DEPRESSION: These ups and downs are considered normal';
    } else if (widget.userScore <= 16 && widget.userScore > 10) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Mild mood disturbance';
    } else if (widget.userScore <= 20 && widget.userScore > 16) {
      additionalText =
          'THE SEVERITY OF DEPRESSION: Borderline clinical depression';
    } else if (widget.userScore <= 30 && widget.userScore > 20) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Moderate depression';
    } else if (widget.userScore <= 40 && widget.userScore > 30) {
      additionalText = 'THE SEVERITY OF DEPRESSION: Severe depression';
    } else {
      additionalText = 'THE SEVERITY OF DEPRESSION: Extreme depression';
    }

    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'YOUR SCORES',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      CircularPercentIndicator(
                        radius: 90.0,
                        animation: true,
                        animationDuration: 1800,
                        lineWidth: 12.0,
                        percent: ((widget.userScore / 63)),
                        center: Text(
                          "$roundedPercent %",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: Color(0xFF8ABAC5)),
                        ),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: const Color.fromARGB(255, 245, 243, 243),
                        progressColor: const Color(0xFF8ABAC5),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'YOU SCORED ${widget.userScore} FROM 63',
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        additionalText.trim(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: interFont,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 350,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.only(left: 30.0 , top :10),
                                child: Text(
                                  'SOMATIC DEPRESSIVE SYMPTOMS:',
                                  style: TextStyle(
                                    fontFamily: AlegreyaFont,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F5D6B),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: StepProgressIndicator(
                                  totalSteps: 39,
                                  currentStep: widget.somaticScore,
                                  size: 10,
                                  selectedColor: const Color(0xFF1F5D6B),
                                  unselectedColor: Colors.white,
                                  roundedEdges: const Radius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 80.0),
                                child: Text(
                                  'YOU SCORED ${widget.somaticScore} FROM 39',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color:primaryColor,
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only( left: 5,
                                 top: 10, ),
                            child: Text(
                              'COGNITIVE-AFFECTIVE DEPRESSION SYMPTOMS:',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: AlegreyaFont,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF1F5D6B),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: StepProgressIndicator(
                              totalSteps: 33,
                              currentStep: widget.cognitiveScore,
                              size: 10,
                              selectedColor: const Color(0xFF1F5D6B),
                              unselectedColor: Colors.white,
                              roundedEdges: const Radius.circular(10),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 70.0),
                            child: Text(
                              'YOU SCORED ${widget.cognitiveScore} FROM 33',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: widget.userScore >= 9 && widget.userScore < 24
                      ? RichText(
                          text: TextSpan(
                            text:
                                'Your score is above 9 which indicates a moderate level. Why not chat with ',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F5D6B),
                            ),
                            children: [
                              TextSpan(
                                text: 'Ozey',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, 'chat');
                                  },
                              ),
                              const TextSpan(
                                text: ' to lighten your load?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F5D6B),
                                ),
                              ),
                            ],
                          ),
                        )
                      : widget.userScore >= 24
                          ? RichText(
                              text: TextSpan(
                                text:
                                    'Your score surpasses 24, we strongly recommend that you seek guidance from a mental health professional for an accurate diagnosis. ',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F5D6B),
                                ),
                                children: [
                                  TextSpan(
                                    text: '(view doctor map)',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(context, 'map');
                                      },
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              recommendationText,
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F5D6B),
                              ),
                            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

/*   void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } */
  void postDataToApi({
    required int userScore,
    required int cognitiveScore,
    required int somaticScore,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');

    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer $token'
    };

    var response = await http.post(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/testscore'),
      body: {
        "totalscores": userScore,
        "mentalscores": cognitiveScore,
        "phyicalscores": somaticScore,
        "user_id": '1',
        "date":
            DateFormat('yyyy/MM/dd').format(DateTime.now()).replaceAll('/', '-')
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(response.body);
      print(data['message']);
      //showSnackBar(context, data['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
