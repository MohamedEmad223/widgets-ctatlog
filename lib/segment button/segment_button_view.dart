import 'package:flutter/material.dart';
import 'package:widget_catalog_app/segment%20button/segment_button.dart';

class SegmentedButtonView extends StatelessWidget {
  const SegmentedButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Text('Single choice'),
              SingleChoice(),
              SizedBox(height: 20),
              Text('Multiple choice'),
              MultipleChoice(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}