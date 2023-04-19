import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:segundo_parcial/administrador/administrador.dart';
import 'package:segundo_parcial/docente/docente.dart';
import 'estudiante/estudiante.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(255, 0, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.90,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Bienvenido",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                       TextFormField(
  controller: emailController,
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Correo',
    contentPadding: const EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 10.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  validator: (value) {
    if (value!.isEmpty) {
      return "Email cannot be empty";
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
      return "Colocar un correo valido";
    } else {
      return null;
    }
  },
  onSaved: (value) {
    emailController.text = value!;
  },
  keyboardType: TextInputType.emailAddress,
),

                        SizedBox(
                          height: 20,
                        ),
                       TextFormField(
  controller: passwordController,
  obscureText: _isObscure3,
  decoration: InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(
        _isObscure3 ? Icons.visibility : Icons.visibility_off,
      ),
      onPressed: () {
        setState(() {
          _isObscure3 = !_isObscure3;
        });
      },
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: 'Contraseña',
    contentPadding: const EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 10.0,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  validator: (value) {
    RegExp regex = RegExp(r'^.{6,}$');
    if (value!.isEmpty) {
      return "La contraseña no puede estar vacía";
    }
    if (!regex.hasMatch(value)) {
      return "Colocar una contraseña valida, minimo 6 caracteres";
    } else {
      return null;
    }
  },
  onSaved: (value) {
    passwordController.text = value!;
  },
  keyboardType: TextInputType.emailAddress,
),

                       
                        SizedBox(
                          height: 20,
                        ),
                       MaterialButton(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0),
  ),
  elevation: 5.0,
  height: 32.0,
  onPressed: () {
    setState(() {
      visible = true;
    });
    signIn(emailController.text, passwordController.text);
  },
  child: Text(
    "Login",
    style: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
  ),
  color: Color.fromARGB(255, 65, 0, 187),
),

                        SizedBox(
                          height: 10,
                        ),
                     
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void route() {
  User? user = FirebaseAuth.instance.currentUser;
  var kk = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      if (documentSnapshot.get('rool') == "Docente") {
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Docente(),
        ),
      );
      } else if (documentSnapshot.get('rool') == "Administrador") {
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Administrador(),
        ),
      );
      } else if (documentSnapshot.get('rool') == "Estudiante") {
         Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  Estudiante(),
        ),
      );
      }
    } else {
      print('El documento no existe en la base de datos.');
    }
  });
}


  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('Ningún usuario encontrado para ese correo electrónico.');
        } else if (e.code == 'wrong-password') {
          print('Se proporcionó una contraseña incorrecta para ese usuario.');
        }
      }
    }
  }
}


