import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailInfo extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final String sumber;

  DetailInfo({
    required this.judul,
    required this.deskripsi,
    required this.sumber,
  });

  @override
  _DetailInfoState createState() => _DetailInfoState();
}

class _DetailInfoState extends State<DetailInfo> {
  @override
  void initState() {
    super.initState();
    _launchURL();
  }

  void _launchURL() async {
    if (await canLaunchUrlString(widget.sumber)) {
      await launchUrlString(widget.sumber);
    } else {
      // Handle the error according to your needs
      throw 'Could not launch ${widget.sumber}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            Text(
              'Info',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      // body: Center(
      //   child: CircularProgressIndicator(),
      // ),
    );
  }
}
