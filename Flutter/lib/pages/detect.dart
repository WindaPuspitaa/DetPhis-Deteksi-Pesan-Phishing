import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetectPage extends StatefulWidget {
  const DetectPage({super.key});

  @override
  State<DetectPage> createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  String _result = '';
  bool _isLoading = false;
  String _errorMessage = '';
  double _phishingProbability = 0.0;
  double _nonPhishingProbability = 0.0;

  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _classifyText() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _result = '';
      _phishingProbability = 0.0;
      _nonPhishingProbability = 0.0;
    });

    final text = _controller.text;
    try {
      final response = await http
          .get(Uri.parse('https://ndaww.pythonanywhere.com/api?query=$text'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['output'];
        final phishingProbability = data['phishing_probability'];
        final nonPhishingProbability = data['non_phishing_probability'];
        setState(() {
          _result = result;
          _phishingProbability = phishingProbability;
          _nonPhishingProbability = nonPhishingProbability;
        });
        _showResultDialog(result, phishingProbability, nonPhishingProbability);
        _saveDetectionHistory(
            text, result, phishingProbability, nonPhishingProbability);
      } else {
        setState(() {
          _errorMessage =
              'Failed to get response from server. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showResultDialog(String result, double phishingProbability,
      double nonPhishingProbability) {
    String imagePath;
    if (result.toLowerCase() == 'phishing') {
      imagePath = 'assets/warning.png';
    } else {
      imagePath = 'assets/shield.png';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Hasil Deteksi')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, width: 50, height: 50),
              SizedBox(height: 8.0),
              Text('$_result'),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _phishingProbability,
                      backgroundColor: Colors.red[100],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      minHeight: 8.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${(_phishingProbability * 100).toStringAsFixed(2)}%',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: _nonPhishingProbability,
                      backgroundColor: Colors.green[100],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      minHeight: 8.0,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '${(_nonPhishingProbability * 100).toStringAsFixed(2)}%',
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDetectionHistory(String text, String result,
      double phishingProbability, double nonPhishingProbability) async {
    final prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';

    if (userId.isEmpty) {
      userId = DateTime.now().millisecondsSinceEpoch.toString();
      await prefs.setString('user_id', userId);
      print('Generated new user ID: $userId');
    }

    if (userId.isNotEmpty) {
      final detectionData = {
        'text': text,
        'result': result,
        'phishing_probability': phishingProbability,
        'non_phishing_probability': nonPhishingProbability,
        'timestamp': FieldValue.serverTimestamp(),
        'user_id': userId,
      };

      try {
        // Simpan riwayat pesan ke koleksi "user_history" untuk setiap pengguna
        await _firestore
            .collection('user_history')
            .doc(userId)
            .collection('history')
            .add(detectionData);
        print('Saved to user history: $detectionData');

        // Simpan riwayat pesan ke koleksi "all_history" untuk semua pengguna
        await _firestore.collection('all_history').add(detectionData);
        print('Saved to global history: $detectionData');
      } catch (e) {
        print('Failed to save detection history: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Detect',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/detect.jpg',
                        width: 150,
                        height: 150,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.blue[50],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Detect Phishing Messages',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Masukkan teks pesan di sini',
                          filled: true,
                          fillColor: Colors.blue[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        minLines: 5,
                        maxLines: 10,
                      ),
                      SizedBox(height: 16.0),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _classifyText,
                            icon: Icon(Icons.search),
                            label: Text("Detect"),
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              textStyle: TextStyle(fontSize: 18),
                              // backgroundColor: Colors.purple[900],
                              // foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      Spacer(),
                      if (_errorMessage.isNotEmpty)
                        Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
