import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'This is the home feed!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
