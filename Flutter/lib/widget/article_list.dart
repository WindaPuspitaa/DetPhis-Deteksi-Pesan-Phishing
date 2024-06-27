import "package:flutter/material.dart";

class AricleList extends StatelessWidget {
  final String title;
  final String description;

  const AricleList({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.blue[100], borderRadius: BorderRadius.circular(12)),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.blue[200],
                  child: Icon(Icons.favorite)),
            ),
            SizedBox(
              width: 12,
            ),
            //Judul
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                //Subtitle
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
