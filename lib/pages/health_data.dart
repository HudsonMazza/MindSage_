import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/pages/dass_page.dart';
import 'package:mind_sage/components/my_button.dart';
import 'package:mind_sage/components/my_textfield.dart';
import 'package:intl/intl.dart';
import 'package:mind_sage/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthPage extends StatefulWidget {
  HealthPage({super.key});

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {

  final user = FirebaseAuth.instance.currentUser!;
  String? selectedEmotion;
  String? selectedWorkout;
  String? selectedIntestin;
  String? completedDate;
  String? completedTime;

  @override
  void initState() {
    super.initState();
    _checkIfPersonalDataFormCompleted1();
  }

  // Método para verificar se o formulário foi preenchido
  Future<void> _checkIfPersonalDataFormCompleted1() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFormCompleted =
        prefs.getBool('personalDataFormCompleted1') ?? false;

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

  // Método para marcar o formulário como preenchido
  Future<void> _markPersonalDataFormCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('personalDataFormCompleted', true);
  }

  // Método para atualizar data e hora de conclusão
  void updateCompletionTime() {
    setState(() {
      final now = DateTime.now();
      completedDate = DateFormat('EEEE, dd/MM/yyyy')
          .format(now); // Formata o dia da semana, dia/mês/ano
      completedTime =
          DateFormat('HH:mm').format(now); // Formata a hora e os minutos
    });
  }

  // sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dados de Saúde',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  user.displayName != null
                      ? " ${user.displayName!}, Em relação a essa semana:"
                      : " ${user.email}, Em relação a essa semana:" ??
                      "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  "Você praticou atividades físicas essa semana?",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.5,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Selecione...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: selectedWorkout,
                    items: <String>[
                      'Não pratiquei',
                      'Pratiquei de vez em quando',
                      'Pratiquei frequentemente',
                      'Pratiquei ativamente'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedWorkout = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  "Qual emocão esteve predominante essa semana?",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.5,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Selecione...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: selectedEmotion,
                    items: <String>[
                      'Medo',
                      'Tristeza',
                      'Alegria',
                      'Raiva',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEmotion = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 27.0),
                child: Text(
                  "Como seu intestino funcionou essa semana?",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 350,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.5,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Selecione...',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    value: selectedIntestin,
                    items: <String>[
                      'Ruim',
                      'Mais ou menos',
                      'Bom',
                      'Muito bom',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedIntestin = newValue!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 70),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    if (selectedIntestin != null && selectedWorkout != null && selectedEmotion != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionScreen(
                            onQuestionnaireCompleted: updateCompletionTime,
                          ),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                            ),
                            backgroundColor: Colors.white, // Fundo azul claro
                            title: Row(
                              children: [
                                Icon(
                                  Icons.info_outline, // Ícone de informação
                                  color: Colors.blue[400],
                                ),
                                SizedBox(width: 10), // Espaçamento entre ícone e texto
                                Text(
                                  'Atenção',
                                  style: TextStyle(
                                    color: Colors.blue[700], // Cor do texto principal
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              'Você precisa selecionar todas as opções para continuar.',
                              style: TextStyle(
                                color: Colors.blueGrey[800], // Cor do texto da mensagem
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, // Cor do texto do botão
                                  backgroundColor: Colors.blue[700], // Cor de fundo do botão
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding do botão
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Bordas arredondadas do botão
                                  ),
                                ),
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Fecha o diálogo
                                },
                              ),
                            ],
                          );
                        },
                      );

                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Próximo',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
