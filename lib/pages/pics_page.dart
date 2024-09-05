import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PICS Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PicsPage(),
    );
  }
}

class PicsPage extends StatelessWidget {
  const PicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PICS'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,  // Evitar conflito com Expanded/Flexible
              children: [
                // Imagem principal
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://1.bp.blogspot.com/-sS_dqhWWVYI/XuIKGd3cYyI/AAAAAAAAa6I/6wAv97x7YHoXtczDXiDbL_ILHtcbovQhwCK4BGAsYHg/s736/d84bd239b615427b949a1ff06c3d1cee.jpg', // Substitua pela sua URL ou use Image.asset
                    height: 300,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Texto de descrição
                const Text(
                  'Baseado no seu resultado atual recomendamos as seguintes práticas integrativas complementares:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                
                const SizedBox(height: 16),
                
                // Lista de botões
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lista',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
          
                // Ajustando para Flexible com FlexFit.loose
                Flexible(
                  fit: FlexFit.loose,
                    child: ListView(
                    shrinkWrap: true,  // Para evitar o erro de altura indefinida
                    children: const [
                    
                      PracticeButton(title: 'Acupressão',),
                      PracticeButton(title: 'Respiração consciente'),
                      PracticeButton(title: 'Meditação'),
                      PracticeButton(title: 'Cromoterapia'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PracticeButton extends StatelessWidget {
  final String title;

  const PracticeButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Ação ao clicar no botão
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Ícone à direita
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(
              Icons.chevron_right,  // Ícone de ">"
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
