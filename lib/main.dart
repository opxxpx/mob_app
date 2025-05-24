import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async'; // Importe para usar o Timer

// --- Modelos de Dados ---
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

// --- Widget do Cartão do Documento ---
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF154C91), // Cor da borda azul atualizada
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.only(left: 5.0),
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
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
                          color: Colors.grey.shade800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          if (document.flagImagePath != null)
                            Image.asset(
                              document.flagImagePath!,
                              width: 24,
                              height: 24,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            document.documentNumber,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Widget da Barra de Navegação Inferior ---
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
          icon:
              Icon(Icons.account_balance_wallet_outlined), // Ícone de carteira
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
      selectedItemColor: const Color(0xFF154C91), // Cor atualizada
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
    );
  }
}

// --- Tela "Novo" (com botão de cadastro de documento) ---
class NewDocumentScreen extends StatelessWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Documento'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Clique para adicionar um novo documento à sua carteira.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, // Ocupa a largura máxima
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Simulando cadastro de novo documento...')),
                    );
                    // Aqui você poderia adicionar a lógica real para cadastro,
                    // como navegar para um formulário de novo documento.
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF154C91), // Cor de fundo do botão
                    foregroundColor: Colors.white, // Cor do texto do botão
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'CADASTRAR NOVO DOCUMENTO',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

// --- Tela "Serviços" (2ª via sem navegar para QR Code) ---
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('2ª Solicitar 2ª via',
                style: TextStyle(fontSize: 16)),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              // Simula a criação da solicitação, sem navegar para o QR Code
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Solicitação de 2ª via criada com sucesso!')),
              );
              // Se precisar de uma tela de confirmação de 2ª via,
              // você navegaria para ela aqui.
            },
          ),
          const Divider(),
          // Adicione mais opções de serviço aqui
        ],
      ),
    );
  }
}

