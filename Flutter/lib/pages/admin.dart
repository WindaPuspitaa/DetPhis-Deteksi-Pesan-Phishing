import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test1/pages/add_info.dart';
import 'package:flutter_application_test1/pages/home.dart';
import 'package:flutter_application_test1/service/database.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController judulcontroller = TextEditingController();
  TextEditingController deskripsicontroller = TextEditingController();
  TextEditingController sumbercontroller = TextEditingController();
  Stream? InfoStream;
  Stream? HistoryStream;

  getontheload() async {
    InfoStream = await DatabaseMethods().getInfoDetails();
    HistoryStream = await DatabaseMethods().getDetectionHistory();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allInfoDetails() {
    return StreamBuilder(
        stream: InfoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Judul : " + ds["Judul"],
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      judulcontroller.text = ds["Judul"];
                                      deskripsicontroller.text =
                                          ds["Deskripsi"];
                                      sumbercontroller.text = ds["Sumber"];
                                      EditInfoDetail(ds["Id"]);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .DeleteInfoDetails(ds["Id"]);
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Deskripsi : " + ds["Deskripsi"],
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 51, 49, 45),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Sumber : " + ds["Sumber"],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  Widget allHistoryDetails() {
    return StreamBuilder(
        stream: HistoryStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(child: Text("No history available"));
          }
          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Text : " + ds["text"],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Result : " + ds["result"],
                            style: TextStyle(
                                color: ds["result"] == "phishing"
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Phishing Probability : " +
                                (ds["phishing_probability"] * 100)
                                    .toStringAsFixed(2) +
                                "%",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Non-Phishing Probability : " +
                                (ds["non_phishing_probability"] * 100)
                                    .toStringAsFixed(2) +
                                "%",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Timestamp : " +
                                ds["timestamp"].toDate().toString(),
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddInfo()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Manage Info'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Column(
                children: [Expanded(child: allInfoDetails())],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Column(
                children: [Expanded(child: allHistoryDetails())],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future EditInfoDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(
                    width: 60.0,
                  ),
                  Text(
                    'Edit Info',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Judul',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: judulcontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: deskripsicontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Sumber',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: sumbercontroller,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> updateInfo = {
                              "Judul": judulcontroller.text,
                              "Deskripsi": deskripsicontroller.text,
                              "Sumber": sumbercontroller.text,
                              "Id": id,
                            };
                            await DatabaseMethods()
                                .UpdateInfoDetails(id, updateInfo)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Text("Update")))
                ],
              ),
            ),
          ));
}
