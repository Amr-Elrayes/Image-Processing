import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/transforms/contrast_stretching.dart';
import 'package:project/Screens/transforms/gamma.dart';
import 'package:project/Screens/transforms/histogram.dart';
import 'package:project/Screens/transforms/logarithmic.dart';
import 'package:project/Screens/transforms/negative.dart';
import 'package:project/Screens/transforms/thresholding.dart';

class Transforms extends StatelessWidget {
  final File imageFile;

  const Transforms({super.key, required this.imageFile});

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
                      builder: (context) => Negative(imageFile: imageFile)),
                );
              }, // Open image picker when tapped
              icon: const ImageIcon(AssetImage("assets/negative.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Logarithmic(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Logarithm.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gamma(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Gamma.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ContrastStretching(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Contrast.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Thresholding(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Transform.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Histogram(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Histogram.png")),
            ),
            // Add more icons if needed
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
