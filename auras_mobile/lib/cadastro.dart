import 'package:flutter/material.dart';
import 'login.dart'; // Certifique-se de importar a tela de login

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isHovering = false; // Variável para controlar o estado de hover

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Seta de voltar para a tela de login
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF0B8FAC), size: 30),
                  onPressed: () {
                    Navigator.pop(context); // Volta para a tela anterior (login)
                  },
                ),
              ),
              SizedBox(height: 20),

              // Título "Cadastro de Usuário"
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Cadastro de Usuário',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B8FAC),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),

              // Campo de Nome de Usuário
              Text(
                'Nome de Usuário',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

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

              // Campo de Confirmar Senha
              Text(
                'Confirma Senha',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),

              // Botão "Inscreva-se" com hover
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
                    print("Inscreva-se clicado");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHovering
                        ? Color(0xFF0A7C94) // Cor quando o mouse está em cima
                        : Color(0xFF0B8FAC), // Cor padrão
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                      side: BorderSide(
                        color: Colors.white, // Cor da borda
                        width: 2, // Largura da borda
                      ),
                    ),
                  ),
                  child: Text(
                    'Inscreva-se',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Espaço abaixo do botão "Inscreva-se"
              SizedBox(height: 20),

              // "Ou" para login com redes sociais
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
                      print("Cadastro com Facebook clicado");
                    },
                    child: Image.asset(
                      'assets/images/facebook.png', // Coloque o caminho correto da imagem
                      width: 50,
                      height: 50,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      print("Cadastro com Google clicado");
                    },
                    child: Image.asset(
                      'assets/images/google.png', // Coloque o caminho correto da imagem
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50), // Espaço no final da tela
            ],
          ),
        ),
      ),
    );
  }
}
