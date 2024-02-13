import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WeightForm extends StatefulWidget {
  @override
  _WeightFormState createState() => _WeightFormState();
}

class _WeightFormState extends State<WeightForm> {
  bool showResult = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String result = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/bgImage.jpg'), fit: BoxFit.cover),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Age (years)',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      calculateWeightStatus();
                      setState(() {
                        showResult = true;
                      });
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green.shade500),
                    overlayColor:
                        MaterialStateProperty.all<Color>(Colors.green.shade100),
                    side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Colors.white)),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                if (showResult)
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(
                                0.5), // Полупрозрачный белый цвет сверху
                            Colors.white.withOpacity(
                                0.8), // Чуть менее полупрозрачный белый цвет внизу
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green, // Цвет границы
                          width: 2, // Ширина границы
                        ), // Округленные углы
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            text,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(fontSize: 20),
                          ),
                          Text(
                            result,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lato(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateWeightStatus() {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);
    int age = int.parse(ageController.text);

    double bmi = weight / (height * height);
    String status;

    if (age >= 18 && age <= 30) {
      if (bmi < 18) {
        status = 'Underweight';
        text = 'You are underweight. You need to gain';
        result = ' ${calculateNeededWeight(bmi)} kg';
      } else if (bmi >= 18 && bmi <= 25) {
        status = 'Normal';
        text = 'Congratulations! Your weight is normal.';
        result = '';
      } else {
        status = 'Overweight';
        text = 'You are overweight. You need to lose';
        result = ' ${calculateExcessWeight(bmi)} kg';
      }
    } else {
      // For ages outside the range 19-24, additional conditions can be added here.
      text = 'This app is meant for users aged';
      result = '18-30 only';
    }

    setState(() {
      result = result;
    });
  }

  String calculateNeededWeight(double bmi) {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    double neededWeight = (18 * height * height) - weight;
    String roundedNumber = neededWeight.toStringAsFixed(2);
    return roundedNumber;
  }

  String calculateExcessWeight(double bmi) {
    double height = double.parse(heightController.text) / 100;
    double weight = double.parse(weightController.text);

    double excessWeight = weight - (25 * height * height);
    String roundedNumber = excessWeight.toStringAsFixed(2);
    return roundedNumber;
  }
}
