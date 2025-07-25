import 'package:flutter/material.dart';
// Para contagem de Texto
import 'package:flutter/services.dart';
// Para CPF:
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final _emailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _whatsappController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    _cepController.dispose();
    _enderecoController.dispose();
    // NÃO coloque _cpfMaskFormatter.dispose();
    super.dispose();
  }

  Widget buildNomeField() {
    return TextFormField(
      controller: _nomeController,
      decoration: const InputDecoration(
        labelText: 'Nome',
        border: OutlineInputBorder(),
      ),
      maxLength: 150,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÀ-ú\s]")),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu nome';
        }
        if (!RegExp(r"^[A-Za-zÀ-ú\s]+$").hasMatch(value)) {
          return 'Apenas letras são permitidas';
        }
        if (value.length > 150) {
          return 'O nome deve ter no máximo 150 caracteres';
        }
        return null;
      },
    );
  }

  Widget buildCpfField() {
    return TextFormField(
      controller: _cpfController,
      decoration: const InputDecoration(
        labelText: 'CPF',
        border: OutlineInputBorder(),
        hintText: '000.000.000-00',
        // NÃO coloque counterText: ''
      ),
      keyboardType: TextInputType.number,
      maxLength: 14, // 000.000.000-00
      inputFormatters: [_cpfMaskFormatter],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu CPF';
        }
        String onlyNumbers = _cpfMaskFormatter.getUnmaskedText();
        if (onlyNumbers.length != 11) {
          return 'CPF deve ter 11 dígitos';
        }
        if (!_cpfMaskFormatter.isFill()) {
          return 'Preencha o CPF completo';
        }
        return null;
      },
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        hintText: 'exemplo@email.com',
      ),
      keyboardType: TextInputType.emailAddress,
      maxLength: 151, // Para garantir limite total
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        final text = _emailController.text;
        final parts = text.split('@');
        final beforeAt = parts.isNotEmpty ? parts[0] : '';
        final afterAt = parts.length > 1 ? parts[1] : '';
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${beforeAt.length}/100 antes do @',
              style: TextStyle(fontSize: 12),
            ),
            Text(
              '${afterAt.length}/50 após o @',
              style: TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu email';
        }
        final parts = value.split('@');
        if (parts.length != 2) return 'O email deve conter apenas um @';
        final local = parts[0];
        final domain = parts[1];
        if (local.length > 100)
          return 'A parte antes do @ deve ter até 100 caracteres';
        if (domain.length > 50)
          return 'A parte depois do @ deve ter até 50 caracteres';
        if (!domain.contains('.'))
          return 'O domínio deve conter ao menos um ponto (.) após o @';
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );
        if (!emailRegex.hasMatch(value))
          return 'Por favor, insira um email válido';
        return null;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Processar os dados - em um app real você enviaria para uma API ou banco de dados
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário enviado com sucesso!')),
      );

      // Aqui você pode adicionar código para salvar os dados ou navegar para outra página
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Formulário de Contato')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ícone circular de contato
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24.0),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Icon(
                        Icons.contact_page,
                        size: 160,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Campo Nome
                buildNomeField(),
                const SizedBox(height: 16.0),

                // Campo CPF
                buildCpfField(),
                const SizedBox(height: 16.0),
                
                // Campo E-mail
                buildEmailField(),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _whatsappController,
                  decoration: const InputDecoration(
                    labelText: 'WhatsApp',
                    border: OutlineInputBorder(),
                    hintText: '(99) 99999-9999',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu WhatsApp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    hintText: '(99) 99999-9999',
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _dataNascimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                    hintText: 'AAAA-MM-DD',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    // Validação simples do formato
                    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!regex.hasMatch(value)) {
                      return 'Formato deve ser AAAA-MM-DD';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _cepController,
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(),
                    hintText: '00000-000',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CEP';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Aqui você poderia adicionar uma função para buscar o endereço pelo CEP
                    if (value.length == 8) {
                      // Buscar endereço pelo CEP
                    }
                  },
                ),
                const SizedBox(height: 16.0),

                TextFormField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu endereço';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24.0),

                Container(
                  margin: const EdgeInsets.only(
                    bottom: 48.0,
                  ), // margem inferior
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('ENVIAR', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
