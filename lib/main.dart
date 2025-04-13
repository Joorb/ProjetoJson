import 'dart:math';
import 'package:flutter/material.dart';
import 'package:app_jason_jrl/filmes.dart';
import 'dart:convert'; 
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool mostrarFilme = false;
  List<Filmes> filmes = List.empty();
  Filmes filmeSorteado = Filmes();
  int total = 0;

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/movies.json');
    Iterable data = await json.decode(response);
    filmes = List<Filmes>.from(data.map((model) => Filmes.fromJson(model)));
    total = filmes.length;
    setState(() {});
  }

  void sorteiaFilme() {
    var r = Random();
    var index = r.nextInt(filmes.length);
    filmeSorteado = filmes[index];
    mostrarFilme = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sorteio de Filmes')),
        body: Center(
          child: mostrarFilme
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(filmeSorteado.img, width: 200, height: 200),
                    SizedBox(height: 20),
                    Text(
                      'Filme Sorteado: ${filmeSorteado.titulo}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Ano de Lançamento: ${filmeSorteado.ano}',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Total de Filmes: $total',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: sorteiaFilme,
                      child: const Text('Sortear Novo Filme'),
                    )
                  ],
                )
                
              :       ElevatedButton(
                      onPressed: sorteiaFilme,
                      child: const Text('Sortear Novo Filme'),
                    ),
        ),
      ),
    );
  }
}
