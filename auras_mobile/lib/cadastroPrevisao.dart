import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necessário para máscara de input
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Pacote para mascarar o input
import 'SucessoScreen.dart';

class CadastroPrevisaoScreen extends StatefulWidget {
  @override
  _CadastroPrevisaoScreenState createState() => _CadastroPrevisaoScreenState();
}

class _CadastroPrevisaoScreenState extends State<CadastroPrevisaoScreen> {
  // Controladores para os campos
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _dataLancamentoController = TextEditingController();

  // Formatação de máscara para CPF
  var cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  // Lista completa de sintomas
  List<String> sintomas = [
    "Coceira",
    "Erupção Cutânea",
    "Erupções Cutâneas Nodais",
    "Dor de Cabeça",
    "Febre",
    "Fadiga",
    "Dores Musculares",
    "Náusea",
    "Tontura",
    "Dor no Peito",
  ];

  // Estado dos checkboxes
  List<bool> sintomasSelecionados = List<bool>.generate(10, (index) => false);

  // Variáveis de controle para grupos de sintomas
  int sintomasPorPagina = 5; // Número de sintomas por página
  int paginaAtual = 0;

  // Função para exibir o DatePicker (seletor de data)
  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _dataLancamentoController.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  // Função para calcular o índice inicial e final dos sintomas na página atual
  List<String> _sintomasNaPagina() {
    int inicio = paginaAtual * sintomasPorPagina;
    int fim = (inicio + sintomasPorPagina).clamp(0, sintomas.length);
    return sintomas.sublist(inicio, fim);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ícone de seta para voltar
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 20),

              // Título "Nova Previsão"
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Nova Previsão',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B8FAC),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Mini título "Dados Pessoais"
              Text(
                'Dados Pessoais',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF858585),
                ),
              ),
              SizedBox(height: 10),

              // Campo de Nome
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // CPF e Data de Lançamento
              Row(
                children: [
                  // CPF
                  Expanded(
                    child: TextFormField(
                      controller: _cpfController,
                      inputFormatters: [cpfMaskFormatter],
                      decoration: InputDecoration(
                        hintText: 'CPF',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 20),

                  // Data de Lançamento
                  Expanded(
                    child: TextFormField(
                      controller: _dataLancamentoController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Data de Lançamento',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Mini título "Sintomas"
              Text(
                'Marque quais sintomas está sentindo:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF858585),
                ),
              ),
              SizedBox(height: 10),

              // Exibição dos checkboxes para os sintomas da página atual
              Column(
                children: _sintomasNaPagina().asMap().entries.map((entry) {
                  int index = paginaAtual * sintomasPorPagina + entry.key;
                  return CheckboxListTile(
                    title: Text(entry.value),
                    value: sintomasSelecionados[index],
                    onChanged: (value) {
                      setState(() {
                        sintomasSelecionados[index] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Botão "Próximo" ou "Calcular Resultado"
              ElevatedButton(
                onPressed: () async {
                  if ((paginaAtual + 1) * sintomasPorPagina < sintomas.length) {
                    setState(() {
                      paginaAtual++;
                    });
                  } else {
                    // Navegar para SucessoScreen e obter o resultado
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SucessoScreen(
                          nome: _nomeController.text,
                          cpf: _cpfController.text,
                          dataLancamento:_dataLancamentoController.text,
                          diagnostico: sintomasSelecionados
                              .asMap()
                              .entries
                              .where((entry) => entry.value)
                              .map((entry) => sintomas[entry.key])
                              .join(", "),
                        ),
                      ),
                    );

                    // Retornar os dados para DashboardScreen
                    if (result != null) {
                      Navigator.pop(context, result);
                    }
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0B8FAC),
                ),
                child: Text(
                  (paginaAtual + 1) * sintomasPorPagina < sintomas.length
                      ? "Próximo"
                      : "Calcular Resultado",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
