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
        if (local.length > 100) {
          return 'A parte antes do @ deve ter até 100 caracteres';
        }
        if (domain.length > 50) {
          return 'A parte depois do @ deve ter até 50 caracteres';
        }
        if (!domain.contains('.')) {
          return 'O domínio deve conter ao menos um ponto (.) após o @';
        }
        final emailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );
        if (!emailRegex.hasMatch(value)) {
          return 'Por favor, insira um email válido';
        }
        return null;
      },
    );
  }

  Widget buildWhatsappField() {
    final whatsappMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _whatsappController,
      decoration: const InputDecoration(
        labelText: 'WhatsApp',
        border: OutlineInputBorder(),
        hintText: '(99) 99999-9999',
      ),
      keyboardType: TextInputType.phone,
      maxLength: 15, // (99) 99999-9999
      inputFormatters: [
        whatsappMaskFormatter,
        FilteringTextInputFormatter.allow(RegExp(r'[0-9()\s-]')),
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        // Mensagem de erro dinâmica
        String? error;
        String unmasked = whatsappMaskFormatter.getUnmaskedText();

        if (_whatsappController.text.isEmpty) {
          error = 'Por favor, insira seu WhatsApp';
        } else if (unmasked.length < 11) {
          error = 'Digite todos os números do WhatsApp';
        } else if (!RegExp(
          r'^[0-9()\s-]+$',
        ).hasMatch(_whatsappController.text)) {
          error = 'Apenas números e símbolos (), - são permitidos';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            Text(
              '$currentLength/15 caracteres',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        String unmasked = whatsappMaskFormatter.getUnmaskedText();
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu WhatsApp';
        }
        if (unmasked.length < 11) {
          return 'Digite todos os números do WhatsApp';
        }
        if (!RegExp(r'^[0-9()\s-]+$').hasMatch(value)) {
          return 'Apenas números e símbolos (), - são permitidos';
        }
        return null;
      },
    );
  }

  Widget buildTelefoneField() {
    final telefoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _telefoneController,
      decoration: const InputDecoration(
        labelText: 'Telefone',
        border: OutlineInputBorder(),
        hintText: '(99) 99999-9999',
      ),
      keyboardType: TextInputType.phone,
      maxLength: 15, // (99) 99999-9999
      inputFormatters: [
        telefoneMaskFormatter,
        FilteringTextInputFormatter.allow(RegExp(r'[0-9()\s-]')),
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        // Mensagem de erro dinâmica
        String? error;
        String unmasked = telefoneMaskFormatter.getUnmaskedText();

        if (_telefoneController.text.isEmpty) {
          error = 'Por favor, insira seu Telefone';
        } else if (unmasked.length < 11) {
          error = 'Digite todos os números do Telefone';
        } else if (!RegExp(
          r'^[0-9()\s-]+$',
        ).hasMatch(_telefoneController.text)) {
          error = 'Apenas números e símbolos (), - são permitidos';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            Text(
              '$currentLength/15 caracteres',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        String unmasked = telefoneMaskFormatter.getUnmaskedText();
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu Telefone';
        }
        if (unmasked.length < 11) {
          return 'Digite todos os números do Telefone';
        }
        if (!RegExp(r'^[0-9()\s-]+$').hasMatch(value)) {
          return 'Apenas números e símbolos (), - são permitidos';
        }
        return null;
      },
    );
  }

  Widget buildSenhaField() {
    return TextFormField(
      controller: _senhaController,
      decoration: const InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      maxLength: 32,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma senha';
        }
        if (value.length < 6) {
          return 'A senha deve ter pelo menos 6 caracteres';
        }
        if (value.length > 32) {
          return 'A senha deve ter no máximo 32 caracteres';
        }
        if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
          return 'A senha deve conter ao menos uma letra';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'A senha deve conter ao menos um número';
        }

        // Regex para caracteres especiais (sem a aspa simples problemática)
        if (!RegExp(
          r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:'<\.>\/\?\\|`~]''',
        ).hasMatch(value)) {
          return 'A senha deve conter ao menos um caractere especial';
        }

        // Regex para repetições corrigida
        if (RegExp(r'(.)\1{2,}').hasMatch(value)) {
          return 'Não use repetições como 111, aaa, \$\$\$';
        }

        // Não aceitar sequências simples
        List<String> seqs = [
          '012',
          '123',
          '234',
          '345',
          '456',
          '567',
          '678',
          '789',
          '890',
          '210',
          '321',
          '432',
          '543',
          '654',
          '765',
          '876',
          '987',
          '098',
          '0123',
          '1234',
          '2345',
          '3456',
          '4567',
          '5678',
          '6789',
          '7890',
          '4321',
          '5432',
          '6543',
          '7654',
          '8765',
          '9876',
          '0987',
          '2109',
        ];
        for (final seq in seqs) {
          if (value.contains(seq)) {
            return 'Não use sequências como $seq';
          }
        }
        return null;
      },
    );
  }

  Widget buildDataNascimentoField() {
    final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _dataNascimentoController,
      decoration: const InputDecoration(
        labelText: 'Data de Nascimento',
        border: OutlineInputBorder(),
        hintText: 'DD/MM/AAAA',
      ),
      keyboardType: TextInputType.number,
      maxLength: 10, // DD/MM/AAAA
      inputFormatters: [
        dateMaskFormatter,
        FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        String? ageText;
        String? error;

        String unmasked = dateMaskFormatter.getUnmaskedText();

        if (_dataNascimentoController.text.isEmpty) {
          error = 'Por favor, insira sua data de nascimento';
        } else if (unmasked.length < 8) {
          error = 'Digite a data completa';
        } else if (unmasked.length == 8) {
          try {
            // Converter DD/MM/AAAA para AAAA-MM-DD
            String day = unmasked.substring(0, 2);
            String month = unmasked.substring(2, 4);
            String year = unmasked.substring(4, 8);

            int dayInt = int.parse(day);
            int monthInt = int.parse(month);
            int yearInt = int.parse(year);

            // Validações básicas
            if (monthInt < 1 || monthInt > 12) {
              error = 'Mês inválido';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    error!,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    '$currentLength/10 caracteres',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }

            if (dayInt < 1 || dayInt > 31) {
              error = 'Dia inválido';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    error!,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    '$currentLength/10 caracteres',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }

            final birthDate = DateTime(yearInt, monthInt, dayInt);
            final now = DateTime.now();

            // Validação de data no futuro
            if (birthDate.isAfter(now)) {
              error = 'Data não pode ser no futuro';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    error!,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    '$currentLength/10 caracteres',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }

            int age = now.year - birthDate.year;
            if (now.month < birthDate.month ||
                (now.month == birthDate.month && now.day < birthDate.day)) {
              age--;
            }

            // VALIDAÇÃO DE 100 ANOS NO BUILDCOUNTER TAMBÉM!
            if (age > 100) {
              error = 'Idade não pode ser superior a 100 anos';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    error!,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    '$currentLength/10 caracteres',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }

            // VALIDAÇÃO DE MENOR DE IDADE NO BUILDCOUNTER TAMBÉM!
            if (age < 18) {
              error = 'Você deve ter pelo menos 18 anos';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    error!,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                  Text(
                    '$currentLength/10 caracteres',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }

            ageText = '$age anos';
            error = null;
          } catch (e) {
            error = 'Data inválida';
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              )
            else if (ageText != null)
              Text(
                ageText,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            Text(
              '$currentLength/10 caracteres',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        String unmasked = dateMaskFormatter.getUnmaskedText();

        if (value == null || value.isEmpty) {
          return 'Por favor, insira sua data de nascimento';
        }

        if (unmasked.length != 8) {
          return 'Digite a data completa';
        }

        if (!RegExp(r'^[0-9/]+$').hasMatch(value)) {
          return 'Apenas números e / são permitidos';
        }

        try {
          // Converter DD/MM/AAAA para validação
          String day = unmasked.substring(0, 2);
          String month = unmasked.substring(2, 4);
          String year = unmasked.substring(4, 8);

          int dayInt = int.parse(day);
          int monthInt = int.parse(month);
          int yearInt = int.parse(year);

          if (monthInt < 1 || monthInt > 12) {
            return 'Mês inválido';
          }

          if (dayInt < 1 || dayInt > 31) {
            return 'Dia inválido';
          }

          final birthDate = DateTime(yearInt, monthInt, dayInt);
          final now = DateTime.now();

          // 1) Não pode ter mais de 100 anos
          int age = now.year - birthDate.year;
          if (now.month < birthDate.month ||
              (now.month == birthDate.month && now.day < birthDate.day)) {
            age--;
          }

          if (age > 100) {
            return 'Data de nascimento não pode ser superior a 100 anos';
          }

          // 2) Deve ser maior de idade (18 anos)
          if (age < 18) {
            return 'Você deve ter pelo menos 18 anos para se cadastrar';
          }

          if (birthDate.isAfter(now)) {
            return 'Data de nascimento não pode ser no futuro';
          }
        } catch (e) {
          return 'Data inválida';
        }

        return null;
      },
    );
  }

  Widget buildCepField() {
    final cepMaskFormatter = MaskTextInputFormatter(
      mask: '##.###-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _cepController,
      decoration: const InputDecoration(
        labelText: 'CEP',
        border: OutlineInputBorder(),
        hintText: '00.000-000',
      ),
      keyboardType: TextInputType.number,
      maxLength: 10, // 00.000-000 = 10 caracteres
      inputFormatters: [
        cepMaskFormatter,
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9.-]'),
        ), // ADICIONADO O PONTO!
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        String? error;
        String unmasked = cepMaskFormatter.getUnmaskedText();

        if (_cepController.text.isEmpty) {
          error = 'Por favor, insira seu CEP';
        } else if (unmasked.length < 8) {
          error = 'Digite o CEP completo';
        } else if (!RegExp(r'^[0-9.-]+$').hasMatch(_cepController.text)) {
          // ADICIONADO O PONTO!
          error = 'Apenas números, ponto e hífen são permitidos';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            Text(
              '$currentLength/10 caracteres', // CORRIGIDO PARA 10!
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      onChanged: (value) {
        String unmasked = cepMaskFormatter.getUnmaskedText();
        if (unmasked.length == 8) {
          // Aqui você poderia adicionar uma função para buscar o endereço pelo CEP
          print('CEP completo: $unmasked');
        }
      },
      validator: (value) {
        String unmasked = cepMaskFormatter.getUnmaskedText();

        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu CEP';
        }

        if (unmasked.length != 8) {
          return 'Digite o CEP completo';
        }

        if (!cepMaskFormatter.isFill()) {
          return 'Preencha o CEP completo';
        }

        if (!RegExp(r'^[0-9.-]+$').hasMatch(value)) {
          // ADICIONADO O PONTO!
          return 'Apenas números, ponto e hífen são permitidos';
        }

        return null;
      },
    );
  }

  Widget buildEnderecoField() {
    return TextFormField(
      controller: _enderecoController,
      decoration: const InputDecoration(
        labelText: 'Endereço',
        border: OutlineInputBorder(),
        hintText: 'Rua, número, bairro...',
      ),
      keyboardType: TextInputType.streetAddress,
      maxLength: 200,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[a-zA-ZÀ-ÿĀ-žА-я0-9\s.,:;´`^~º°ª-]'),
        ),
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        String? error;

        if (_enderecoController.text.isEmpty) {
          error = 'Por favor, insira seu endereço';
        } else if (!RegExp(
          r'^[a-zA-ZÀ-ÿĀ-žА-я0-9\s.,:;´`^~º°ª-]+$',
        ).hasMatch(_enderecoController.text)) {
          error = 'Caracteres especiais não permitidos';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(fontSize: 12, color: Colors.red),
              ),
            Text(
              '$currentLength/200 caracteres',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu endereço';
        }

        if (value.length > 200) {
          return 'Endereço deve ter no máximo 200 caracteres';
        }

        if (!RegExp(r'^[a-zA-ZÀ-ÿĀ-žА-я0-9\s.,:;´`^~º°ª-]+$').hasMatch(value)) {
          return 'Caracteres especiais não permitidos';
        }

        return null;
      },
    );
  }

  Widget buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 48.0), // margem inferior
      child: ElevatedButton(
        onPressed: _submitForm,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          minimumSize: const Size(
            double.infinity,
            56,
          ), // Botão ocupa toda largura
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Bordas arredondadas
          ),
          elevation: 2, // Sombra sutil
        ),
        child: const Text(
          'ENVIAR',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Texto em negrito
            letterSpacing: 1.2, // Espaçamento entre letras
          ),
        ),
      ),
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

                // Campo Whatsapp
                buildWhatsappField(),
                const SizedBox(height: 16.0),

                // Campo Whatsapp
                buildSenhaField(),
                const SizedBox(height: 16.0),

                // Campo Telefone
                buildTelefoneField(),
                const SizedBox(height: 16.0),

                // Campo Data de Nascimento
                buildDataNascimentoField(),
                const SizedBox(height: 16.0),

                // Campo CEP
                buildCepField(),
                const SizedBox(height: 16.0),

                // Campo Endereço
                buildEnderecoField(),
                const SizedBox(height: 16.0),

                // Campo Botão
                buildSubmitButton(),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
