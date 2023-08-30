import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart'; // Tambahkan baris ini

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _displayText = '';
  double _result = 0;

  // void _handleButtonPress(String buttonText) {
  //   if (buttonText == '=') {
  //     try {
  //       _result = double.parse(_displayText);
  //     } catch (e) {
  //       _result = 0;
  //     }
  //     _displayText = _result.toString();
  //   } else if (buttonText == 'C') {
  //     _displayText = '';
  //     _result = 0;
  //   } else {
  //     _displayText += buttonText;
  //   }
  //   setState(() {});
  // }
  void _handleButtonPress(String buttonText) {
  if (buttonText == '=') {
    try {
      // Menggunakan library math_expressions untuk mengevaluasi ekspresi matematika
      final parser = Parser();
      final expression = parser.parse(_displayText);
      final result = expression.evaluate(EvaluationType.REAL, ContextModel());

      _result = result;
      _displayText = result.toString();
    } catch (e) {
      _displayText = 'Error';
    }
  } else if (buttonText == 'C') {
    _displayText = '';
    _result = 0;
  } else {
    _displayText += buttonText;
  }
  setState(() {});
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _displayText,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Divider(height: 1),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              Row(
                children: [
                  _buildButton('C'),
                  _buildButton('0'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: TextButton(
        onPressed: () => _handleButtonPress(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
