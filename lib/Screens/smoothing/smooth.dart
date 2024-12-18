import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/smoothing/gussian.dart';
import 'package:project/Screens/smoothing/max.dart';
import 'package:project/Screens/smoothing/mean.dart';
import 'package:project/Screens/smoothing/median.dart';
import 'package:project/Screens/smoothing/min.dart';

class Smooth extends StatelessWidget {
  final File imageFile;

  const Smooth({super.key, required this.imageFile});

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
                      builder: (context) => Mean(imageFile: imageFile)),
                );
              }, // Open image picker when tapped
              icon: const ImageIcon(AssetImage("assets/Mean.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Gussian(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Gussian.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Max(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Max.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Min(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Min.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Median(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Median.png")),
            ),
            // Add more icons here as needed
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
