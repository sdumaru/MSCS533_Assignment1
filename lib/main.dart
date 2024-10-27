import 'package:flutter/material.dart';

void main() {
  runApp(const ConversionApp());
}

class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        // This is the theme of the application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade600),
        useMaterial3: true,
      ),
      home: const ConversionPage(),
    );
  }
}

class ConversionPage extends StatefulWidget {
  const ConversionPage({super.key});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  final TextEditingController _valueController = TextEditingController();
  double _convertedValue = 0.0;
  String _conversionMessage =
      'Enter a value to convert and select appropriate units';

  // Conversion logic for metric to imperial and vice versa
  void _convert() {
    // Read value from the Value field and convert it to double
    bool conversionSuccess = true;
    double inputValue = double.tryParse(_valueController.text) ?? 0.0;

    if (_fromUnit == 'meters' && _toUnit == 'feet') {
      _convertedValue = inputValue * 3.28084;
    } else if (_fromUnit == 'feet' && _toUnit == 'meters') {
      _convertedValue = inputValue / 3.28084;
    } else if (_fromUnit == 'miles' && _toUnit == 'kilometers') {
      _convertedValue = inputValue * 1.60934;
    } else if (_fromUnit == 'kilometers' && _toUnit == 'miles') {
      _convertedValue = inputValue / 1.60934;
    } else if (_fromUnit == 'meters' && _toUnit == 'miles') {
      _convertedValue = inputValue * 0.000621371;
    } else if (_fromUnit == 'miles' && _toUnit == 'meters') {
      _convertedValue = inputValue / 0.000621371;
    } else if (_fromUnit == 'kilograms' && _toUnit == 'pounds') {
      _convertedValue = inputValue * 2.20462;
    } else if (_fromUnit == 'pounds' && _toUnit == 'kilograms') {
      _convertedValue = inputValue / 2.20462;
    } else if (_fromUnit == 'liters' && _toUnit == 'ounces') {
      _convertedValue = inputValue * 33.814;
    } else if (_fromUnit == 'ounces' && _toUnit == 'liters') {
      _convertedValue = inputValue / 33.814;
    } else {
      conversionSuccess = false;
    }

    // Check if the conversion result is 0.0, print error message if so
    if (!conversionSuccess) {
      _conversionMessage = 'Conversion criteria not match';
    } else {
      _conversionMessage =
          '${_valueController.text.isNotEmpty ? double.parse(_valueController.text) : '0'} $_fromUnit are $_convertedValue $_toUnit';
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _convert method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Measures Converter'),
        centerTitle: true, // Centering the title in the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Value', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.blueAccent),
              decoration: const InputDecoration(
                hintText: 'Enter value',
                hintStyle: TextStyle(color: Colors.blueAccent),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'From',
              style: TextStyle(fontSize: 18),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _fromUnit,
                  style: const TextStyle(color: Colors.blueAccent),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                  items: <String>[
                    'meters',
                    'feet',
                    'miles',
                    'kilometers',
                    'kilograms',
                    'pounds',
                    'liters',
                    'ounces'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'To',
              style: TextStyle(fontSize: 18),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _toUnit,
                  style: const TextStyle(color: Colors.blueAccent),
                  onChanged: (String? newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                  items: <String>[
                    'meters',
                    'feet',
                    'miles',
                    'kilometers',
                    'kilograms',
                    'pounds',
                    'liters',
                    'ounces'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _convert,
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.zero, // Makes the button rectangular
                  ),
                  backgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5), // Adjust padding for larger button size
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Print the result of text
            Center(
              child: Text(
                _conversionMessage,
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
