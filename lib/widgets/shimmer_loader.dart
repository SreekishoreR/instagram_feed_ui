import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({super.key});

  @override
  Widget build(context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            height: 60,
            margin: const EdgeInsets.all(8),
            color: Colors.white,
          ),
          Container(
            height: 350,
            color: Colors.white,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.all(8),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}