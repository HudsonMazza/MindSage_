import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mind_sage/pages/dass_page.dart';
import 'package:mind_sage/pages/health_data.dart';
import 'package:mind_sage/pages/joyna_page.dart';

class UserProfile extends StatefulWidget {
  final int? depressionScore;
  final int? anxietyScore;
  final int? stressScore;

  final DateTime? lastCompletedDate; // Adiciona a data da última conclusão

  UserProfile(
      {Key? key,
      this.depressionScore,
      this.lastCompletedDate,
      this.anxietyScore,
      this.stressScore})
      : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = FirebaseAuth.instance.currentUser!;

  // Variáveis para armazenar a data e hora do questionário
  String? completedDate;
  String? completedTime;

  // Método para atualizar data e hora de conclusão
  void updateCompletionTime() {
    setState(() {
      final now = DateTime.now();
      completedDate = DateFormat('EEEE, dd/MM/yyyy').format(now);
      completedTime = DateFormat('HH:mm').format(now);
    });
  }

  String userQuestOk() {
    if (widget.depressionScore != null &&
        widget.anxietyScore != null &&
        widget.stressScore != null) {
      return 'Questionário semanal concluído';
    } else {
      return 'Questionário não concluído ainda';
    }
  }

  void checkLastCompletion() {
    if (widget.lastCompletedDate != null) {
      final daysSinceCompletion =
          DateTime.now().difference(widget.lastCompletedDate!).inDays;

      if (daysSinceCompletion < 7) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Atenção'),
              content:
                  Text('Você só pode fazer a autoavaliação a cada 7 dias.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Navegar para a HealthPage se tiver passado mais de 7 dias
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HealthPage(),
          ),
        );
      }
    } else {
      // Se nunca fez o questionário, pode navegar
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HealthPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 30, bottom: 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color.fromARGB(255, 56, 183, 247),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: user.photoURL != null
                          ? NetworkImage(user.photoURL!)
                          : AssetImage('lib/Images/logo-larga.jpg')
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.displayName != null
                              ? user.displayName!
                              : user.email ?? 'Email não disponível',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Suas atividades',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black87,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 170,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/Images/logo.png',
                    height: 100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: checkLastCompletion, // Chama o método para verificar
              child: Center(
                child: Card(
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      width: 350,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vamos começar a sua autoavaliação!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Sumário',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Divider(
                            color: Colors.blue,
                            thickness: 2,
                            endIndent: 200,
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Iniciar Teste 1/4',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Como foi sua semana?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Aperte aqui para fazer o questionário.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.blue[100],
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Update',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JoynaPage(),
            ),
          );
        },
        child: Icon(
          Icons.add_circle_outline,
          size: 40,
          color: Colors.white,
        ),
        tooltip: 'Increment',
      ),
    );
  }
}
