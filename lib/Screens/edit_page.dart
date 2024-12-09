import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/basic%20ops/basic.dart';
import 'package:project/Screens/restoration/restoration.dart';
import 'package:project/Screens/segmentation/segment.dart';
import 'package:project/Screens/sharpening/sharp.dart';
import 'package:project/Screens/smoothing/smooth.dart';
import 'package:project/Screens/transforms/transform.dart';

class PhotoPage extends StatelessWidget {
  final File imageFile;

  const PhotoPage({super.key, required this.imageFile});

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
    MaterialPageRoute(builder: (context) =>  Transforms(imageFile: imageFile)),
  );
              }, // Open image picker when tapped
              icon: const ImageIcon(AssetImage("assets/Transform.png")),
            ),
            IconButton(
              onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Smooth(imageFile: imageFile)),
  );
              },
              icon: const ImageIcon(AssetImage("assets/Smoothing.png")),
            ),
            IconButton(
              onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Sharp(imageFile: imageFile)),
  );
              },
              icon: const ImageIcon(AssetImage("assets/Sharping.png")),
            ),
            IconButton(
              onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Segmentationn(imageFile: imageFile)),
  );
              },
              icon: const ImageIcon(AssetImage("assets/Segmentation.png")),
            ),
            IconButton(
              onPressed: () {
                            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Restoration(imageFile: imageFile)),
  );
              },
              icon: const ImageIcon(AssetImage("assets/Restoration.png")),
            ),
            IconButton(
              onPressed: () {
                  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  Basic(imageFile: imageFile)),
  );
              },
              icon: const ImageIcon(AssetImage("assets/Basic.png")),
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




