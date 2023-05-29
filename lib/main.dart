import 'package:flutter/material.dart';
import 'package:melatonin_optim/src/calculation_screen.dart';
import 'package:melatonin_optim/src/themes.dart';

void main() {
  runApp(const MelatoninOptim());
}

/// Application entry point.
class MelatoninOptim extends StatelessWidget {
  /// Creates a new [MelatoninOptim].
  const MelatoninOptim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melatonin Optimization',
      theme: primaryTheme,
      home: const CalculationScreen(),
    );
  }
}
