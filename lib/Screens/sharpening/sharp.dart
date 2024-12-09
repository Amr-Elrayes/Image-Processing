import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/sharpening/laplacian.dart';
import 'package:project/Screens/sharpening/sobel.dart';
import 'package:project/Screens/sharpening/unsharp.dart';

class Sharp extends StatelessWidget {
  final File imageFile;

  const Sharp({super.key, required this.imageFile});

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
                      builder: (context) => Laplacian(imageFile: imageFile)),
                );
              }, // Open image picker when tapped
              icon: const ImageIcon(AssetImage("assets/Lablace.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Unsharp(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/unsharp.png")),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Sobel(imageFile: imageFile)),
                );
              },
              icon: const ImageIcon(AssetImage("assets/Sharping.png")),
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
