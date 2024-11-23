import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _inputController = TextEditingController();
  final List<Map<String, String>> messages = [];
  final Map<String, String> knowledgeBase = {
    "como cadastrar um diagnóstico": "Clique no botão '+' e preencha os dados.",
    "como pesquisar um diagnóstico": "Use a barra de pesquisa na tela inicial.",
    "como editar um diagnóstico": "Selecione o diagnóstico desejado e edite os campos.",
    "como funciona o diagnóstico": "O diagnóstico analisa os dados fornecidos.",
    "como excluir um diagnóstico": "Selecione o diagnóstico e clique no botão 'Excluir'.",
    "como visualizar diagnósticos": "Os diagnósticos estão listados na tela inicial.",
    "como salvar um diagnóstico": "Preencha os campos e clique em 'Salvar'.",
    "como atualizar um diagnóstico": "Abra o diagnóstico, edite os dados e clique em 'Atualizar'.",
  };

  late final Fuzzy _fuzzyMatcher;

  @override
  void initState() {
    super.initState();
    _fuzzyMatcher = Fuzzy(knowledgeBase.keys.toList());
  }

  void _sendMessage(String question) {
    setState(() {
      messages.add({"type": "user", "text": question});
      final response = _getResponse(question);
      messages.add({"type": "bot", "text": response});
    });
    _inputController.clear();
  }

  String _getResponse(String question) {
    String normalizedQuestion = question.toLowerCase().trim();
    final result = _fuzzyMatcher.search(normalizedQuestion);

    if (result.isNotEmpty && result.first.score < 0.4) { // Threshold ajustável
      final matchedKey = result.first.item;
      return knowledgeBase[matchedKey]!;
    }

    return "Desculpe, não entendi sua pergunta. Tente reformulá-la.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
        backgroundColor: Color(0xFF0B8FAC),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUserMessage = message['type'] == 'user';
                return Align(
                  alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: 'Digite sua pergunta...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_inputController.text.trim().isNotEmpty) {
                      _sendMessage(_inputController.text);
                    }
                  },
                  child: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0B8FAC),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
