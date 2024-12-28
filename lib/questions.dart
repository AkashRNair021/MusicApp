import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddQuestionPage extends StatefulWidget {
  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _optionAController = TextEditingController();
  final TextEditingController _optionBController = TextEditingController();
  final TextEditingController _optionCController = TextEditingController();
  final TextEditingController _optionDController = TextEditingController();
  String _correctAnswer = '';
  String? _selectedSubject;

  // List of subjects
  List<String> subjects = [
    'MEARN Stack',
    'Flutter Development',
    'Networking',
    'Digital Marketing',
    'Python Development',
    'UI/UX'
  ];

  // Function to add question to Firestore
  Future<void> _addQuestion() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Store question data in Firestore
        await FirebaseFirestore.instance.collection('questions').add({
          'subjectId': _selectedSubject, // Store the selected subject
          'questionText': _questionController.text,
          'options': [
            _optionAController.text,
            _optionBController.text,
            _optionCController.text,
            _optionDController.text
          ],
          'correctAnswer': _correctAnswer,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Question added successfully!')),
        );

        // Clear form fields after submission
        _questionController.clear();
        _optionAController.clear();
        _optionBController.clear();
        _optionCController.clear();
        _optionDController.clear();
        setState(() {
          _correctAnswer = '';
          _selectedSubject = null; // Reset selected subject
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding question: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question'),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber.shade300, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Subject Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedSubject,
                  items: subjects.map((String subject) {
                    return DropdownMenuItem<String>(
                      value: subject,
                      child: Text(subject),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSubject = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Subject',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a subject';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Question Text Input
                TextFormField(
                  controller: _questionController,
                  decoration: InputDecoration(
                    labelText: 'Question',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the question';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Option A Input
                TextFormField(
                  controller: _optionAController,
                  decoration: InputDecoration(
                    labelText: 'Option A',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Option A';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Option B Input
                TextFormField(
                  controller: _optionBController,
                  decoration: InputDecoration(
                    labelText: 'Option B',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Option B';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Option C Input
                TextFormField(
                  controller: _optionCController,
                  decoration: InputDecoration(
                    labelText: 'Option C',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Option C';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Option D Input
                TextFormField(
                  controller: _optionDController,
                  decoration: InputDecoration(
                    labelText: 'Option D',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Option D';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                // Correct Answer Dropdown
                DropdownButtonFormField<String>(
                  value: _correctAnswer.isEmpty ? null : _correctAnswer,
                  items: [
                    'Option A',
                    'Option B',
                    'Option C',
                    'Option D',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _correctAnswer = newValue!;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Correct Answer',
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.amber),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the correct answer';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: _addQuestion,
                  child: Text('Add Question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
