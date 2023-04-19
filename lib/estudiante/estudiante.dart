import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:segundo_parcial/estudiante/java.dart';
import 'package:segundo_parcial/estudiante/php.dart';
import 'package:segundo_parcial/estudiante/phyton.dart';

import '../login.dart';
import 'editpublic.dart';

class Estudiante extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Estudiante> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('report').snapshots();

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Estudiante'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
           Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
  ),
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: ListTile(
    title: Text(
      'PHP Categoria',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PHPPAGE()),
      );
    },
  ),
  
),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
  ),
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: ListTile(
    title: Text(
      'JAVASCRIPT Categoria',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JAVAPAGE()),
      );
    },
  ),
  
),
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        blurRadius: 3,
        offset: Offset(0, 2),
      ),
    ],
  ),
  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: ListTile(
    title: Text(
      'PHYTON Categoria',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PHYTONPAGE()),
      );
    },
  ),
),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar por palabra clave...',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Algo estÃ¡ mal");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final filteredDocs = snapshot.data!.docs.where((doc) =>
                    doc['Titulo'].toString().contains(_searchQuery) ||
                    doc['Descripcion'].toString().contains(_searchQuery));

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    color: Color.fromARGB(255, 151, 151, 151),
                  ),
                  child: ListView.builder(
                    itemCount: filteredDocs.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => editnote(
                                docid: filteredDocs.elementAt(index),
                              ),
                            ),
                          );
                        },
                        child: Column(
  children: [
    SizedBox(
      height: 20,
    ),
    Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        child: ListTile(
          title: Text(
            snapshot.data!.docChanges[index].doc['Titulo'],
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            snapshot.data!.docChanges[index].doc['Categoria'],
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    ),
    SizedBox(
      height: 20,
    ),
  ],
),

                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}