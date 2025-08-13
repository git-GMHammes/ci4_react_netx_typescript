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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autenticação em andamento...')),
      );
      if (kDebugMode) {
        print('Usuário: ${_usuarioController.text}');
      }
      // Aqui você faria a chamada para autenticar o usuário.
    }
  }

  // Widget do campo de usuário (ativo)
  Widget _buildUsuarioField() {
    return TextFormField(
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
    );
  }

  // Widget do campo de senha (desabilitado)
  Widget _buildSenhaField() {
    return TextFormField(
      controller: _senhaController,
      obscureText: _obscureText,
      enabled: false, // desabilitado
      decoration: InputDecoration(
        labelText: 'Senha',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: null, // desabilitado
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  // Widget do campo de token (desabilitado)
  Widget _buildTokenField() {
    return TextFormField(
      controller: _tokenController,
      enabled: false, // desabilitado
      decoration: const InputDecoration(
        labelText: 'Token',
        prefixIcon: Icon(Icons.vpn_key),
        border: OutlineInputBorder(),
      ),
    );
  }

  // Widget do campo de perfil (dropdown desabilitado)
  Widget _buildPerfilDropdown() {
    return DropdownButtonFormField<String>(
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
      onChanged: null, // desabilitado
    );
  }

  // Widget do botão de entrar
  Widget _buildEntrarButton() {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        'ENTRAR',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Widget do link de recuperação de senha (desabilitado)
  Widget _buildEsqueceuSenha() {
    return TextButton(
      onPressed: null, // desabilitado
      child: const Text('Esqueceu sua senha?'),
    );
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

                  // Campos do formulário usando os widgets criados
                  _buildUsuarioField(),
                  const SizedBox(height: 16),

                  _buildSenhaField(),
                  const SizedBox(height: 16),

                  _buildTokenField(),
                  const SizedBox(height: 16),

                  _buildPerfilDropdown(),
                  const SizedBox(height: 32),

                  _buildEntrarButton(),
                  const SizedBox(height: 16),

                  _buildEsqueceuSenha(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}