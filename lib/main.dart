import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weight_check/weight_calculate.dart';

void main() {
  runApp(NormalWeightCalculator());
}

class NormalWeightCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Normal Weight Calculator',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade200,
          title: Text(
            'Normal Weight Calculator',
            style: GoogleFonts.lato(
              color: Colors.green.shade900,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: WeightForm(),
      ),
    );
  }
}
