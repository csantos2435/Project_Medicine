import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import necessário para máscara de input
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Pacote para mascarar o input
import 'SucessoScreen.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

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
      "Espirros Contínuos",
      "Tremores",
      "Calafrios",
      "Dor nas Articulações",
      "Dor de Estômago",
      "Acidez",
      "Úlceras na Língua",
      "Perda de Massa Muscular",
      "Vômito",
      "Queimação ao Urinar",
      "Manchas ao Urinar",
      "Fadiga",
      "Ganho de Peso",
      "Ansiedade",
      "Mãos e Pés Frios",
      "Mudanças de Humor",
      "Perda de Peso",
      "Inquietação",
      "Letargia",
      "Manchas na Garganta",
      "Nível Irregular de Açúcar",
      "Tosse",
      "Febre Alta",
      "Olhos Fundos",
      "Falta de Ar",
      "Suor",
      "Desidratação",
      "Indigestão",
      "Dor de Cabeça",
      "Pele Amarelada",
      "Urina Escura",
      "Náusea",
      "Perda de Apetite",
      "Dor Atrás dos Olhos",
      "Dor nas Costas",
      "Constipação",
      "Dor Abdominal",
      "Diarreia",
      "Febre Leve",
      "Urina Amarela",
      "Amarelamento dos Olhos",
      "Insuficiência Hepática Aguda",
      "Sobrecarga de Fluidos",
      "Inchaço do Estômago",
      "Linfonodos Inchados",
      "Mal-estar",
      "Visão Turva e Distorcida",
      "Catarro",
      "Irritação na Garganta",
      "Vermelhidão dos Olhos",
      "Pressão Sinusal",
      "Coriza",
      "Congestão",
      "Dor no Peito",
      "Fraqueza nos Membros",
      "Frequência Cardíaca Acelerada",
      "Dor Durante as Evacuações",
      "Dor na Região Anal",
      "Fezes com Sangue",
      "Irritação no Ânus",
      "Dor no Pescoço",
      "Tontura",
      "Cólicas",
      "Hematomas",
      "Obesidade",
      "Pernas Inchadas",
      "Vasos Sanguíneos Inchados",
      "Rosto e Olhos Inchados",
      "Tireoide Aumentada",
      "Unhas Quebradiças",
      "Extremidades Inchadas",
      "Fome Excessiva",
      "Contatos Extraconjugais",
      "Lábios Ressecados e Formigantes",
      "Fala Arrastada",
      "Dor no Joelho",
      "Dor na Articulação do Quadril",
      "Fraqueza Muscular",
      "Pescoço Rígido",
      "Articulações Inchadas",
      "Rigidez de Movimento",
      "Movimentos Giratórios",
      "Perda de Equilíbrio",
      "Instabilidade",
      "Fraqueza de um Lado do Corpo",
      "Perda do Olfato",
      "Desconforto na Bexiga",
      "Cheiro Fétido de Urina",
      "Sensação Contínua de Urina",
      "Passagem de Gases",
      "Coceira Interna",
      "Aparência Tóxica (Tifo)",
      "Depressão",
      "Irritabilidade",
      "Dor Muscular",
      "Sensório Alterado",
      "Manchas Vermelhas pelo Corpo",
      "Dor na Barriga",
      "Menstruação Anormal",
      "Manchas Discromicas",
      "Olhos Lacrimejantes",
      "Aumento do Apetite",
      "Poliúria",
      "Histórico Familiar",
      "Escarro Mucoide",
      "Escarro Enferrujado",
      "Falta de Concentração",
      "Distúrbios Visuais",
      "Recebendo Transfusão de Sangue",
      "Recebendo Injeções Não Esterilizadas",
      "Coma",
      "Sangramento Estomacal",
      "Distensão do Abdômen",
      "Histórico de Consumo de Álcool",
      "Sangue no Escarro",
      "Veias Proeminentes na Panturrilha",
      "Palpitações",
      "Caminhada Dolorosa",
      "Espinhas Cheias de Pus",
      "Cravos",
      "Escorrimento",
      "Descamação da Pele",
      "Poeira Prateada",
      "Pequenos Amassados nas Unhas",
      "Unhas Inflamatórias",
      "Bolha",
      "Ferida Vermelha ao Redor do Nariz",
      "Exsudação de Crosta Amarela"
  ];

  // Estado dos checkboxes
  List<bool> sintomasSelecionados = List<bool>.generate(132, (index) => false);

  // Variáveis de controle para grupos de sintomas
  int sintomasPorPagina = 10; // Número de sintomas por página
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

  // Função para compor e enviar o JSON à API
  Future<String> calcularDiagnostico() async {

    List<String> colunasSintomas = [
      "coceira",
      "erupcao_cutanea",
      "erupcoes_cutaneas_nodais",
      "espirros_continuos",
      "tremores",
      "calafrios",
      "dor_nas_articulacoes",
      "dor_de_estomago",
      "acidez",
      "ulceras_na_lingua",
      "perda_de_massa_muscular",
      "vomito",
      "queimacao_ao_urinar",
      "spotting__urination",
      "fadiga",
      "ganho_de_peso",
      "ansiedade",
      "maos_e_pes_frios",
      "mudancas_de_humor",
      "perda_de_peso",
      "inquietacao",
      "letargia",
      "manchas_na_garganta",
      "nivel_irregular_de_acucar",
      "tosse",
      "febre_alta",
      "olhos_fundos",
      "falta_de_ar",
      "suor",
      "desidratacao",
      "indigestao",
      "dor_de_cabeca",
      "pele_amarelada",
      "urina_escura",
      "nausea",
      "perda_de_apetite",
      "dor_atras_dos_olhos",
      "dor_nas_costas",
      "constipacao",
      "dor_abdominal",
      "diarreia",
      "febre_leve",
      "urina_amarela",
      "amarelamento_dos_olhos",
      "insuficiencia_hepatica_aguda",
      "sobrecarga_de_fluidos",
      "inchaco_do_estomago",
      "linfonodos_inchados",
      "mal_estar",
      "visao_turva_e_distorcida",
      "catarro",
      "irritacao_na_garganta",
      "vermelhidao_dos_olhos",
      "pressao_sinusal",
      "coriza",
      "congestao",
      "dor_no_peito",
      "fraqueza_nos_membros",
      "frequencia_cardiaca_acelerada",
      "dor_durante_as_evacuacoes",
      "dor_na_regiao_anal",
      "fezes_com_sangue",
      "irritacao_no_anus",
      "dor_no_pescoco",
      "tontura",
      "colicas",
      "hematomas",
      "obesidade",
      "pernas_inchadas",
      "vasos_sanguineos_inchados",
      "rosto_e_olhos_inchados",
      "tireoide_aumentada",
      "unhas_quebradicas",
      "extremidades_inchadas",
      "fome_excessiva",
      "contatos_extraconjugais",
      "labios_ressecados_e_formigantes",
      "fala_arrastada",
      "dor_no_joelho",
      "dor_na_articulacao_do_quadril",
      "fraqueza_muscular",
      "pescoço_rigido",
      "articulacoes_inchadas",
      "rigidez_de_movimento",
      "movimentos_giratorios",
      "perda_de_equilibrio",
      "instabilidade",
      "fraqueza_de_um_lado_do_corpo",
      "perda_do_olfato",
      "desconforto_na_bexiga",
      "foul_smell_of_urine",
      "sensacao_continua_de_urina",
      "passagem_de_gases",
      "coceira_interna",
      "aparencia_toxica_(tifo)",
      "depressao",
      "irritabilidade",
      "dor_muscular",
      "sensorio_alterado",
      "manchas_vermelhas_pelo_corpo",
      "dor_na_barriga",
      "menstruacao_anormal",
      "dischromic__patches",
      "olhos_lacrimejantes",
      "aumento_do_apetite",
      "poliuria",
      "historico_familiar",
      "escarro_mucoide",
      "escarro_enferrujado",
      "falta_de_concentracao",
      "disturbios_visuais",
      "recebendo_transfusao_de_sangue",
      "recebendo_injecoes_nao_esterilizadas",
      "coma",
      "sangramento_estomacal",
      "distensao_do_abdômen",
      "historico_de_consumo_de_alcool",
      "fluid_overload.1",
      "sangue_no_escarro",
      "veias_proeminentes_na_panturrilha",
      "palpitacoes",
      "caminhada_dolorosa",
      "espinhas_cheias_de_pus",
      "cravos",
      "escorrimento",
      "descamacao_da_pele",
      "poeira_prateada",
      "pequenos_amassados_nas_unhas",
      "unhas_inflamatorias",
      "bolha",
      "ferida_vermelha_ao_redor_do_nariz",
      "exsudacao_de_crosta_amarela"
    ];

    // Criando a lista de valores binários para os sintomas selecionados
    List<int> sintomasSelecionadosValores = List.generate(colunasSintomas.length, (index) {
      return sintomasSelecionados[index] ? 1 : 0;
    });

    // Montando o corpo do JSON
    Map<String, dynamic> jsonBody = {
      "input_data": {
        "columns": colunasSintomas,
        "index": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131],
        "data": [
          sintomasSelecionadosValores
        ]
      }
    };

    // URL da API e configuração do cabeçalho
    const String url = "https://api-machinelearningpredic-ojfdw.eastus2.inference.ml.azure.com/score";
    const String apiKey = "N1PdnnWGPcJLrgnz1nylNYqF5Z5QRL4Z";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
          "azureml-model-deployment": "api",
        },
        body: json.encode(jsonBody),
      );

      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);

          String textoDiagnostico;
          if (responseBody is List) {
            textoDiagnostico = responseBody.isNotEmpty ? responseBody[0].toString() : "Nenhum diagnóstico encontrado.";
          } else if (responseBody is Map) {
            textoDiagnostico = responseBody.toString();
          } else {
            throw Exception("Formato inesperado da resposta da API.");
          }

          // Traduzindo o texto usando Google Translator
          final translator = GoogleTranslator();
          final traduzido = await translator.translate(textoDiagnostico, from: 'en', to: 'pt');

          return traduzido.text;
      } else {
        throw Exception(
            "Erro na requisição: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      return "Erro ao calcular diagnóstico: $error";
    }

    
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
                    // Chamada da função que retorna o diagnótico
                    String diagnosticoCalculado = await calcularDiagnostico();

                    // Navegar para SucessoScreen e obter o resultado
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SucessoScreen(
                          nome: _nomeController.text,
                          cpf: _cpfController.text,
                          dataLancamento:_dataLancamentoController.text,
                          diagnostico: diagnosticoCalculado,
                          sintomasSelecionados: sintomasSelecionados
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
