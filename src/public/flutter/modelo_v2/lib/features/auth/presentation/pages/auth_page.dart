import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();
  final _tokenController = TextEditingController();

  // Agora, o perfil é um Map de chave em inglês para valor em português
  final Map<String, String> _perfis = {
    'admin': 'Administrador',
    'user': 'Usuário',
    'client': 'Cliente',
    'seller': 'Vendedor',
    'supplier': 'Fornecedor',
  };

  String _perfilSelecionado = 'user';
  bool _obscureText = true;

  @override
  void dispose() {
    _usuarioController.dispose();
    _senhaController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Processar dados do formulário
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autenticação em andamento...')),
      );

      // Simulação de autenticação
      if (kDebugMode) {
        print('Usuário: ${_usuarioController.text}');
      }
      if (kDebugMode) {
        print('Senha: ${_senhaController.text}');
      }
      if (kDebugMode) {
        print('Token: ${_tokenController.text}');
      }
      if (kDebugMode) {
        print('Perfil (key): $_perfilSelecionado');
      }

      // Aqui você faria a chamada para autenticar o usuário, enviando a chave (em inglês)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autenticação'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo ou ícone
                  const Icon(
                    Icons.lock_outlined,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),

                  // Título
                  const Text(
                    'Acesso ao Sistema',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),

                  // Campo de Usuário
                  TextFormField(
                    controller: _usuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Usuário',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome de usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de Senha
                  TextFormField(
                    controller: _senhaController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de Token
                  TextFormField(
                    controller: _tokenController,
                    decoration: const InputDecoration(
                      labelText: 'Token',
                      prefixIcon: Icon(Icons.vpn_key),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o token de autenticação';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo de Perfil (Dropdown)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Perfil',
                      prefixIcon: Icon(Icons.badge),
                      border: OutlineInputBorder(),
                    ),
                    value: _perfilSelecionado,
                    items: _perfis.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _perfilSelecionado = newValue;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione um perfil';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),

                  // Botão de Entrar
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Link para recuperação de senha
                  TextButton(
                    onPressed: () {
                      // Navegar para página de recuperação de senha
                    },
                    child: const Text('Esqueceu sua senha?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}