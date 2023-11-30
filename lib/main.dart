import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Length Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LengthConverter(),
    );
  }
}

class LengthConverter extends StatefulWidget {
  @override
  _LengthConverterState createState() => _LengthConverterState();
}

class _LengthConverterState extends State<LengthConverter> {
  TextEditingController _inputController = TextEditingController();
  String _selectedInputUnit = 'meters';
  String _selectedOutputUnit = 'kilometers';
  double _convertedValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Length Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Length'),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _selectedInputUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInputUnit = newValue!;
                    });
                  },
                  items: ['meters', 'kilometers', 'feet', 'inches']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _selectedOutputUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOutputUnit = newValue!;
                    });
                  },
                  items: ['meters', 'kilometers', 'feet', 'inches']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                double inputValue =
                    double.tryParse(_inputController.text) ?? 0.0;
                double result = convertLength(
                    inputValue, _selectedInputUnit, _selectedOutputUnit);
                setState(() {
                  _convertedValue = result;
                });
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20.0),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Text(
                '$_convertedValue $_selectedOutputUnit',
                key: ValueKey<String>('$_convertedValue $_selectedOutputUnit'),
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double convertLength(double inputValue, String inputUnit, String outputUnit) {
    Map<String, double> conversionFactors = {
      'meters': 1.0,
      'kilometers': 1000.0,
      'feet': 3.28084,
      'inches': 39.3701,
      // Add more units as needed
    };

    double? inputFactor = conversionFactors[inputUnit];
    double? outputFactor = conversionFactors[outputUnit];

    if (inputFactor != null && outputFactor != null) {
      double convertedValue = inputValue * inputFactor / outputFactor;
      return convertedValue;
    } else {
      // Handle invalid units
      print('Invalid units: $inputUnit or $outputUnit');
      return 0.0; // or any default value
    }
  }
}
