import 'package:flutter/material.dart';
import 'single_digit.dart';

final counterKey = GlobalKey();

class MultipleDigitCounter extends StatefulWidget {



  final int value;
  final int numberOfDigits;





  //MultipleDigitCounterState _state;

  /// state has to be accessible so that the value is accessible from the parent widget
  //MultipleDigitCounterState get state => _state;

  MultipleDigitCounter(this.numberOfDigits, this.value, {Key key}): super(key: key);

  @override
  MultipleDigitCounterState createState() {
    return  MultipleDigitCounterState();
  }

}

class MultipleDigitCounterState extends State<MultipleDigitCounter> {






  List<SingleDigit> animatedDigits = [];

  String _oldValue;
  String _newValue;


  @override
  void initState() {
    // TODO: implement initState
    if (animatedDigits.isEmpty) {
      String newValue = getValueAsString(widget.value);

      for (var i = 0; i  < newValue.length; i++) {
        var initialDigit;
        if(newValue[i].trim().isNotEmpty )
          {
             initialDigit = int.parse(newValue[i]) ;
          }



        animatedDigits.add(SingleDigit(value: initialDigit));
      }
      setState(() {

      });
    }
    super.initState();
  }
  @override
  void didUpdateWidget(covariant MultipleDigitCounter oldWidget) {
    if(widget.value!=oldWidget.value)
      {
        _setValue(widget.value);
      }
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  _setValue(int newValue)
  {
      _oldValue = _newValue;


      _newValue = getValueAsString(newValue);


      setState(() {


        for (var i = 0; i <animatedDigits.length; i++) {
          if(_oldValue!=null)
            {
              if (_oldValue[i] != _newValue[i]) {
                setDigitsValue(_newValue[i],i);

              }
            }

          else
            {
              setDigitsValue(_newValue[i],i);
            }

        }

      });
  }

  setDigitsValue(String value,int index)
  {

    if(value.trim().isNotEmpty )
    {
      animatedDigits[index].setValue(int.parse(value));
    }
    else
      {
        animatedDigits[index].setValue(null);
      }
  }

  String getValueAsString(int value) {
    String val = value.toString();
    while (val.length < widget.numberOfDigits) {
      val = ' $val';
    }
    return val;
  }



  @override
  Widget build(BuildContext context) {


    return Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: animatedDigits
    );

  }
}