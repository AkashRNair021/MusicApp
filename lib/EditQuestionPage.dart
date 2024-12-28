import 'package:flutter/material.dart';
import 'package:quizapp/admins_homepage.dart';
import 'package:quizapp/questions.dart';  // Import the Question class if needed

class EditQuestionPage extends StatefulWidget {
  final Question question;  // The question to be edited
  final Function(Question) onSave;  // Callback to update the question list

  EditQuestionPage({required this.question, required this.onSave});

  @override
  _EditQuestionPageState createState() => _EditQuestionPageState();
}

class _EditQuestionPageState extends State<EditQuestionPage> {
  late TextEditingController _questionController;
  late TextEditingController _option1Controller;
  late TextEditingController _option2Controller;
  late TextEditingController _option3Controller;
  late TextEditingController _option4Controller;
  late TextEditingController _correctAnswerController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current question data
    _questionController = TextEditingController(text: widget.question.questionText);
    _option1Controller = TextEditingController(text: widget.question.option1);
    _option2Controller = TextEditingController(text: widget.question.option2);
    _option3Controller = TextEditingController(text: widget.question.option3);
    _option4Controller = TextEditingController(text: widget.question.option4);
    _correctAnswerController = TextEditingController(text: widget.question.correctAnswer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
    _correctAnswerController.dispose();
    super.dispose();
  }

  void _saveQuestion() {
    // Create a new updated Question
    Question updatedQuestion = Question(
      questionText: _questionController.text,
      option1: _option1Controller.text,
      option2: _option2Controller.text,
      option3: _option3Controller.text,
      option4: _option4Controller.text,
      correctAnswer: _correctAnswerController.text,
    );

    // Call the onSave callback with the updated question
    widget.onSave(updatedQuestion);

    // Navigate back to the AdminHomePage
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Question'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Question text field
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question Text'),
            ),
            SizedBox(height: 16),

            // Option 1 text field
            TextField(
              controller: _option1Controller,
              decoration: InputDecoration(labelText: 'Option 1'),
            ),
            SizedBox(height: 16),

            // Option 2 text field
            TextField(
              controller: _option2Controller,
              decoration: InputDecoration(labelText: 'Option 2'),
            ),
            SizedBox(height: 16),

            // Option 3 text field
            TextField(
              controller: _option3Controller,
              decoration: InputDecoration(labelText: 'Option 3'),
            ),
            SizedBox(height: 16),

            // Option 4 text field
            TextField(
              controller: _option4Controller,
              decoration: InputDecoration(labelText: 'Option 4'),
            ),
            SizedBox(height: 16),

            // Correct answer text field
            TextField(
              controller: _correctAnswerController,
              decoration: InputDecoration(labelText: 'Correct Answer'),
            ),
            SizedBox(height: 24),

            // Save button
            ElevatedButton(
              onPressed: _saveQuestion,
              child: Text('Save Changes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
