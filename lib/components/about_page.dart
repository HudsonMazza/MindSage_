import 'package:flutter/material.dart';
import 'package:mind_sage/pages/home_page.dart';
import 'package:mind_sage/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MindSageScreen(),
    );
  }
}

class MindSageScreen extends StatefulWidget {
  @override
  _MindSageScreenState createState() => _MindSageScreenState();
}

class _MindSageScreenState extends State<MindSageScreen> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _checkIfPersonalDataFormCompleted();
  }

  // Método para verificar se o formulário foi preenchido
  Future<void> _checkIfPersonalDataFormCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFormCompleted =
        prefs.getBool('personalDataFormCompleted') ?? false;

    if (isFormCompleted) {
      // Redireciona para a próxima página se o formulário já foi preenchido
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfile(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre o Mind Sage',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Bem-vindo ao Mind Sage o aplicativo de autoavaliação de sua saúde mental!',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Text(
              'Este aplicativo foi desenvolvido para ajudá-lo a entender melhor o seu estado de estresse, ansiedade e depressão por meio do formulário DASS-21. Lembre-se de que este é um recurso de autoavaliação e não substitui o diagnóstico ou orientação de um profissional de saúde mental qualificado.',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            Text(
              'Além disso, oferecemos sugestões de práticas integrativas que podem complementar o cuidado com sua saúde mental. Estas práticas são terapias tradicionais que ajudam a promover um bem-estar geral e podem ser uma adição valiosa ao seu cuidado.',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
            Text(
              'Se você sentir a necessidade de ajuda especializada, não hesite em procurar um profissional de saúde mental. Estamos aqui para apoiar você em sua jornada de autoconhecimento e bem-estar.',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: Text('Li e compreendi!'),
              value: isChecked,
              activeColor: Colors.blue,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: isChecked
                    ? () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                        (Route<dynamic> route) => false,  // Isso garante que todas as telas anteriores sejam removidas.
                  );
                }
                    : null,
                child: Text('Próximo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor do botão (azul)
                  foregroundColor: Colors.white, // Cor do texto (branco)
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
