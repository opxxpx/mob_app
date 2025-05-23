import 'package:flutter/material.dart';

// Modelo de Dados
class Document {
  final String title;
  final String name;
  final String documentNumber;
  final String? frontImagePath;
  final String? backImagePath;
  final String? flagImagePath;

  Document({
    required this.title,
    required this.name,
    required this.documentNumber,
    this.frontImagePath,
    this.backImagePath,
    this.flagImagePath,
  });
}

// Widget do Cartão do Documento
class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentDetailScreen(document: document),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (document.flagImagePath != null)
                    Image.asset(
                      document.flagImagePath!,
                      width: 24,
                      height: 24,
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      document.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                document.name,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                document.documentNumber,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget da Barra de Navegação Inferior
class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          label: 'Novo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps),
          label: 'Serviços',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tune),
          label: 'Opções',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
    );
  }
}

// Tela Principal "Minha Carteira"
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Lógica para navegar entre as telas, se houvesse outras telas
  }

  // Dados de exemplo para o RG Digital (Caminhos das imagens corrigidos)
  final Document rgDigital = Document(
    title: 'RG DIGITAL - SÃO PAULO',
    name: 'PEDRO AUGUSTO BARBAROTO DOS SANTOS',
    documentNumber: '00.000.000-0',
    flagImagePath: 'assets/sp_flag.png', // Caminho corrigido para sua estrutura
    frontImagePath: 'assets/foto1.jpg', // Caminho corrigido para sua estrutura
    backImagePath: 'assets/foto2.jpg', // Caminho corrigido para sua estrutura
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Carteira',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DocumentCard(document: rgDigital),
                  // Você pode adicionar mais DocumentCards aqui se tiver mais documentos
                ],
              ),
            ),
          ),
          CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ],
      ),
    );
  }
}

// Tela de Detalhes do Documento (com swipe e botões de alternância)
class DocumentDetailScreen extends StatefulWidget {
  final Document document;

  const DocumentDetailScreen({super.key, required this.document});

  @override
  State<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen> {
  bool _showFront = true; // Controla qual lado da imagem está visível

  // Função para alternar entre frente e verso (usada pelo swipe)
  void _toggleDocumentSide() {
    setState(() {
      _showFront = !_showFront;
    });
  }

  // Função para mostrar a frente (usada pelo ícone de pessoa)
  void _showFrontSide() {
    setState(() {
      _showFront = true;
    });
  }

  // Função para mostrar o verso (usada pelo ícone de digital)
  void _showBackSide() {
    setState(() {
      _showFront = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Botão "Fechar" no lugar do "X"
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Fechar',
            style: TextStyle(
              color: Colors.black, // Cor do texto "Fechar"
              fontSize: 16,
            ),
          ),
        ),
        title: Text(
          _showFront ? 'Frente' : 'Verso',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Ações para o menu de três pontos
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Atualizado em ${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year} às ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  // Detecta arrasto horizontal para alternar a imagem
                  onHorizontalDragEnd: (details) {
                    // Mínimo de velocidade para considerar um swipe
                    const double minSwipeVelocity = 50.0;

                    if (details.primaryVelocity! < -minSwipeVelocity) {
                      // Arrasto para a esquerda (mostra verso se estiver na frente)
                      if (_showFront && widget.document.backImagePath != null) {
                        _toggleDocumentSide();
                      }
                    } else if (details.primaryVelocity! > minSwipeVelocity) {
                      // Arrasto para a direita (mostra frente se estiver no verso)
                      if (!_showFront &&
                          widget.document.frontImagePath != null) {
                        _toggleDocumentSide();
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      // AnimatedSwitcher para a transição suave entre as imagens
                      child: AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 300), // Duração da animação
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          // Efeito de fade para a transição
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: _showFront
                            ? (widget.document.frontImagePath != null
                                ? Image.asset(
                                    widget.document.frontImagePath!,
                                    key: const ValueKey<bool>(
                                        true), // Chave essencial para AnimatedSwitcher
                                    fit: BoxFit.contain,
                                  )
                                : const Center(
                                    key: ValueKey<bool>(true),
                                    child: Text(
                                        'Imagem da frente não disponível')))
                            : (widget.document.backImagePath != null
                                ? Image.asset(
                                    widget.document.backImagePath!,
                                    key: const ValueKey<bool>(
                                        false), // Chave essencial para AnimatedSwitcher
                                    fit: BoxFit.contain,
                                  )
                                : const Center(
                                    key: ValueKey<bool>(false),
                                    child: Text(
                                        'Imagem do verso não disponível'))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.person), // Ícone de pessoa
                  onPressed: _showFrontSide, // Conectado para mostrar a frente
                ),
                IconButton(
                  icon: const Icon(Icons.fingerprint), // Ícone de digital
                  onPressed: _showBackSide, // Conectado para mostrar o verso
                ),
                IconButton(
                  icon: const Icon(Icons.qr_code), // Ícone de QR Code
                  onPressed: () {
                    // Ação ao clicar no ícone de QR Code
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 0,
        onItemTapped: null,
      ),
    );
  }
}

// O ponto de entrada principal do aplicativo
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Carteira Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
