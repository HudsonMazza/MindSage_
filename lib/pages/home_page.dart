import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/components/my_button.dart';
import 'package:mind_sage/components/my_textfield.dart';
import 'package:mind_sage/pages/health_data.dart';
import 'package:mind_sage/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mind_sage/components/about_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nascDateController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  String? selectedCivilStatus;
  String? selectedGender;

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

  // Método para marcar o formulário como preenchido
  Future<void> _markPersonalDataFormCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('personalDataFormCompleted', true);
  }

  // Método para sair do usuário
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Dados Pessoais...',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  user.displayName != null
                      ? "${user.displayName!}, preencha os dados para prosseguir"
                      : "${user.email}, preencha os dados para prosseguir" ??
                      "",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(
                controller: _nameController,
                labelText: 'Nome completo*',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: _ageController,
                labelText: 'Idade*',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              MyTextField(
                controller: _phoneController,
                labelText: 'Telefone*',
                obscureText: false,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Estado Civil   &   Sexo",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Row para os dois dropdowns
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
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
                          labelText: 'Estado Civil',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        value: selectedCivilStatus,
                        items: <String>[
                          'Solteiro',
                          'Casado',
                          'Divorciado',
                          'Viúvo'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCivilStatus = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
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
                          labelText: 'Sexo',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        value: selectedGender,
                        items: <String>[
                          'Feminino',
                          'Masculino',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 85),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () async { if (selectedGender != null && selectedCivilStatus != null &&
                      _ageController != null && _nameController !=null &&  _phoneController != null) {
                    await _markPersonalDataFormCompleted();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(),
                      ),
                          (Route<dynamic> route) => false,
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
                            'Você precisa responder todas as opções para continuar.',
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
    );
  }
}
