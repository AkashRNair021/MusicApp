import 'package:flutter/material.dart';
import 'package:quizapp/students_dashboard.dart';

import 'package:quizapp/testpage.dart'; // Import the TestPage

class StudentsHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Subjects',
      theme: ThemeData(fontFamily: 'Roboto', primarySwatch: Colors.blue),
      home: SubjectSelectionPage(),
    );
  }
}

class SubjectSelectionPage extends StatelessWidget {
  final List<Map<String, dynamic>> subjects = [
    {'name': 'MEARN Stack', 'icon': Icons.calculate},
    {'name': 'Flutter Development', 'icon': Icons.science},
    {'name': 'Networking', 'icon': Icons.bubble_chart},
    {'name': 'Digital Marketing', 'icon': Icons.biotech},
    {'name': 'Python Development', 'icon': Icons.history_edu},
    {'name': 'UI/UX', 'icon': Icons.book},
  ];

  void navigateToTest(BuildContext context, String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TestPage(subject: subject), // Navigate with subject name
      ),
    );
  }

  void navigateToUserDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () => navigateToUserDashboard(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select the subject you want to take a test in?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return GestureDetector(
                        onTap: () => navigateToTest(context, subject['name']),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.yellow],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  subject['icon'],
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                subject['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
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
        ),
      ),
    );
  }
}
