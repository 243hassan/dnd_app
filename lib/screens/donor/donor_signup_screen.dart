import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../widget/custom_appbar.dart';
import '../login_screen.dart'; // Import your login screen

class DonorSignUpScreen extends StatefulWidget {
  const DonorSignUpScreen({super.key});

  @override
  State<DonorSignUpScreen> createState() => _DonorSignUpScreenState();
}

class _DonorSignUpScreenState extends State<DonorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '', email = '', phone = '', password = '', gender = 'male';
  int supportedPeople = 1;
  bool readyForDonation = false;

  Future<void> registerDonor() async {
    final url = Uri.parse('http://YOUR_SERVER_IP:5000/api/users/register');

    final body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "role": "donor",
      "gender": gender,
      "supported_people": supportedPeople,
      "ready_for_donation": readyForDonation
    };

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body));

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donor registered successfully')),
      );
      // Navigate to Login screen after signup
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
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
        title: "Doner",
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
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              validator: (val) => val!.isEmpty ? 'Enter name' : null,
              onChanged: (val) => name = val,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (val) =>
              val!.contains('@') ? null : 'Enter valid email',
              onChanged: (val) => email = val,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.phone,
              validator: (val) => val!.isEmpty ? 'Enter phone' : null,
              onChanged: (val) => phone = val,
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              obscureText: true,
              validator: (val) =>
              val!.length < 6 ? 'Password too short' : null,
              onChanged: (val) => password = val,
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: gender,
              items: ['male', 'female', 'other']
                  .map((g) => DropdownMenuItem(
                value: g,
                child: Text(
                  g,
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ))
                  .toList(),
              onChanged: (val) => gender = val!,
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Supported People',
                labelStyle: TextStyle(color: Colors.green.shade700),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => supportedPeople = int.tryParse(val) ?? 1,
            ),
            SwitchListTile(
              title: const Text('Ready for Donation'),
              value: readyForDonation,
              activeColor: Colors.green.shade700,
              onChanged: (val) => setState(() => readyForDonation = val),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registerDonor();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
