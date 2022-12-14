import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({super.key, required this.color, required this.cost});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "#",
          style: TextStyle(
              color: color,
              fontSize: 10,
            
              fontFeatures: const [
                FontFeature.superscripts(),
              ]),
        ),
        Text(          cost.toInt().toString(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
        Text(
          (cost - cost.toInt()).toString(),
          style: const TextStyle(fontSize: 10, fontFeatures: [
            FontFeature.superscripts(),
          ]),
        )
      ],
    );
  }
}
