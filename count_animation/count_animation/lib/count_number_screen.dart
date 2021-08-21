import 'package:count_animation/single_digit.dart';
import 'package:flutter/material.dart';

import 'multiple_digit_counter.dart';

class CountNumberScreen extends StatefulWidget {
  @override
  _CountNumberScreenState createState() => _CountNumberScreenState();
}

class _CountNumberScreenState extends State<CountNumberScreen> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digit Display Demo')),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MultipleDigitCounter(
            4,
            value,
          ),

          SizedBox(height: 30,),
          Slider(
              value: value.toDouble(),
              min: 0,
              max: 3000,
              onChanged: (newValue) {
                if (newValue.toInt() != value.toInt()) {
                  setState(() {
                    value = newValue.toInt();
                  });
                }
              })
        ],
      )),
    );
  }
}

class SliderValueProvider with ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void setValue(int newValue) {
    _value = newValue;
    notifyListeners();
  }
}
