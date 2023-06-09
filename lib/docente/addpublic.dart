import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'docente.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController link = TextEditingController();
  String categoria = 'PHP';

  CollectionReference ref = FirebaseFirestore.instance.collection('report');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'Titulo': titulo.text,
                'Descripcion': descripcion.text,
                'Link': link.text,
                'Categoria': categoria // agregar la categoría a la base de datos
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "Guardar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Home()));
            },
            child: Text(
              "Regresar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: titulo,
                decoration: InputDecoration(
                  hintText: 'Titulo',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: descripcion,
                decoration: InputDecoration(
                  hintText: 'Descripcion',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: link,
                decoration: InputDecoration(
                  hintText: 'link',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Agregar menú desplegable para seleccionar la categoría
            DropdownButtonFormField(
              value: categoria,
              onChanged: (newValue) {
                setState(() {
                  categoria = newValue.toString();
                });
              },
              items: <String>['PHP', 'JAVA', 'PHYTON'].map((String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Categoría',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
