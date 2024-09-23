import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mind_sage/components/my_button.dart';
import 'package:mind_sage/components/my_textfield.dart';
import 'package:mind_sage/pages/auth_page.dart';
import 'package:mind_sage/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final Function()? onTapG;

  const LoginPage({super.key, required this.onTap, this.onTapG});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers - controladores de edição do texto
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Se o login for bem-sucedido, feche o loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle apenas se houver erro
      Navigator.pop(context);

      // EMAIL ERRADO
      if (e.code != null) {
        wrongEmailMessage();
      }
      // SENHA ERRADA
      else if (e.code != null) {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
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
            'A senha ou o e-mail estão errados, tente novamente!',
            style: TextStyle(
              color: Colors.blueGrey[800], // Cor do texto da mensagem
              fontSize: 18,
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
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void wrongPasswordMessage() {
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
            'A senha ou o e-mail estão errados.',
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
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 35,
                ),

                // Logo of branch Mind Sage - Foto da marca Mind Sage
                Image.asset(
                  'lib/Images/logo.png',
                  height: 100,
                ),

                const SizedBox(
                  height: 30,
                ),

                // welcome back, you've been missed! - bem vindo, sentimos sua falta!
                Text(
                  'Bem vindo de volta, faça seu Login!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                // username textfield - campo de username
                MyTextField(
                  controller: emailController,
                  labelText: 'Insira seu E-mail',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                // password textfield - campo de senha
                MyTextField(
                  controller: passwordController,
                  labelText: 'Insira sua Senha',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 5,
                ),

                // forgot password? - esqueceu sua senha?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu sua senha?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // sign in button - botão de logar
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(
                  height: 25,
                ),

                // or continue with... - ou continuar com...
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou continue com...',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ), //
                const SizedBox(
                  height: 15,
                ),
                // google sing in button - logar com o google
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => AuthPage().signInWithGoogle(context),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 3.5,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200], //
                        ),
                        child: Image.asset(
                          'lib/Images/google.png',
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // not a member? register now! - não tem cadastro? cadastre-se agora!

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Não tem cadastro?',
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Cadastre-se agora!",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
