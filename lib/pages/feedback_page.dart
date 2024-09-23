// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mind_sage/pages/levels_page.dart';
import 'package:mind_sage/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa para armazenamento local

class FeedbackPage extends StatefulWidget {
  final VoidCallback onQuestionnaireCompleted;

  FeedbackPage({required this.onQuestionnaireCompleted});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _currentQuestionIndex = 0;
  int _selectedOption = -1;
  int _depressionScore = 0;
  int _anxietyScore = 0;
  int _stressScore = 0;

  DateTime? _lastQuestionnaireDate; // Variável para armazenar a data do último questionário

  @override



  final List<Map<String, dynamic>> _questions = [

    {
      'question': '01 - A prática da cromoterapia ajudou a melhorar o seu bem-estar emocional?',
      'options': [
        'Discordo.',
        'Neutro',
        'Concordo',
        'Concordo totalmente'
      ],
    },
    {
      'question': 'Você sentiu uma diminuição nos níveis de estresse após participar das sessões de meditação?)',
      'options': [
        'Discordo.',
        'Neutro',
        'Concordo',
        'Concordo totalmente'
      ],
    },
    {
      'question': 'A reflexologia podal contribuiu para uma sensação de relaxamento e redução da ansiedade?',
      'options': [
        'Discordo.',
        'Neutro',
        'Concordo',
        'Concordo totalmente'
      ],
    },
    {
      'question':
      'Após a cromoterapia, você percebeu uma melhora na qualidade do seu sono?',
      'options': [
        'Discordo.',
        'Neutro',
        'Concordo',
        'Concordo totalmente'
      ],
    },
    {
      'question': 'As práticas de meditação, cromoterapia e reflexologia podal juntas proporcionaram uma sensação de maior equilíbrio mental e emocional?',
      'options': [
        'Discordo.',
        'Neutro',
        'Concordo',
        'Concordo totalmente'
      ],
    },

  ];

  void _calculateResults() {
    String depressionLevel = _getLevel(_depressionScore, [9, 13, 20, 27]);
    String anxietyLevel = _getLevel(_anxietyScore, [7, 9, 14, 19]);
    String stressLevel = _getLevel(_stressScore, [14, 18, 25, 33]);

    print('Depressão: $depressionLevel');
    print('Ansiedade: $anxietyLevel');
    print('Estresse: $stressLevel');


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfile()
      ),
    );
  }

  String _getLevel(int score, List<int> thresholds) {
    if (score <= thresholds[0]) {
      return 'Leve';
    } else if (score <= thresholds[1]) {
      return 'Moderada';
    } else if (score <= thresholds[2]) {
      return 'Grave';
    } else if (score <= thresholds[3]) {
      return 'Muito Grave';
    } else {
      return 'Extremamente Severo';
    }
  }

  void _nextQuestion() {
    if (_selectedOption != -1) {
      if (_currentQuestionIndex < 7) {
        _stressScore += _selectedOption;
      } else if (_currentQuestionIndex < 14) {
        _anxietyScore += _selectedOption;
      } else {
        _depressionScore += _selectedOption;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedOption = -1;
        });
      } else {
        _calculateResults();
        widget.onQuestionnaireCompleted();
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione uma opção'),
            content: Text('Você precisa selecionar uma opção antes de continuar.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Avaliação das Práticas',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
                SizedBox(height: 20),
                Text(
                  '${_currentQuestionIndex + 1} - ${question['question']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Marque o item que mais se aplicou a você durante a semana',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 25),
                Divider(),
                SizedBox(height: 25),
                ...List<Widget>.generate(question['options'].length, (index) {
                  return _buildRadioOption(index, question['options'][index]);
                }),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: _selectedOption != -1 ? _nextQuestion : null,
                  child: Text(
                    'Próxima pergunta',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(int value, String text) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedOption,
      onChanged: (int? newValue) {
        setState(() {
          _selectedOption = newValue!;
        });
      },
      title: Text(text,
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
      activeColor: Colors.blue,
    );
  }
}
