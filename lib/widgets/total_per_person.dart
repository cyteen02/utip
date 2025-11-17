import 'package:flutter/material.dart';

class TotalPerPerson extends StatelessWidget {
  const TotalPerPerson({
    super.key,
    required this.theme,
    required this.style,
    required this.totalBill,
  });

  final ThemeData theme;
  final TextStyle style;
  final double totalBill;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              "£${totalBill.toStringAsFixed(2)}",
              style: style.copyWith(
                color: theme.colorScheme.onPrimary,
                fontSize: theme.textTheme.displaySmall!.fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

