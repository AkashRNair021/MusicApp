import 'package:flutter/material.dart';
import 'package:quizapp/questions.dart'; // Import the Add Question page

// Define a simple Question class to hold question details
class Question {
  String questionText;
  String option1;
  String option2;
  String option3;
  String option4;
  String correctAnswer;

  Question({
    required this.questionText,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correctAnswer,
  });
}

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  List<Question> questions = [
    Question(
      questionText: 'What is Flutter?',
      option1: 'A programming language',
      option2: 'A framework for building mobile apps',
      option3: 'A database',
      option4: 'A type of bird',
      correctAnswer: 'A framework for building mobile apps',
    ),
    // Add more questions here
  ];

  // Navigate to Add Question page
  void _goToAddQuestionPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddQuestionPage()), // Navigate to AddQuestionPage
    );
  }

  // Function to delete a question
  void _deleteQuestion(int index) {
    setState(() {
      questions.removeAt(index); // Removes the question at the given index
    });
  }

  // Function to edit a question (for now, just a placeholder)
  void _editQuestion(BuildContext context, int index) {
    // Navigate to an edit page where the admin can modify the question
    print('Editing question: ${questions[index].questionText}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Manage Questions'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                // Navigate to settings page
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Handle logout functionality
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stats Section - Dashboard like features
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('Total Questions', '${questions.length}', Icons.question_answer),
                _buildStatCard('Total Subjects', '5', Icons.subject),
              ],
            ),
            SizedBox(height: 30),

            // Welcome text
            Text(
              'Welcome to the Admin Section!',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40), // Space between text and buttons

            // Button to add a new question
            ElevatedButton(
              onPressed: () => _goToAddQuestionPage(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                shadowColor: Colors.black,
                elevation: 5,
              ),
              child: Text(
                'Add Question',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(height: 30), // Space between buttons

            // Display the list of questions
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        questions[index].questionText,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Options: ${questions[index].option1}, ${questions[index].option2}, ${questions[index].option3}, ${questions[index].option4}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _editQuestion(context, index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteQuestion(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build stat cards
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      color: Colors.amber.shade100,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.amber),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
