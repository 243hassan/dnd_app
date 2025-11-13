import 'package:flutter/material.dart';

class DoneeHomeScreen extends StatefulWidget {
  const DoneeHomeScreen({super.key});

  @override
  State<DoneeHomeScreen> createState() => _DoneeHomeScreenState();
}

class _DoneeHomeScreenState extends State<DoneeHomeScreen> {
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: const Text('Donee Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isReady = !isReady;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isReady ? Colors.green : Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              isReady ? 'Ready' : 'Not Ready',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
