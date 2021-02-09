import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Calculadora de IMC",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _msg = "Calculadora";
  String _obs = "";
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _clear() {
    weightController.clear();
    heightController.clear();
    _formKey = new GlobalKey<FormState>();
    setState(() {
      _msg = "Calculadora";
    });
  }

  void _calcular() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text);

    double imc = weight / (height * height);

    if (imc >= 24.9) {
      String minWeight = ((height * height) * 18.6).toStringAsFixed(1);
      String maxWeight = ((height * height) * 24.9).toStringAsFixed(1);

      setState(() {
        _obs = "Seu peso deve estar entre $minWeight KG e $maxWeight KG";
      });
    } else {
      setState(() {
        _obs = "";
      });
    }

    if (imc < 18.6) {
      setState(() {
        _msg = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      });
    } else if (imc >= 18.6 && imc < 24.9) {
      setState(() {
        _msg = "Peso ideal (${imc.toStringAsPrecision(4)})";
      });
    } else if (imc >= 24.9 && imc < 29.9) {
      setState(() {
        _msg = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      });
    } else if (imc >= 29.9 && imc < 34.9) {
      setState(() {
        _msg = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      });
    } else if (imc >= 34.9 && imc < 39.9) {
      setState(() {
        _msg = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      });
    } else if (imc >= 40) {
      setState(() {
        _msg = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Indice de Massa Corporal"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clear,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            child: Column(
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 30),
                  child: Text(_msg,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      )),
                )),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    _obs,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Peso",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent, fontSize: 18)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 25),
                      controller: weightController,
                      validator: (value) {
                        if (value.isEmpty) return "O peso é obrigatório";
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Altura",
                          labelStyle: TextStyle(
                              color: Colors.blueAccent, fontSize: 18)),
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blueAccent, fontSize: 25),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "A altura é obrigatória";
                        }
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    FlatButton(
                      height: 50,
                      color: Colors.blueAccent,
                      onPressed: _calcular,
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
