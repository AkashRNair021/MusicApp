import 'package:flutter/material.dart';
import 'package:quizapp/loginpage.dart';
import 'package:quizapp/signuppage.dart';

class MainAuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz App',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color:  Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0), backgroundColor: Colors.amber,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(userType: 'student')),
              ),
              child: Text('Login as Student',
              style: TextStyle(color:Colors.black ),),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0), backgroundColor: Colors.amber,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage(userType: 'admin')),
              ),
              child: Text('Login as Admin',
              style: TextStyle(color:Colors.black ),),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              ),
              child: Text(
                "Don't have an account? Sign up",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
