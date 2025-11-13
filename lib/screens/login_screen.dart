import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widget/custom_appbar.dart';
import 'donee/DoneeHomeScreen.dart';
import 'donor/DonorMapScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '', password = '', role = 'donor';
  var userRole="donor";
  // var userRole="donee";
  Future<void> loginUser() async {
    final url = Uri.parse('http://YOUR_SERVER_IP:5000/api/users/login');

    final body = {
      "email": email,
      "password": password,
      "role": role,
    };

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Success! Welcome ${data['user']['name']}')),
      );
      // Navigate to next screen here if needed
    } else {
      final error = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error['error']}')),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: CustomAppBar(
        title: "Login",
        showTitle: true,
        showProfileIcon: false,
        onProfileTap: () {
          // Navigate to profile page or show menu
          print("Profile tapped!");
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
              val!.contains('@') ? null : 'Enter valid email',
              onChanged: (val) => email = val,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Enter password' : null,
              onChanged: (val) => password = val,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: role,
              items: ['donor', 'donee', 'admin']
                  .map((r) => DropdownMenuItem(
                value: r,
                child: Text(
                  r,
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ))
                  .toList(),
              onChanged: (val) => role = val!,
              decoration: InputDecoration(
                labelText: 'Role',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (userRole == 'donee') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DoneeHomeScreen()));
                  } else if (userRole == 'donor') {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const DonorMapScreen()));
                  }
                  // if (_formKey.currentState!.validate()) {
                  //   // loginUser();
                  //
                  //
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
