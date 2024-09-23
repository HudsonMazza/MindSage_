// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mind_sage/pages/feedback_page.dart';
import 'package:mind_sage/pages/levels_page.dart';
import 'package:mind_sage/pages/pics_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa para armazenamento local

class QuestionScreen extends StatefulWidget {
  final VoidCallback onQuestionnaireCompleted;

  QuestionScreen({required this.onQuestionnaireCompleted});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  int _selectedOption = -1;
  int _depressionScore = 0;
  int _anxietyScore = 0;
  int _stressScore = 0;

  DateTime? _lastQuestionnaireDate; // Variável para armazenar a data do último questionário

  @override
  void initState() {
    super.initState();
    _loadLastQuestionnaireDateAndShowDialog(); // Verifica e exibe o diálogo se necessário
  }

  Future<void> _loadLastQuestionnaireDateAndShowDialog() async {
    await _loadLastQuestionnaireDate(); // Carrega a data anterior
    if (_lastQuestionnaireDate != null) {
      final now = DateTime.now();
      final difference = now.difference(_lastQuestionnaireDate!);

      if (difference.inDays < 7) {
        // Se não se passaram 7 dias, mostra o alerta
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(

                title: Text('Você já fez uma avaliação recentemente!',
                  style: TextStyle(
                    color: Colors.blue[700], // Cor do texto principal
                    fontWeight: FontWeight.bold,
                  ),),
                content: Text('Você deve esperar ${7 - difference.inDays} dias para refazer o questionário para garantir precisão dos resultados e acompanhar suas mudanças ao longo do tempo, recomendamos que você espere pelo menos uma semana antes de realizar uma nova avaliação. Isso nos ajuda a entender melhor seu progresso e ajustar nossas sugestões de práticas integrativas para você. Seu bem-estar é a nossa prioridade!💚 '),
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
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop(); // Sai da tela de questionário

                    },
                    child: Text('Entendi', style: TextStyle(
              color: Colors.white, // Cor do texto principal
              fontWeight: FontWeight.bold,
              ),
                    ),
                  ),
                ],
              );
            },
          );
        });
      }
    }
  }

  Future<void> _loadLastQuestionnaireDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('lastQuestionnaireDate');
    if (dateString != null) {
      _lastQuestionnaireDate = DateTime.parse(dateString);
    }
  }

  Future<void> _saveLastQuestionnaireDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastQuestionnaireDate', DateTime.now().toIso8601String());
  }

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Achei difícil me acalmar',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Estava ciente da secura da minha boca',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Não consegui sentir qualquer sentimento positivo',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question':
      'Senti dificuldade para respirar (por exemplo, respiração rápida excessiva, falta de ar na ausência de esforço físico)',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Achei difícil criar iniciativa para fazer as coisas',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Tive a tendência de reagir exageradamente às situações',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti tremores (por exemplo, nas mãos)',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que estava gastando muita energia nervosa',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question':
      'Preocupei-me com situações em que poderia entrar em pânico e me sentir ridículo',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que não tinha nada a esperar',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti-me agitado',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Achei difícil relaxar',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti-me triste e deprimido',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question':
      'Senti-me intolerante a qualquer coisa que me impedisse de continuar o que estava fazendo',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que estava a ponto de entrar em pânico',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Fui incapaz de sentir entusiasmo por qualquer coisa',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que não valia muito como pessoa',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que estava sendo tocado emocionalmente',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question':
      'Estive ciente de ações do meu coração na ausência de esforço físico (por exemplo, sensação de aumento da frequência cardíaca, falta de batimentos cardíacos)',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti medo sem qualquer boa razão',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
      ],
    },
    {
      'question': 'Senti que a vida não tinha sentido',
      'options': [
        'Não se aplicou de maneira alguma',
        'Aplicou-se em algum grau ou por pouco tempo',
        'Aplicou-se em um grau considerável ou por uma boa parte do tempo',
        'Aplicou-se muito ou na maioria do tempo'
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

    _saveLastQuestionnaireDate(); // Salva a data do questionário atual

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LevelsPage(depressionScore: _depressionScore, anxietyScore: _anxietyScore, stressScore: _stressScore),
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
          'Como foi sua semana?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
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
