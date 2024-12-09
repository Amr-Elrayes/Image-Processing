import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Screens/restoration/adabtave_local_noise.dart';
import 'package:project/Screens/restoration/adabtave_median.dart';
import 'package:project/Screens/restoration/alpha_tremmed_mean.dart';
import 'package:project/Screens/restoration/arthimatic_maen.dart';
import 'package:project/Screens/restoration/contraharmonic_mean.dart';
import 'package:project/Screens/restoration/geometric_mean.dart';
import 'package:project/Screens/restoration/harmonic_mean.dart';
import 'package:project/Screens/restoration/max.dart';
import 'package:project/Screens/restoration/median.dart';
import 'package:project/Screens/restoration/midpoint.dart';
import 'package:project/Screens/restoration/min.dart';

class Restoration extends StatelessWidget {
  final File imageFile;

  const Restoration({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ArthimaticMaen(imageFile: imageFile)),
                  );
                }, // Open image picker when tapped
                icon: const ImageIcon(
                    AssetImage("assets/arithmetic_mean.png")), // A
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GeometricMean(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(
                    AssetImage("assets/Gussian.png")), // geometric G
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HarmonicMean(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(
                    AssetImage("assets/Histogram.png")), //harmonic   H
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ContraharmonicMean(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(
                    AssetImage("assets/Contrast.png")), // contra_harmonic  C
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Median(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(
                    AssetImage("assets/Median.png")), // median M
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
                        builder: (context) => Midpoint(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(AssetImage("assets/midpoint.png")),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AlphaTremmedMean(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(AssetImage("assets/Alpha.png")),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AdabtaveLocalNoise(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(AssetImage("assets/Adabtev_local.png")),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AdabtaveMedian(imageFile: imageFile)),
                  );
                },
                icon: const ImageIcon(AssetImage("assets/adaptive_median.png")),
              ),
            ],
          ),
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
