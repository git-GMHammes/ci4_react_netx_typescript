// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
// Para contagem de Texto
import 'package:flutter/services.dart';
// Para CPF:
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// Para o envio de API
import 'package:http/http.dart' as http;
import 'dart:convert';
// Para redirecionamento
import 'package:go_router/go_router.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisivel = false;

  // CAMPOS DO FORMULÁRIO
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _mailController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateBirthController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();

  // Controladores para os campos invisíveis
  final _logradouroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _localidadeController = TextEditingController();
  final _ufController = TextEditingController();
  final _estadoController = TextEditingController();
  final _regiaoController = TextEditingController();
  final _dddController = TextEditingController();

  // DADOS DA API
  final String apiUrl =
      'https://habilidade.com/ci4_react_netx_typescript/src/public/index.php/habilidade/usuario/api/salvar';
  final String token =
      'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2hhYmlsaWRhZGUuY29tL2NpNF9yZWFjdF9uZXR4X3R5cGVzY3JpcHQvc3JjL3B1YmxpYy8iLCJhdWQiOiJodHRwczovL2hhYmlsaWRhZGUuY29tL2NpNF9yZWFjdF9uZXR4X3R5cGVzY3JpcHQvc3JjL3B1YmxpYy8iLCJpYXQiOjE3NTMxNDM1NzAsImV4cCI6MTkwODY2MzU3MCwiZGF0YSI6eyJ1c2VySWQiOiJmaWFwdHBhIiwiZW1haWwiOiJnZnNAcHJvZGVyai5yai5nb3YuYnIifX0.1tklAyGQPSWF5sEs86pBKXbAguOJAlFyPZ8fP53pqlI';

  @override
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    _cpfController.dispose();
    _whatsappController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _dateBirthController.dispose();
    _zipCodeController.dispose();
    _enderecoController.dispose();
    // Controladores para os campos invisíveis
    _numeroController.dispose();
    _logradouroController.dispose();
    _bairroController.dispose();
    _localidadeController.dispose();
    _ufController.dispose();
    _estadoController.dispose();
    _regiaoController.dispose();
    _dddController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() != true) return;

    // Função para converter DD/MM/AAAA para AAAA-MM-DD
    String convertDateFormat(String dataBrasileira) {
      if (dataBrasileira.isEmpty) return '';

      try {
        // Remove a máscara e pega apenas os números
        String numbersOnly = dataBrasileira.replaceAll('/', '');

        if (numbersOnly.length == 8) {
          String day = numbersOnly.substring(0, 2);
          String month = numbersOnly.substring(2, 4);
          String year = numbersOnly.substring(4, 8);

          return '$year-$month-$day'; // Formato ISO: AAAA-MM-DD
        }
      } catch (e) {
        print('Erro ao converter data: $e');
      }

      return dataBrasileira; // Retorna original se houver erro
    }

    Map<String, dynamic> data = {
      "name": _nameController.text.trim(),
      "cpf": _cpfController.text.trim(),
      "mail": _mailController.text.trim(),
      "whatsapp": _whatsappController.text.trim(),
      "password": _passwordController.text.trim(),
      "phone": _phoneController.text.trim(),
      "data_nascimento": convertDateFormat(
        _dateBirthController.text.trim(),
      ), // CONVERSÃO AQUI!
      "zipCode": _zipCodeController.text.trim(),
      "address": _enderecoController.text.trim(),
    };

    // Log para debug - veja como a data está sendo enviada
    print('Data convertida: ${data["data_nascimento"]}');
    print('Dados enviados: ${jsonEncode(data)}');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
        body: jsonEncode(data),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        if (decoded['status'] == 'success') {
          // Dados retornados
          final insertID = decoded['result']?['insertID'];
          final nameSalvo = decoded['result']?['dbCreate']?['name'];
          final mensagem = decoded['message'];
          final backendDate = decoded['date'];
          final apiVersion = decoded['api']?['version'];

          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Sucesso!\n'
                '$mensagem\n'
                'ID: $insertID\n'
                'Name: $nameSalvo\n'
                'Data: $backendDate\n'
                'Versão API: $apiVersion',
              ),
              duration: Duration(seconds: 3),
            ),
          );

          // Limpa os campos
          _nameController.clear();
          _cpfController.clear();
          _mailController.clear();
          _whatsappController.clear();
          _passwordController.clear();
          _phoneController.clear();
          _dateBirthController.clear();
          _zipCodeController.clear();
          _enderecoController.clear();

          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            context.go(
              '/auth/instructions',
              extra: {
                "name": decoded['result']?['dbCreate']?['name'] ?? '',
                "mail": decoded['result']?['dbCreate']?['mail'] ?? '',
                "whatsapp": decoded['result']?['dbCreate']?['whatsapp'] ?? '',
                "address": decoded['result']?['dbCreate']?['address'] ?? '',
              },
            );
          }
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Falha no cadastro: ${decoded['message'] ?? 'Erro desconhecido.'}',
              ),
            ),
          );
        }
      } else if (response.statusCode == 409) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cadastro não realizado: já existe um cadastro com os dados enviados.\n'
              'Favor entrar em contato com o suporte.\n'
              'contato@habilidade.com.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      } else if (response.statusCode == 422) {
        // TRATAMENTO PARA ERRO 422 (Unprocessable Content)
        final decoded = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Dados inválidos: ${decoded['message'] ?? 'Verifique os campos preenchidos'}',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao enviar dados: ${response.reasonPhrase}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    }
  }

  Future<void> _buscarAddressPorCep(String zipCode) async {
    String zipCodeLimpo = zipCode.replaceAll(RegExp(r'[.-]'), '');

    try {
      final response = await http.get(
        Uri.parse('https://viazipCode.com.br/ws/$zipCodeLimpo/json/'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('erro')) {
          _mostrarMensagem('CEP não encontrado!');
        } else {
          // Preenche os campos invisíveis
          _logradouroController.text = data['logradouro'] ?? '';
          _bairroController.text = data['bairro'] ?? '';
          _localidadeController.text = data['localidade'] ?? '';
          _ufController.text = data['uf'] ?? '';
          _estadoController.text = data['estado'] ?? '';
          _regiaoController.text = data['regiao'] ?? '';
          _dddController.text = data['ddd'] ?? '';

          // Constrói o endereço automaticamente
          _construirAddress();

          // Concatena os dados do endereço para mostrar na mensagem
          String address = '';
          if (data['logradouro'] != null && data['logradouro'].isNotEmpty) {
            address += data['logradouro'];
          }
          if (data['bairro'] != null && data['bairro'].isNotEmpty) {
            address += ', ${data['bairro']}';
          }
          if (data['localidade'] != null && data['localidade'].isNotEmpty) {
            address += ', ${data['localidade']}';
          }
          if (data['uf'] != null && data['uf'].isNotEmpty) {
            address += ' - ${data['uf']}';
          }

          _mostrarMensagem('Endereço encontrado: $address');
        }
      } else {
        _mostrarMensagem('Erro ao buscar CEP. Tente novamente.');
      }
    } catch (e) {
      _mostrarMensagem('Erro de conexão. Verifique sua internet.');
    }
  }

  void _construirAddress() {
    List<String> partesAddress = [];

    // Logradouro
    if (_logradouroController.text.isNotEmpty) {
      partesAddress.add(_logradouroController.text);
    }

    // Número
    if (_numeroController.text.isNotEmpty) {
      if (_numeroController.text == '0') {
        partesAddress.add('S/N');
      } else {
        partesAddress.add('nº ${_numeroController.text}');
      }
    }

    // Complement
    if (_complementoController.text.isNotEmpty) {
      partesAddress.add('Complement: ${_complementoController.text}');
    }

    // Bairro
    if (_bairroController.text.isNotEmpty) {
      partesAddress.add(_bairroController.text);
    }

    // Localidade
    if (_localidadeController.text.isNotEmpty) {
      partesAddress.add(_localidadeController.text);
    }

    // UF
    if (_ufController.text.isNotEmpty) {
      partesAddress.add(_ufController.text);
    }

    // Região
    if (_regiaoController.text.isNotEmpty) {
      partesAddress.add(_regiaoController.text);
    }

    // DDD
    if (_dddController.text.isNotEmpty) {
      partesAddress.add('DDD: ${_dddController.text}');
    }

    // Junta todas as partes com vírgula e espaço
    _enderecoController.text = partesAddress.join(', ');
  }

  void _mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), duration: const Duration(seconds: 3)),
    );
  }

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Name',
        border: OutlineInputBorder(),
      ),
      maxLength: 150,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÀ-ú\s]")),
      ],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        String? error;
        String value = _nameController.text;

        if (value.isEmpty || value.length < 4) {
          error = 'Por favor, insira seu Name';
        } else if (!RegExp(r"^[A-Za-zÀ-ú\s]+$").hasMatch(value)) {
          error = 'Apenas letras são permitidas';
        } else if (value.length > 150) {
          error = 'O name deve ter no máximo 150 caracteres';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 167, 164, 164),
                ),
              ),
            Text('$currentLength/150', style: const TextStyle(fontSize: 12)),
          ],
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 4) {
          return 'Por favor, insira seu Name';
        }
        if (!RegExp(r"^[A-Za-zÀ-ú\s]+$").hasMatch(value)) {
          return 'Apenas letras são permitidas';
        }
        if (value.length > 150) {
          return 'O name deve ter no máximo 150 caracteres';
        }
        return null;
      },
    );
  }

  Widget buildCpfField() {
    final cpfMaskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _cpfController,
      decoration: const InputDecoration(
        labelText: 'CPF',
        border: OutlineInputBorder(),
        hintText: '000.000.000-00',
      ),
      keyboardType: TextInputType.number,
      maxLength: 14, // 000.000.000-00
      inputFormatters: [cpfMaskFormatter],
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        String? error;
        String onlyNumbers = cpfMaskFormatter.getUnmaskedText();
        String maskedText = _cpfController.text;

        if (maskedText.isEmpty) {
          error = 'Por favor, insira seu CPF';
        } else if (onlyNumbers.length != 11) {
          error = 'Digite todos os números do CPF';
        } else if (!cpfMaskFormatter.isFill()) {
          error = 'Preencha o CPF completo';
        } else {
          error = null;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (error != null)
              Text(
                error,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 161, 159, 159),
                ),
              ),
            Text(
              '$currentLength/14 caracteres',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
      },
      validator: (value) {
        String onlyNumbers = cpfMaskFormatter.getUnmaskedText();
        if (value == null || value.isEmpty) {
          return 'Por favor, insira seu CPF';
        }
        if (onlyNumbers.length != 11) {
          return 'Digite todos os números do CPF';
        }
        if (!cpfMaskFormatter.isFill()) {
          return 'Preencha o CPF completo';
        }
        return null;
      },
    );
  }

  Widget buildMailField() {
    return TextFormField(
      controller: _mailController,
      decoration: const InputDecoration(
        labelText: 'Mail',
        border: OutlineInputBorder(),
        hintText: 'exemplo@mail.com',
      ),
      keyboardType: TextInputType.emailAddress,
      maxLength: 151, // Para garantir limite total
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        final text = _mailController.text;
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
          return 'Por favor, insira seu mail';
        }
        final parts = value.split('@');
        if (parts.length != 2) return 'O mail deve conter apenas um @';
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
        final mailRegex = RegExp(
          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
        );
        if (!mailRegex.hasMatch(value)) {
          return 'Por favor, insira um mail válido';
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
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 167, 164, 164),
                ),
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

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_passwordVisivel ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _passwordVisivel = !_passwordVisivel;
            });
          },
        ),
      ),
      obscureText: !_passwordVisivel,
      maxLength: 32,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma password';
        }
        if (value.length < 6) {
          return 'A password deve ter pelo menos 6 caracteres';
        }
        if (value.length > 32) {
          return 'A password deve ter no máximo 32 caracteres';
        }
        if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
          return 'A password deve conter ao menos uma letra';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'A password deve conter ao menos um número';
        }

        // Regex para caracteres especiais (sem a aspa simples problemática)
        if (!RegExp(
          r'''[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:'<\.>\/\?\\|`~]''',
        ).hasMatch(value)) {
          return 'A password deve conter ao menos um caractere especial';
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

  Widget buildPhoneField() {
    // Inicialmente, máscara de celular
    final phoneMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
            hintText: '(00) 0000-0000',
          ),
          keyboardType: TextInputType.phone,
          maxLength: 15,
          inputFormatters: [phoneMaskFormatter],
          onChanged: (value) {
            String numbers = phoneMaskFormatter.getUnmaskedText();
            if (numbers.length > 10 &&
                phoneMaskFormatter.getMask() != '(##) #####-####') {
              phoneMaskFormatter.updateMask(mask: '(##) #####-####');
              setState(() {});
            } else if (numbers.length <= 10 &&
                phoneMaskFormatter.getMask() != '(##) ####-####') {
              phoneMaskFormatter.updateMask(mask: '(##) ####-####');
              setState(() {});
            }
          },
          buildCounter: (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            String? error;
            String unmasked = phoneMaskFormatter.getUnmaskedText();
            if (_phoneController.text.isEmpty) {
              error = 'Por favor, insira seu Phone';
            } else if (unmasked.length != 10 && unmasked.length != 11) {
              error = 'Digite todos os números do Phone';
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (error != null)
                  Text(
                    error,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
                  ),
                Text(
                  '$currentLength/15 caracteres',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          },
          validator: (value) {
            String unmasked = phoneMaskFormatter.getUnmaskedText();
            if (value == null || value.isEmpty) {
              return 'Por favor, insira seu Phone';
            }
            if (unmasked.length != 10 && unmasked.length != 11) {
              return 'Digite todos os números do Phone';
            }
            return null;
          },
        );
      },
    );
  }

  Widget buildDateBirthField() {
    final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return TextFormField(
      controller: _dateBirthController,
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

        if (_dateBirthController.text.isEmpty) {
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
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
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 167, 164, 164),
                ),
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
    final zipCodeMaskFormatter = MaskTextInputFormatter(
      mask: '##.###-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return Focus(
      onFocusChange: (hasFocus) {
        // Quando o campo perde o foco
        if (!hasFocus) {
          String unmasked = zipCodeMaskFormatter.getUnmaskedText();
          if (unmasked.length == 8) {
            _buscarAddressPorCep(_zipCodeController.text);
          }
        }
      },
      child: TextFormField(
        controller: _zipCodeController,
        decoration: const InputDecoration(
          labelText: 'CEP',
          border: OutlineInputBorder(),
          hintText: '00.000-000',
        ),
        keyboardType: TextInputType.number,
        maxLength: 10,
        inputFormatters: [
          zipCodeMaskFormatter,
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
        ],
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          required bool isFocused,
          required int? maxLength,
        }) {
          String? error;
          String unmasked = zipCodeMaskFormatter.getUnmaskedText();

          if (_zipCodeController.text.isEmpty) {
            error = 'Por favor, insira seu CEP';
          } else if (unmasked.length < 8) {
            error = 'Digite o CEP completo';
          } else if (!RegExp(r'^[0-9.-]+$').hasMatch(_zipCodeController.text)) {
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
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 167, 164, 164),
                  ),
                ),
              Text(
                '$currentLength/10 caracteres',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        },
        onChanged: (value) {
          String unmasked = zipCodeMaskFormatter.getUnmaskedText();
          if (unmasked.length == 8) {
            print('CEP completo: $unmasked');
          }
        },
        validator: (value) {
          String unmasked = zipCodeMaskFormatter.getUnmaskedText();

          if (value == null || value.isEmpty) {
            return 'Por favor, insira seu CEP';
          }

          if (unmasked.length != 8) {
            return 'Digite o CEP completo';
          }

          if (!zipCodeMaskFormatter.isFill()) {
            return 'Preencha o CEP completo';
          }

          if (!RegExp(r'^[0-9.-]+$').hasMatch(value)) {
            return 'Apenas números, ponto e hífen são permitidos';
          }

          return null;
        },
      ),
    );
  }

  Widget buildNumberField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          String value = _numeroController.text;
          if (value.isNotEmpty && !RegExp(r'^[0-9]+$').hasMatch(value)) {
            _numeroController.text = '0';
          }
          // Reconstrói o endereço quando o número muda
          _construirAddress();
        }
      },
      child: TextFormField(
        controller: _numeroController,
        decoration: const InputDecoration(
          labelText: 'Número',
          border: OutlineInputBorder(),
          hintText: 'Digite o número',
          helperText: 'Digite 0 (zero) para sem número',
          helperStyle: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 167, 164, 164),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o número';
          }
          return null;
        },
      ),
    );
  }

  Widget buildComplementField() {
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          // Reconstrói o endereço quando o complemento muda
          _construirAddress();
        }
      },
      child: TextFormField(
        controller: _complementoController,
        decoration: const InputDecoration(
          labelText: 'Complement',
          border: OutlineInputBorder(),
          hintText: 'Digite o complemento',
          helperText: 'Campo não obrigatório',
          helperStyle: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 167, 164, 164),
          ),
        ),
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s.\-(),]')),
        ],
        validator: (value) {
          return null;
        },
      ),
    );
  }

  Widget buildAddressField() {
    return TextFormField(
      controller: _enderecoController,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Endereço',
        border: OutlineInputBorder(),
        hintText: 'Endereço será preenchido automaticamente',
        helperText: 'Campo preenchido automaticamente com base no CEP',
        helperStyle: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 167, 164, 164),
        ),
      ),
      maxLength: 200,
      buildCounter: (
        BuildContext context, {
        required int currentLength,
        required bool isFocused,
        required int? maxLength,
      }) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Preenchido automaticamente',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 167, 164, 164),
              ),
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
          return 'Endereço não foi preenchido automaticamente';
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

                // Campo Name
                buildNameField(),
                const SizedBox(height: 16.0),

                // Campo CPF
                buildCpfField(),
                const SizedBox(height: 16.0),

                // Campo E-mail
                buildMailField(),
                const SizedBox(height: 16.0),

                // Campo Whatsapp
                buildWhatsappField(),
                const SizedBox(height: 16.0),

                // Campo Whatsapp
                buildPasswordField(),
                const SizedBox(height: 16.0),

                // Campo Phone
                buildPhoneField(),
                const SizedBox(height: 16.0),

                // Campo Data de Nascimento
                buildDateBirthField(),
                const SizedBox(height: 16.0),

                // Campo CEP
                buildCepField(),
                const SizedBox(height: 16.0),

                // Campo Number
                buildNumberField(),
                const SizedBox(height: 16.0),

                // Campo Complement
                buildComplementField(),
                const SizedBox(height: 16.0),

                // Campo Endereço
                buildAddressField(),
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
