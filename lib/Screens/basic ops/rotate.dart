import 'dart:io';
import 'package:flutter/material.dart';

class Rotate extends StatelessWidget {
  final File imageFile;

  const Rotate({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("Rotate"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Image section - uses Expanded to fill available space
          Expanded(
            flex: 3, // This will take 3/4 of the available screen height
            child: Image.file(
              imageFile,
              fit: BoxFit.contain,
              width: screenWidth,
            ),
          ),
          // Bottom container - takes the remaining space
          Expanded(
            flex: 1, // This will take 1/4 of the available screen height
            child: Container(
              width: screenWidth,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}




