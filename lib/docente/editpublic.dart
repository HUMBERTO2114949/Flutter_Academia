import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'docente.dart';
import 'report.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;
  _editnoteState({required this.docid});

  TextEditingController titulo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController link = TextEditingController();
  String categoriaSeleccionada = '';

  @override
  void initState() {
    titulo = TextEditingController(text: widget.docid.get('Titulo'));
    descripcion = TextEditingController(text: widget.docid.get('Descripcion'));
    link = TextEditingController(text: widget.docid.get('Link'));
    categoriaSeleccionada = widget.docid.get('Categoria');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        actions: [
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
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'Titulo': titulo.text,
                'Descripcion': descripcion.text,
                'Link': link.text,
                'Categoria': categoriaSeleccionada
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
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "Eliminar",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
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
                height: 2,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: descripcion,
                  maxLines: null,
                  keyboardType: TextInputType.number,
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
                  maxLines: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'link',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: DropdownButtonFormField<String>(
                  value: categoriaSeleccionada,
                  items: [
                    DropdownMenuItem(
                      child: Text('PHP'),
                      value: 'PHP',
                    ),
                    DropdownMenuItem(
                      child: Text('JAVA'),
                      value: 'JAVA',
                    ),
                    DropdownMenuItem(
                      child: Text('PHYTON'),
                      value: 'PHYTON',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      categoriaSeleccionada = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Categoria',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
   onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (_) => reportt(
                        docid: docid,
                      ),
                    ),
                              );
                },
  color: Color.fromARGB(255, 201, 0, 0), // Cambiar el color de fondo del botón
  textColor: Colors.white, // Cambiar el color del texto del botón
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.save), // Agregar un icono al botón
      SizedBox(width: 8.0), // Agregar un espacio entre el icono y el texto
      Text(
        'Generar PDF', // Cambiar el texto del botón
        style: TextStyle(fontSize: 20.0),
      ),
    ],
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
