import 'package:flutter/material.dart';

class OptionsStepper extends StatefulWidget {
  const OptionsStepper({Key? key}) : super(key: key);

  @override
  _OptionsStepperState createState() => _OptionsStepperState();
}

class _OptionsStepperState extends State<OptionsStepper> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: Colors.transparent),
      child: Stepper(
        type: StepperType.horizontal,
        currentStep: _index,
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          }
        },
        onStepContinue: () {
          if (_index <= 0) {
            setState(() {
              _index += 1;
            });
          }
        },
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            title: const Text('Step 1 title'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 1')),
          ),
          const Step(
            title: Text('Step 2 title'),
            content: Text('Content for Step 2'),
          ),
          Step(
            title: const Text('Step 3 title'),
            content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 3')),
          ),
          const Step(
            title: Text('Step 4 title'),
            content: Text('Content for Step 4'),
          ),
        ],
      ),
    );
  }
}
