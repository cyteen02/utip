// BuildContext represents the location of a widget in the widget tree
// used for
// - building widgets
// - data propagation - sharing data between widgets
// - navigation
// - theming

import 'package:flutter/material.dart';
import 'package:utip/widgets/person_counter.dart';

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
                    "£20.13",
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.currency_pound_rounded),
                      labelText: 'Bill Amount',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      print(">> Value $value");
                    },
                  ),
                  // Split Bill area
                  PersonCounter(
                    
                  theme: theme,
                    personCount: _personCount,
                    onDecrement: decrementPersonCount,
                    onIncrement: incrementPersonCount,
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


