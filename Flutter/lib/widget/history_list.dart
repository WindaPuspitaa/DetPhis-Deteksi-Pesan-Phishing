import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final String message;
  final String label;

  HistoryList({required this.message, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50], // Ubah warna card menjadi biru
      elevation: 0, // Hapus bayang-bayang
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(message),
            ),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: label.toLowerCase() == 'phishing'
                    ? Colors.red
                    : Colors.green,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: TextStyle(color: Colors.white), // Warna tulisan putih
              ),
            ),
          ],
        ),
      ),
    );
  }
}
