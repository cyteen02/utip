// BuildContext represents the location of a widget in the widget tree
// used for
// - building widgets
// - data propagation - sharing data between widgets
// - navigation
// - theming

import 'package:flutter/material.dart';
import 'package:utip/widgets/bill_amount_field.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_slider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;

  double totalPerPerson() {
  return(     
    ((_billTotal * _tipPercentage ) + _billTotal) / _personCount     
    );
  }

  double totalTip(){
    return ( _billTotal * _tipPercentage);
  }

  void incrementPersonCount() {
    setState(() {
      _personCount++;
    });
  }

  void decrementPersonCount() {
    setState(() {
      if (_personCount > 1) _personCount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    double totalBill = totalPerPerson();
    double totalT = totalTip();

    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('UTip')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Text("Total Per Person", style: style),
                  Text(
                    "£$totalBill",
                    style: style.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: theme.textTheme.displaySmall!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Form
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  BillAmountField(
                     billAmount: _billTotal.toString(),
                    onChanged: (value){
                      setState(() {
                        _billTotal = double.parse(value);
                      });
                    },
                    ),
              
                  // == Split Bill area
                  PersonCounter(
                    theme: theme,
                    personCount: _personCount,
                    onDecrement: decrementPersonCount,
                    onIncrement: incrementPersonCount,
                  ),

                  // == Tip Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip', style: theme.textTheme.titleMedium),
                      Text('£$totalT', style: theme.textTheme.titleMedium),
                    ],
                  ),

                  // == Slider & Text
                  Text("${(_tipPercentage * 100).round()}%"),

                  TipSlider(
                    tipPercentage: _tipPercentage,
                    onChanged: (double value) {
                      setState(() {
                        _tipPercentage = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

