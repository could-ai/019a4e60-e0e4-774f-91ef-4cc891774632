import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aviator Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        primaryColor: const Color(0xFFE94560),
      ),
      home: const AviatorPredictorPage(),
    );
  }
}

class AviatorPredictorPage extends StatefulWidget {
  const AviatorPredictorPage({super.key});

  @override
  State<AviatorPredictorPage> createState() => _AviatorPredictorPageState();
}

class _AviatorPredictorPageState extends State<AviatorPredictorPage> {
  double? _prediction;
  bool _isLoading = false;

  void _getPrediction() {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _prediction = null;
    });

    // Simulate network delay or calculation
    Timer(const Duration(seconds: 3), () {
      final random = Random();
      // Generate a prediction, e.g., between 1.00x and 10.00x
      final newPrediction = random.nextDouble() * 9.0 + 1.0;
      setState(() {
        _prediction = newPrediction;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aviator Predictor',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF16213E),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.airplanemode_active,
                size: 100,
                color: Color(0xFFE94560),
              ),
              const SizedBox(height: 40),
              const Text(
                'Next Prediction at:',
                style: TextStyle(fontSize: 22, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE94560)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE94560)),
                      )
                    : Text(
                        _prediction == null
                            ? '--.--x'
                            : '${_prediction!.toStringAsFixed(2)}x',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _getPrediction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE94560),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _isLoading ? 'PREDICTING...' : 'GET PREDICTION',
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tap "GET PREDICTION" to see the next signal.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
