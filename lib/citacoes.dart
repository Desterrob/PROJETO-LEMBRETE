import 'package:flutter/material.dart';
import 'package:share/share.dart';


class Citacao {
  final String autor;
  final String texto;
  int numeroDeCurtidas = 0;
  bool salva = false;
  bool feliz = false;


  Citacao({required this.autor, required this.texto});
}


class CitacoesPage extends StatefulWidget {
  const CitacoesPage({super.key});


  @override
  _CitacoesPageState createState() => _CitacoesPageState();


  static initializeApp() {}
}


class _CitacoesPageState extends State<CitacoesPage> {
  final List<Citacao> citacoes = [
    Citacao(
      autor: 'Albert Einstein',
      texto: 'A imaginação é mais importante que o conhecimento.',
    ),
    Citacao(
      autor: 'William Shakespeare',
      texto: 'Ser ou não ser, eis a questão.',
    ),
    Citacao(
      autor: 'Mahatma Gandhi',
      texto: 'Seja a mudança que você deseja ver no mundo.',
    ),


    Citacao(
      autor: 'Robert Collier',
      texto: "O sucesso é a soma de pequenos esforços repetidos dia após dia."
      ),
      Citacao(
        autor: 'Confúcio',
        texto: "Nao importa o quão devagar você vá , desde que não pare."
        )
  ];


  List<Citacao> citacoesFiltradas = [];


  @override
  void initState() {
    super.initState();
    citacoesFiltradas.addAll(citacoes);
  }


  void filtrarCategorias({bool? triste, bool? feliz}) {
    setState(() {
      citacoesFiltradas = citacoes.where((citacao) {
        if (triste != null && triste && citacao.feliz) {
          return false;
        }
        if (feliz != null && feliz && !citacao.feliz) {
          return false;
        }
        return true;
      }).toList();
    });
  }


  void filtrarPorPesquisa(String pesquisa) {
    setState(() {
      citacoesFiltradas = citacoes.where((citacao) {
        return citacao.autor.toLowerCase().contains(pesquisa.toLowerCase()) ||
            citacao.texto.toLowerCase().contains(pesquisa.toLowerCase());
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('  Citações '),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                showFilterDialog();
              },
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearchDialog();
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.blue[100],
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: citacoesFiltradas.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('"${citacoesFiltradas[index].texto}"'),
                      const SizedBox(height: 8),
                      Text('- ${citacoesFiltradas[index].autor}'),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite,
                          color:
                           citacoes[index].numeroDeCurtidas >0 ?
                           Colors.red :Colors.grey
                           ),
                            onPressed: () {
                              setState(() {
                                citacoesFiltradas[index].numeroDeCurtidas++;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {
                              Share.share(
                                '${citacoesFiltradas[index].texto} - ${citacoesFiltradas[index].autor}',
                                subject: 'Citação de ${citacoesFiltradas[index].autor}',
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.save, color: citacoesFiltradas[index].salva ? Colors.blue : Colors.grey),
                            onPressed: () {
                              setState(() {
                                citacoesFiltradas[index].salva = !citacoesFiltradas[index].salva;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.mood_bad, color: citacoesFiltradas[index].feliz ? Colors.grey : Colors.blue),
                            onPressed: () {
                              setState(() {
                                citacoesFiltradas[index].feliz = !citacoesFiltradas[index].feliz;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.mood, color: citacoesFiltradas[index].feliz ? Colors.blue : Colors.grey),
                            onPressed: () {
                              setState(() {
                                citacoesFiltradas[index].feliz = !citacoesFiltradas[index].feliz;
                              });
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Curtidas: ${citacoesFiltradas[index].numeroDeCurtidas}',
                        style: const TextStyle(fontSize: 12),
                      ),],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdicionarCitacaoPage()),
            );


            if (result != null && result is Citacao) {
              setState(() {
                citacoes.add(result);
                filtrarCategorias();
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }


  Future<void> showFilterDialog() async {
    bool? triste = false;
    bool? feliz = false;


    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtrar por Categorias'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  CheckboxListTile(
                    title: const Text('Triste'),
                    value: triste,
                    onChanged: (bool? value) {
                      setState(() {
                        triste = value;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Feliz'),
                    value: feliz,
                    onChanged: (bool? value) {
                      setState(() {
                        feliz = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                filtrarCategorias(triste: triste, feliz: feliz);
                Navigator.of(context).pop();
              },
              child: const Text('Filtrar'),
            ),
          ],
        );
      },
    );
  }


  Future<void> showSearchDialog() async {
    String pesquisa = '';


    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pesquisar Citações'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        pesquisa = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Digite sua pesquisa'),
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                filtrarPorPesquisa(pesquisa);
                Navigator.of(context).pop();
              },
              child: const Text('Pesquisar'),
            ),
          ],
        );
      },
    );
  }
}


class AdicionarCitacaoPage extends StatelessWidget {
  final TextEditingController autorController = TextEditingController();
  final TextEditingController textoController = TextEditingController();


  AdicionarCitacaoPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Citação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: autorController,
              decoration: const InputDecoration(labelText: 'Autor'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: textoController,
              decoration: const InputDecoration(labelText: 'Texto da Citação'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final novaCitacao = Citacao(
                  autor: autorController.text,
                  texto: textoController.text,
                );


                Navigator.pop(context, novaCitacao);
              },
              child: const Text('Adicionar Citação'),
            ),
          ],
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Citações',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Página Inicial'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CitacoesPage()),
              );
            },
            child: const Text('Ver Citações'),
          ),
        ),
      ),
    );
  }
}


