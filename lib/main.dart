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
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Sorteio de Filmes',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          backgroundColor:Color.fromARGB(255, 182, 98, 255),
        ), 
        backgroundColor:Color.fromARGB(255, 182, 98, 255),
        body: Container( 
          child: Center(
              child: mostrarFilme
                ? SizedBox(
                  width: 450,
                   child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color.fromARGB(255, 218, 177, 255),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Image.asset(
                                filmeSorteado.img,
                                width: 200,
                                height: 200,
                              ),
                            const SizedBox(height: 20),
                            Center(
                              child: Row(
                                 mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.movie, 
                                    color: Color.fromARGB(255, 182, 98, 255),),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Filme: ${filmeSorteado.titulo}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.calendar_today,
                                    color: Color.fromARGB(255, 182, 98, 255),),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Ano: ${filmeSorteado.ano}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                            children: [ 
                              const Text(
                                'Descrição:',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            const SizedBox(height: 4),
                            Text(
                              filmeSorteado.descricao,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Total de Filmes: $total',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: sorteiaFilme,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Sortear Novo Filme'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 182, 98, 255),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
                  : ElevatedButton(
                      onPressed: sorteiaFilme,
                      child: const Text('Sortear Filme'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
