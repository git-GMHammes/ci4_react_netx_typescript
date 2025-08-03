import 'package:flutter/material.dart';

class AuthInstructionsPage extends StatelessWidget {
  final Map<String, dynamic>? cadastro;

  const AuthInstructionsPage({super.key, this.cadastro});

  @override
  Widget build(BuildContext context) {
    String showOrWarn(String? v) =>
        (v == null || v.isEmpty) ? "Não passado!!" : v;

    final nome = showOrWarn(cadastro?['nome']);
    final email = showOrWarn(cadastro?['email']);
    final whatsapp = showOrWarn(cadastro?['whatsapp']);
    final endereco = showOrWarn(cadastro?['endereco']);

    return Scaffold(
      appBar: AppBar(title: const Text('Instruções de Autenticação')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mark_email_read, size: 60, color: Colors.blueAccent),
            const SizedBox(height: 16),
            Text(
              'Cadastro realizado com sucesso!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Nome: $nome\nE-mail: $email\nWhatsApp: $whatsapp\nEndereço: $endereco',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Você receberá um e-mail com seu login e instruções de validação.\n'
              'Por favor, siga as orientações para finalizar seu acesso.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