// --- Tela "Opções" ---
class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opções'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.lock, color: Color(0xFF154C91)),
            title: const Text('SENHA DO APLICATIVO'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('SENHA DO APLICATIVO clicado!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Color(0xFF154C91)),
            title: const Text('SOBRE'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('SOBRE clicado!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description, color: Color(0xFF154C91)),
            title: const Text('TERMOS DE USO'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('TERMOS DE USO clicado!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.security, color: Color(0xFF154C91)),
            title: const Text('POLÍTICA DE PRIVACIDADE'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('POLÍTICA DE PRIVACIDADE clicado!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.help, color: Color(0xFF154C91)),
            title: const Text('PERGUNTAS FREQUENTES'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('PERGUNTAS FREQUENTES clicado!');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.headset_mic, color: Color(0xFF154C91)),
            title: const Text('AJUDA'),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFF154C91)),
            onTap: () {
              debugPrint('AJUDA clicado!');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}

// --- Tela Principal "Minha Carteira" ---
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    const NewDocumentScreen(),
    const ServicesScreen(),
    const OptionsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Carteira',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Colors.grey),
          Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

// --- Conteúdo da Tela Inicial ---
class HomeScreenContent extends StatelessWidget {
  HomeScreenContent({super.key});

  final Document rgDigital = Document(
    title: 'CIN DIGITAL - SÃO PAULO',
    name: 'GUSTAVO AUGUSTO BARBAROTO DOS SANTOS',
    documentNumber: '410.490.708-10',
    flagImagePath: 'assets/sp_flag.png',
    frontImagePath: 'assets/frente.jpg',
    backImagePath: 'assets/verso.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DocumentCard(document: rgDigital),
        ],
      ),
    );
  }
}

// --- Tela de Detalhes do Documento (Com a linha indicadora e SafeArea) ---
class DocumentDetailScreen extends StatefulWidget {
  final Document document;
  final int initialViewIndex; // 0: Frente, 1: Verso, 2: QR Code

  const DocumentDetailScreen({
    super.key,
    required this.document,
    this.initialViewIndex = 0,
  });

  @override
  State<DocumentDetailScreen> createState() => _DocumentDetailScreenState();
}

class _DocumentDetailScreenState extends State<DocumentDetailScreen>
    with SingleTickerProviderStateMixin {
  int _currentViewIndex = 0;
  final DateTime _updatedDate = DateTime.now();

  String _qrData = '';
  late Timer _timer;
  late AnimationController _progressController;
  late Animation<double> _progressBarAnimation;
  int _qrCodeGenerationCount = 0;

  @override
  void initState() {
    super.initState();
    _currentViewIndex = widget.initialViewIndex;

    _generateQrData();
    _startQrCodeTimer();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    );

    _progressBarAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
          ..addListener(() {
            if (mounted) setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _progressController.reset();
            }
          });
    _progressController.forward();
  }

  @override
  void dispose() {
    _timer.cancel();
    _progressController.dispose();
    super.dispose();
  }

  void _generateQrData() {
    _qrCodeGenerationCount++;
    setState(() {
      _qrData =
          '${widget.document.documentNumber}-${DateTime.now().millisecondsSinceEpoch}gen$_qrCodeGenerationCount';
      debugPrint('Novo QR Data gerado: $_qrData');
    });
  }

  void _startQrCodeTimer() {
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      if (mounted) {
        _generateQrData();
        _progressController.forward(from: 0.0);
      }
    });
  }

  void _setView(int index) {
    setState(() {
      _currentViewIndex = index;
      if (_currentViewIndex == 2) {
        _generateQrData();
        _progressController.forward(from: 0.0);
      }
    });
  }

  String get _formattedDate => '${_updatedDate.day.toString().padLeft(2, '0')}/'
      '${_updatedDate.month.toString().padLeft(2, '0')}/'
      '${_updatedDate.year} às '
      '${_updatedDate.hour.toString().padLeft(2, '0')}:'
      '${_updatedDate.minute.toString().padLeft(2, '0')}';

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selecione uma das opções abaixo',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _showDetailsDialog(context);
              },
              title: const Center(
                child: Text('Ver detalhes',
                    style: TextStyle(color: Color(0xFF154C91), fontSize: 18)),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                _showExportDialog(context);
              },
              title: const Center(
                child: Text('Exportar',
                    style: TextStyle(color: Color(0xFF154C91), fontSize: 18)),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                debugPrint('Remover do meu dispositivo clicado!');
              },
              title: const Center(
                child: Text('Remover do meu dispositivo',
                    style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Colors.grey),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                debugPrint('Cancelar clicado!');
              },
              title: const Center(
                child: Text('Cancelar',
                    style: TextStyle(color: Colors.red, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalhes do Documento'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('DOCUMENTO DIGITAL SP',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(child: Text('EMITIDO EM')),
                    Text('27/03/2025'), // Hardcoded, ideally from document data
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Expanded(child: Text('VÁLIDO ATÉ')),
                    Text('27/03/2035'), // Hardcoded, ideally from document data
                  ],
                ),
                const SizedBox(height: 16),
                const Text('EMITIDO PARA'),
                Text(widget.document.name),
                Text(widget.document.documentNumber),
                const SizedBox(height: 16),
                const Text('EMISSOR'),
                const Text('POLICIA CIVIL DO ESTADO DE SAO PAULO'), // Hardcoded
                const SizedBox(height: 24),
                const Text('CAMINHO DE CERTIFICAÇÃO',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                const Text('NOME (CN)'),
                const Text('POLICIA CIVIL DO ESTADO DE SAO PAULO'), // Hardcoded
                const SizedBox(height: 16),
                const Text('UNIDADE ORGANIZACIONAL (OU)'),
                const Text('AC VALID BRASIL'), // Hardcoded
                const SizedBox(height: 16),
                const Text('ORGANIZAÇÃO (O)'),
                const Text('ICP-BRASIL'), // Hardcoded
                const SizedBox(height: 16),
                const Text('PAÍS (C)'),
                const Text('BR'), // Hardcoded
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar',
                  style: TextStyle(color: Color(0xFF154C91))),
            ),
          ],
        );
      },
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exportar Documento'),
          content: const Text('O documento será exportado em formato PDF.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Documento exportado com sucesso!')),
                );
                debugPrint('Documento exportado!');
              },
              child: const Text('Exportar',
                  style: TextStyle(color: Color(0xFF154C91))),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentView() {
    switch (_currentViewIndex) {
      case 0: // Frente
        return widget.document.frontImagePath != null
            ? Image.asset(
                widget.document.frontImagePath!,
                key: const ValueKey<int>(0),
                width: MediaQuery.of(context).size.width * 0.85,
                fit: BoxFit.contain,
              )
            : const Center(
                key: ValueKey<int>(0),
                child: Text('Imagem da frente não disponível'));
      case 1: // Verso
        return widget.document.backImagePath != null
            ? Image.asset(
                widget.document.backImagePath!,
                key: const ValueKey<int>(1),
                width: MediaQuery.of(context).size.width * 0.85,
                fit: BoxFit.contain,
              )
            : const Center(
                key: ValueKey<int>(1),
                child: Text('Imagem do verso não disponível'));
      case 2: // QR Code
        return Column(
          key: const ValueKey<int>(2),
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: LinearProgressIndicator(
                value: _progressBarAnimation.value,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF154C91)),
                minHeight: 3.0,
              ),
            ),
            const SizedBox(
                height: 20), // Mantido o espaço para afastar o QR Code
            QrImageView(
              data: _qrData,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.width * 0.6,
              gapless: false,
              embeddedImage: null,
              errorStateBuilder: (cxt, err) {
                return const Center(
                  child: Text(
                    'Ops! Algo deu errado ao gerar o QR Code.',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ],
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: () {
                  debugPrint('Botão Fechar clicado!');
                  Navigator.pop(context);
                },
                child: const Text(
                  'Fechar',
                  style: TextStyle(
                    color: Color(0xFF154C91),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(
              _currentViewIndex == 0
                  ? 'Frente'
                  : (_currentViewIndex == 1 ? 'Verso' : 'QR Code'),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () => _showOptionsMenu(context),
            ),
          ],
        ),
      ),
      // Aplicando SafeArea ao corpo principal da tela
      body: SafeArea(
        // Adicionado SafeArea aqui!
        child: Column(
          children: [
            const Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'Atualizado em $_formattedDate',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4), // ESPAÇO REDUZIDO AQUI
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      const double minSwipeVelocity = 50.0;

                      if (details.primaryVelocity! < -minSwipeVelocity) {
                        if (_currentViewIndex < 2) {
                          _setView(_currentViewIndex + 1);
                        }
                      } else if (details.primaryVelocity! > minSwipeVelocity) {
                        if (_currentViewIndex > 0) {
                          _setView(_currentViewIndex - 1);
                        }
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _buildCurrentView(),
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
                  // Icone Frente
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.person,
                            color: _currentViewIndex == 0
                                ? const Color(0xFF154C91)
                                : Colors.grey),
                        onPressed: () => _setView(0),
                      ),
                      // Linha indicadora para "Frente"
                      Container(
                        height: 3,
                        width: 30,
                        color: _currentViewIndex == 0
                            ? const Color(0xFF154C91)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                  // Icone Verso
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.fingerprint,
                            color: _currentViewIndex == 1
                                ? const Color(0xFF154C91)
                                : Colors.grey),
                        onPressed: () => _setView(1),
                      ),
                      // Linha indicadora para "Verso"
                      Container(
                        height: 3,
                        width: 30,
                        color: _currentViewIndex == 1
                            ? const Color(0xFF154C91)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                  // Icone QR Code
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.qr_code,
                            color: _currentViewIndex == 2
                                ? const Color(0xFF154C91)
                                : Colors.grey),
                        onPressed: () => _setView(2),
                      ),
                      // Linha indicadora para "QR Code"
                      Container(
                        height: 3,
                        width: 30,
                        color: _currentViewIndex == 2
                            ? const Color(0xFF154C91)
                            : Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Ponto de Entrada Principal do Aplicativo ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const MaterialColor customBlue = MaterialColor(
      0xFF154C91,
      <int, Color>{
        50: Color(0xFFE2E7F3),
        100: Color(0xFFB6C5E3),
        200: Color(0xFF869ECF),
        300: Color(0xFF5678BB),
        400: Color(0xFF325BAF),
        500: Color(0xFF154C91),
        600: Color(0xFF124589),
        700: Color(0xFF0E3D7D),
        800: Color(0xFF0B3572),
        900: Color(0xFF06285F),
      },
    );

    return MaterialApp(
      title: 'Minha Carteira Digital',
      theme: ThemeData(
        primarySwatch: customBlue,
        primaryColor: const Color(0xFF154C91),
        hintColor: Colors.grey,
        indicatorColor: const Color(0xFF154C91),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: customBlue,
          accentColor: const Color(0xFF154C91),
        ).copyWith(secondary: const Color(0xFF154C91)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF154C91),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF154C91),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
