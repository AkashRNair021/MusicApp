import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/students_homepage.dart'; // Import the StudentsHomepage file.

class TestPage extends StatefulWidget {
  final String subject;

  const TestPage({Key? key, required this.subject}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Map<String, String?> _selectedAnswers = {}; // Store selected answers for each question
  int _correctAnswersCount = 0;
  int _totalQuestions = 0;
  List<QueryDocumentSnapshot> _questions = []; // Cache questions locally

  @override
  void initState() {
    super.initState();
    // Fetch questions only once on initial load to avoid flickering
    _fetchQuestions();
  }

  // Fetch questions from Firestore
  Future<void> _fetchQuestions() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('subjectId', isEqualTo: widget.subject)
        .get();

    setState(() {
      _questions = snapshot.docs;
      _totalQuestions = snapshot.docs.length; // Store total number of questions
    });
  }

  // Function to handle submission
  void _submitTest() async {
    int correctAnswers = 0;

    // Iterate over all the questions and check if the selected answer is correct
    for (var question in _questions) {
      var selectedAnswer = _selectedAnswers[question.id];
      var correctAnswer = question['correctAnswer'];

      // If the selected answer matches the correct answer, increment the correct count
      if (selectedAnswer != null && selectedAnswer == correctAnswer) {
        correctAnswers++;
      }
    }

    // Show the result
    setState(() {
      _correctAnswersCount = correctAnswers;
    });

    // Display a dialog with the result
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Test Submitted'),
        content: Text(
            'You got $_correctAnswersCount out of $_totalQuestions correct!'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.subject} Test'),
          backgroundColor: Colors.amber, // Amber color for the app bar
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              tooltip: 'Back to Home',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentsHomepage(),
                  ),
                  (route) => false, // Clears the navigation stack.
                );
              },
            ),
          ],
        ),
        body: Center(child: CircularProgressIndicator()), // Show loading while fetching
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Test'),
        backgroundColor: Colors.amber, // Amber color for the app bar
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Back to Home',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentsHomepage(),
                ),
                (route) => false, // Clears the navigation stack.
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade200, Colors.white], // Gradient with amber and white
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    var questionData = _questions[index];
                    var questionId = questionData.id; // Get the question ID
                    return QuestionCard(
                      questionId: questionId,
                      questionText: questionData['questionText'],
                      options: List<String>.from(questionData['options']),
                      selectedAnswer: _selectedAnswers[questionId], // Pass the selected answer
                      onAnswerSelected: (selectedAnswer) {
                        setState(() {
                          _selectedAnswers[questionId] = selectedAnswer; // Store the selected answer
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _submitTest,
                  child: Text('Submit Test'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final String questionId;
  final String questionText;
  final List<String> options;
  final String? selectedAnswer; // Pass the selected answer for this question
  final Function(String) onAnswerSelected;

  const QuestionCard({
    Key? key,
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color changed to black for contrast
              ),
            ),
            SizedBox(height: 12),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: selectedAnswer, // Set groupValue to the selected answer
                      onChanged: (value) {
                        onAnswerSelected(value!); // Pass the selected answer
                      },
                    ),
                    Text(
                      option,
                      style: TextStyle(fontSize: 16, color: Colors.black), // Text color black
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
