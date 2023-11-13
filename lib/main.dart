import 'package:flutter/material.dart';

void main() => runApp(CalculadoraIMC());

class CalculadoraIMC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaIMC(),
    );
  }
}

class TelaIMC extends StatefulWidget {
  @override
  _TelaIMCState createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  String _resultadoIMC = '';
  String _infoTexto = 'Informe seus dados!';
  String _generoSelecionado = 'Homem';

  void _calcularIMC() {

    try {
      final double peso = double.parse(_pesoController.text.replaceAll(',', '.'));
      final double alturaEmMetros = double.parse(_alturaController.text.replaceAll(',', '').replaceAll('.', '')) / 100;

      if (peso <= 0 || alturaEmMetros <= 0) {
        throw FormatException();
      }

      final double imc = peso / (alturaEmMetros * alturaEmMetros);
    // final double peso = double.parse(_pesoController.text.replaceAll(',', '.'));
    // final double alturaEmMetros = double.parse(_alturaController.text.replaceAll(',', '')) / 100;

    String classificacaoIMC;

    if (imc < 18.5) {
      classificacaoIMC = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      classificacaoIMC = 'Peso normal';
    } else if (imc >= 24.9 && imc < 29.9) {
      classificacaoIMC = 'Sobrepeso';
    } else if (imc >= 29.9 && imc < 34.9) {
      classificacaoIMC = 'Obesidade grau I';
    } else if (imc >= 34.9 && imc < 39.9) {
      classificacaoIMC = 'Obesidade grau II';
    } else {
      classificacaoIMC = 'Obesidade grau III ou mórbida';
    }

    setState(() {
      _resultadoIMC = "IMC = ${imc.toStringAsFixed(2)}"; // Formatação para duas casas decimais
      _infoTexto = 'Classificação: $classificacaoIMC';
    });
    } catch (e) {
      setState(() {
        _resultadoIMC = '';
        _infoTexto = 'Por favor, insira valores válidos!';
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0), // Margem em todos os lados
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "BMI Calculator",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0), // Espaço entre o título e as imagens
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _generoSelecionado = 'Homem';
                    });
                  },
                  child: Opacity(
                    opacity: _generoSelecionado == 'Homem' ? 1.0 : 0.5,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdpssjIfSBD_rkhBno7lLe88D1IVYRbCu6Gw',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                SizedBox(width: 20.0), // Espaço entre as imagens
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _generoSelecionado = 'Mulher';
                    });
                  },
                  child: Opacity(
                    opacity: _generoSelecionado == 'Mulher' ? 1.0 : 0.5,
                    child: Image.network(
                      'https://cdn.icon-icons.com/icons2/3708/PNG/512/girl_female_woman_person_people_avatar_icon_230018.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0), // Espaço entre as imagens e os campos de texto
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  ),
                ),
                SizedBox(width: 10.0), // Espaço entre os campos de texto
                Expanded(
                  child: TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 25.0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: _calcularIMC,
                  child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
              ),
            ),
            Text(
              _resultadoIMC,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25.0),
            ),
            Text(
              _infoTexto,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}