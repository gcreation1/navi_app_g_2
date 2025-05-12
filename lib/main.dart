//Test
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beispiel Navigieren mit Werten',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Beispiel Navigieren mit Werten'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int result = 0;

  // Da erst nach Schließen der 2. Seite ein Wert zurückgegeben wird, async / await
  Future<void> _navigateToSecondPage() async {
    final int result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(data: 15)),
    );

    if (result != null) {
      //wir versuchen den zurückgebenen Wert zu verwenden
      print('Zurückgegebener Wert plus 1: ${result + 1}');
      setState(() {
        this.result = result; // Korrigierte setState-Aktualisierung
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Value:'),
            //hier lassen wir die Zahl 0 oder 5 nach Rückkehr von Seite 2 anzeigen.
            Text(result.toString()),
          ],
        ),
      ),
      //Bei drücken des add Buttons gelangen wir zur 2. Seite
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSecondPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final int data;
  const SecondPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        print(data + 1);
        // Beim Schließen der Seite einen Wert zurückgeben
        Navigator.pop(context, 5);
      },

      child: Text('Zurück mit Daten(${data + 1})'),
    );
  }
}
