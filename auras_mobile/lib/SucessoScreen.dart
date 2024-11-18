import 'package:flutter/material.dart';

class SucessoScreen extends StatelessWidget {
  final String nome;
  final String cpf;
  final String dataLancamento;
  final String diagnostico;

  SucessoScreen({
    required this.nome,
    required this.cpf,
    required this.dataLancamento,
    required this.diagnostico,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/Group 8.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Doença Prevista com sucesso!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B8FAC),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildFieldWithLine('Nome', nome),
              SizedBox(height: 10),
              _buildFieldWithLine('CPF', cpf),
              SizedBox(height: 10),
              _buildFieldWithLine('Data de Lançamento', dataLancamento),
              SizedBox(height: 10),
              _buildFieldWithLine('Diagnóstico', diagnostico),
              SizedBox(height: 40),
             ElevatedButton(
                onPressed: () {
                  // Retorna os dados para a DashboardScreen
                  Navigator.pop(context, {
                    'nome': nome,
                    'cpf': cpf,
                    'dataLancamento': dataLancamento,
                    'diagnostico': diagnostico,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B8FAC),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldWithLine(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF0B8FAC),
          ),
        ),
        SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 18),
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}
