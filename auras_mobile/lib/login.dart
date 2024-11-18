import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'dashboard.dart'; // Importando a tela de Dashboard

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Text(
                    'Bem Vindo!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B8FAC),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),

              // Campo de Email
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Campo de Senha
              Text(
                'Senha',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // Esqueceu a senha? e Novo Cadastro na mesma linha
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      print("Esqueceu a senha clicado");
                    },
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Color(0xFF858585),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Botão de Login com navegação para o Dashboard
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovering = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovering = false;
                  });
                },
                child: ElevatedButton(
                  onPressed: () {
                    // Navega para a tela de Dashboard
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHovering
                        ? Color(0xFF0A7C94) // Cor quando o mouse está em cima
                        : Color(0xFF0B8FAC), // Cor padrão
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Text(
                  'Ou',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF858585),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Imagens do Facebook e Google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Login com Facebook clicado");
                    },
                    child: Image.asset(
                      'assets/images/facebook.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      print("Login com Google clicado");
                    },
                    child: Image.asset(
                      'assets/images/google.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Não possui cadastro? Cadastrar
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Não possui cadastro?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          color: Color(0xFF0B8FAC),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
