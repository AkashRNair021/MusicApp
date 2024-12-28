import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:quizapp/students_homepage.dart'; // Import the StudentsHomepage file.

class TestPage extends StatelessWidget {
  final String subject;

  const TestPage({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$subject Test'),
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
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('questions')
                .where('subjectId', isEqualTo: subject) // Fetch questions for the selected subject
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No questions available for this subject.'));
              }

              // Display the questions and options
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var questionData = snapshot.data!.docs[index];
                  return QuestionCard(
                    questionText: questionData['questionText'],
                    options: List<String>.from(questionData['options']),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final String questionText;
  final List<String> options;

  const QuestionCard({Key? key, required this.questionText, required this.options}) : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String? _selectedAnswer;

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
              widget.questionText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Text color changed to black for contrast
              ),
            ),
            SizedBox(height: 12),
            ...widget.options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: _selectedAnswer,
                      onChanged: (value) {
                        setState(() {
                          _selectedAnswer = value;
                        });
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
