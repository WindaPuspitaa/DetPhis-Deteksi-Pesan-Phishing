import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Center(
//             child: Column(
//               children: [Text("Aplikasi"), Text("Aplikasi blablabla")],
//             ),
//           ),
//           Column()
//         ],
//       ),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            // Icon(Icons.search),
            Text(
              'Aplikasi',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            // color: Colors.amber[500],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: <Widget>[
                    Text(
                      'Aplikasi',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Deskripsi tentang aplikasi',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    // Image.asset(
                    //     'assets/app_logo.png'),
                  ],
                ),
                Column(
                    // children: [
                    //   Image.asset('assets/gambar.jpg'),
                    // ],

                    )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            // color: Colors.amber[500],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    Text('Detect'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.history),
                      onPressed: () {},
                    ),
                    Text('History'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
                    ),
                    Text('Report'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Artikel ${index + 1}'),
                  subtitle: Text('Deskripsi artikel ${index + 1}'),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
