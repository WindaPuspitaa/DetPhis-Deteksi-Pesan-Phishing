import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_test1/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_test1/widget/history_list.dart';

class HistoryPage extends StatelessWidget {
  final DatabaseMethods databaseMethods = DatabaseMethods();

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'History',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<String?>(
        future: _getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No user ID found.'));
          }

          final userId = snapshot.data!;

          return StreamBuilder<QuerySnapshot>(
            stream: databaseMethods.getUserDetectionHistory(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No history found.'));
              }

              final historyDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: historyDocs.length,
                itemBuilder: (context, index) {
                  final historyData =
                      historyDocs[index].data() as Map<String, dynamic>;
                  final message = historyData['text'] ?? '';
                  final label = historyData['result'] ?? '';

                  return HistoryList(
                    message: message,
                    label: label,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
