import 'package:flutter/material.dart';
import 'cadastroPrevisao.dart';
import 'detalhesDiagnosticoScreen.dart'; // Importando a tela de detalhes

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, String>> diagnosticos = [];
  TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredDiagnosticos = [];

  @override
  void initState() {
    super.initState();
    filteredDiagnosticos = diagnosticos;
    _searchController.addListener(_filterDiagnosticos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterDiagnosticos);
    super.dispose();
  }

  void _filterDiagnosticos() {
    setState(() {
      filteredDiagnosticos = diagnosticos.where((diagnostico) {
        return diagnostico['nome']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            diagnostico['cpf']!.contains(_searchController.text);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  'Diagnósticos',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B8FAC),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar diagnósticos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDiagnosticos.length,
                itemBuilder: (context, index) {
                  final diagnostico = filteredDiagnosticos[index];
                  return Card(
                    color: Color(0xFFD2EBE7),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        diagnostico['nome'] ?? 'Sem nome',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lançamento: ${diagnostico['dataLançamento']}'),
                          Text('Diagnóstico: ${diagnostico['diagnostico']}'),
                        ],
                      ),
                      onTap: () {
                        // Ao clicar no card, navegar para a tela de detalhes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesDiagnosticoScreen(
                              diagnostico: diagnostico,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CadastroPrevisaoScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              diagnosticos.add(result);
              _filterDiagnosticos();
            });
          }
        },
        backgroundColor: Color(0xFF0B8FAC),
        child: Icon(Icons.add, size: 40),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
