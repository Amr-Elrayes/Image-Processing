import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/basic%20ops/crop.dart';
import 'package:project/Screens/basic%20ops/resize.dart';
import 'package:project/Screens/basic%20ops/rotate.dart';

class Basic extends StatelessWidget {
  final File imageFile;

  const Basic({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Resize(imageFile: imageFile)),
                );
              }, // Open image picker when tapped
              icon: const ImageIcon(AssetImage("assets/resize.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Crop(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/crop.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Rotate(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/rotate.png")),
            ),
          ],
        ),
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
