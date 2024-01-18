import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primaryColor: Colors.blue, // Color primario por defecto
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({Key? key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  final TextEditingController resultController = TextEditingController();
  String operation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Num1',
                      filled: true,
                      fillColor: Colors.white, // Color blanco
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'OP',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Num2',
                      filled: true,
                      fillColor: Colors.white, // Color blanco
                    ),
                    enabled: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '=',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: resultController,
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white, // Color blanco
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('7'),
                _buildNumberButton('8'),
                _buildNumberButton('9'),
                ElevatedButton(onPressed: () => _performOperation('+'), child: Text('+')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('4'),
                _buildNumberButton('5'),
                _buildNumberButton('6'),
                ElevatedButton(onPressed: () => _performOperation('-'), child: Text('-')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('1'),
                _buildNumberButton('2'),
                _buildNumberButton('3'),
                ElevatedButton(onPressed: () => _performOperation('*'), child: Text('*')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNumberButton('0'),
                _buildDecimalButton(),
                ElevatedButton(onPressed: () => _performOperation('/'), child: Text('/')),
                ElevatedButton(onPressed: _calculateResult, child: Text('Calcular')),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _clearFields, child: Text('Limpiar')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return ElevatedButton(
      onPressed: () => _appendToInput(number),
      child: Text(number),
    );
  }

  Widget _buildDecimalButton() {
    return ElevatedButton(
      onPressed: () => _appendToInput('.'),
      child: Text('.'),
    );
  }

  void _appendToInput(String value) {
    TextEditingController activeController = operation.isEmpty ? num1Controller : num2Controller;
    activeController.text = activeController.text + value;
  }

  void _performOperation(String op) {
    setState(() {
      operation = op;
    });
  }

  void _calculateResult() {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    double result = 0;

    switch (operation) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
    }

    resultController.text = result.toString();
  }

  void _clearFields() {
    setState(() {
      num1Controller.text = '';
      num2Controller.text = '';
      resultController.text = '';
      operation = '';
    });
  }
}