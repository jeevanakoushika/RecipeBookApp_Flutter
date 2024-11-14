import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipe_app/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/users/register'), // Update this line
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{

        'email': _emailController.text,
        'fullName': _fullNameController.text,
        'phone': _phoneController.text,
        'password': _passwordController.text,
        'confirmPassword': _confirmPasswordController.text
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register: ${response.body}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe App",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0, // Increase font size
            fontWeight: FontWeight.bold, // Make the font bold
            fontFamily: 'Roboto', // Specify a font family
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF002D62),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Don't have an account?",
                style: TextStyle(fontSize: 22),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.black), // Black label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border color
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black), // Black label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border color
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black), // Black label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border color
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black), // Black label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border color
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.black), // Black label color
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black, // Black border color
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF002D99), // Set the background color
                ),
                onPressed: _register,
                child: const Text(
                  'Signup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Signin',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  onPressed: () {
                    // Signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}