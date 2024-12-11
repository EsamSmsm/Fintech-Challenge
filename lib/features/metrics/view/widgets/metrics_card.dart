import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class MetricsCard extends StatelessWidget {
  final String title;
  final String? suffix;
  final num value;
  final String imagePath;

  const MetricsCard({
    super.key,
    required this.title,
    required this.value,
    this.suffix,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: ColorManager.primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageSize = constraints.maxWidth * 0.2;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  height: imageSize,
                  width: imageSize,
                  color: ColorManager.secondary,
                ),
                AnimatedDigitWidget(
                  value: value,
                  duration: const Duration(milliseconds: 1500),
                  suffix: suffix,
                  textStyle: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: ColorManager.white),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ColorManager.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
