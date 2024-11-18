import 'package:flutter/material.dart';

class DetalhesDiagnosticoScreen extends StatelessWidget {
  final Map<String, String> diagnostico;

  // Construtor que recebe o diagnóstico selecionado
  DetalhesDiagnosticoScreen({required this.diagnostico});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Diagnóstico'),
        backgroundColor: Color(0xFFD2EBE7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome
            _buildFieldWithLine('Nome', diagnostico['nome'] ?? 'Sem nome'),
            SizedBox(height: 20),

            // CPF
            _buildFieldWithLine('CPF', diagnostico['cpf'] ?? 'Sem CPF'),
            SizedBox(height: 20),

            // Data de Lançamento
            _buildFieldWithLine('Lançamento', diagnostico['dataLancamento'] ?? 'Sem data de Lançamento'),
            SizedBox(height: 20),

            // Diagnóstico
            _buildFieldWithLine('Diagnóstico', diagnostico['diagnostico'] ?? 'Sem diagnóstico'),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Função que cria o label e o campo com a linha preta abaixo
  Widget _buildFieldWithLine(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Cor do texto do label
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(fontSize: 18), // Estilo do texto exibido
        ),
        Divider(
          thickness: 1,
          color: Colors.black, // Linha preta abaixo
        ),
      ],
    );
  }
}
