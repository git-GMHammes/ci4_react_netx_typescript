// ignore_for_file: deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Página principal mostrando blocos de parágrafos usando widgets customizados
class AuthAcceptancePage extends StatelessWidget {
  const AuthAcceptancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Termo de Aceite do Usuário')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            /// Bloco 001 - Identificação e Finalidade do Aplicativo
            BlockBuild001(),
            SizedBox(height: 24),

            /// Bloco 002 - Coleta e Uso de Dados Pessoais
            RenderBlock002(),
            SizedBox(height: 24),

            /// Bloco 003 - Responsabilidades do Usuário e Limitações de Responsabilidade
            BuildBlock003(),
            SizedBox(height: 24),

            /// Bloco 004 - Política de Privacidade e Proteção de Dados (LGPD)
            BlockBuild004(),
            SizedBox(height: 24),

            /// Bloco 005 - Direitos do Usuário e Procedimentos de Cancelamento
            BuildBlock005(),
            SizedBox(height: 24),

            /// Bloco 006 - Alterações nos Termos e Condições Gerais
            BuildBlock006(),
            SizedBox(height: 24),

            /// Bloco 007 - Disposições Legais e Foro Competente
            BuildBlock007(),
            SizedBox(height: 24),

            /// Botões
            AcceptanceButtons(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// Widget customizado para o primeiro bloco - Identificação e Finalidade do Aplicativo
class BlockBuild001 extends StatelessWidget {
  const BlockBuild001({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '1. IDENTIFICAÇÃO E FINALIDADE DO APLICATIVO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Este aplicativo foi desenvolvido como uma plataforma digital de conexão e engajamento social, destinada a usuários que buscam participar de uma comunidade colaborativa focada em impacto positivo. Nossa solução oferece um ambiente para formação de redes sociais temáticas, onde os participantes podem acessar conteúdos exclusivos, participar de projetos coletivos e estabelecer conexões significativas através de um modelo de assinatura mensal.',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          'A plataforma disponibiliza funcionalidades como acesso a iniciativas colaborativas, conexão entre usuários com interesses afins, conteúdo educacional especializado, sistema de missões gamificadas e acompanhamento de progresso individual. O aplicativo opera através de um modelo de assinatura que desbloqueia benefícios exclusivos e ferramentas avançadas para maximizar a experiência do usuário dentro da comunidade digital.',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '1.1 RECURSOS E FUNCIONALIDADES DISPONÍVEIS:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🌍 Projetos Colaborativos: Acesso exclusivo a iniciativas que promovem educação inclusiva, preservação ambiental, igualdade de oportunidades e bem-estar coletivo, permitindo apoio, participação ou liderança em ações de impacto social.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8),
        Text(
          '🤝 Rede de Conexões: Ferramenta para encontrar usuários que compartilham valores e objetivos similares, facilitando a formação de redes de colaboração e troca de experiências em causas relevantes.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8),
        Text(
          '💡 Biblioteca de Conteúdo: Disponibilização de artigos, vídeos e cursos educacionais para compreensão de desafios contemporâneos e desenvolvimento de ações conscientes e eficazes.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8),
        Text(
          '🎯 Sistema de Missões: Desafios práticos mensais que incentivam hábitos sustentáveis, engajamento comunitário e atitudes colaborativas, com sistema de pontuação e recompensas.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 8),
        Text(
          '📈 Métricas de Impacto: Acompanhamento do progresso individual e visualização da contribuição pessoal para metas de desenvolvimento humano, equilíbrio ambiental e inclusão social.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '✨ O usuário integra uma comunidade digital baseada na colaboração e responsabilidade compartilhada, utilizando a plataforma como ferramenta de engajamento social e desenvolvimento pessoal alinhado aos princípios de sustentabilidade e impacto positivo.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 002 - Coleta e Uso de Dados Pessoais
class RenderBlock002 extends StatelessWidget {
  const RenderBlock002({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '2. COLETA E USO DE DADOS PESSOAIS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '🔐 A privacidade do usuário é tratada com seriedade e respeito. Todas as informações fornecidas ao aplicativo são coletadas de forma transparente, com finalidades claras e legítimas. Nenhum dado é solicitado sem que haja uma justificativa vinculada à melhoria da experiência ou ao funcionamento adequado dos serviços oferecidos.',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '2.1 FINALIDADE E LIMITAÇÃO DO TRATAMENTO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🎯 O uso dos dados é limitado ao que é necessário para a prestação dos serviços contratados. Nenhuma informação é armazenada ou compartilhada além do que contribui diretamente para a entrega dos benefícios oferecidos pela plataforma, incluindo personalização de conteúdo, conexão entre usuários e acompanhamento de progresso nas atividades.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '2.2 DIREITOS DO TITULAR DOS DADOS:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '👤 O usuário possui autonomia completa sobre suas informações pessoais, incluindo os direitos de: acessar e revisar seus dados a qualquer momento; solicitar correção de informações incorretas ou desatualizadas; requerer a exclusão de dados quando não mais necessários; e obter esclarecimentos sobre o tratamento realizado. O acesso às configurações de privacidade é facilitado através da interface do aplicativo.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '2.3 SEGURANÇA E PROTEÇÃO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🔒 Medidas técnicas e administrativas adequadas são implementadas para proteger os dados pessoais contra acessos não autorizados, vazamentos, alterações indevidas ou qualquer forma de tratamento inadequado. A segurança da informação constitui prioridade operacional da plataforma.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '2.4 TRANSPARÊNCIA E COMUNICAÇÃO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📞 O usuário pode solicitar esclarecimentos sobre o tratamento de suas informações pessoais a qualquer momento, recebendo respostas claras, objetivas e dentro de prazos razoáveis. A comunicação sobre práticas de privacidade é mantida de forma acessível e compreensível.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '✨ Este compromisso com a proteção de dados reflete o respeito à liberdade individual, à dignidade e à confiança de quem escolhe fazer parte da nossa comunidade digital.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 003 - Responsabilidades do Usuário e Limitações de Responsabilidade
class BuildBlock003 extends StatelessWidget {
  const BuildBlock003({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '3. RESPONSABILIDADES DO USUÁRIO E LIMITAÇÕES DE RESPONSABILIDADE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '3.1 RESPONSABILIDADES DO USUÁRIO PELO CONTEÚDO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📝 Ao utilizar a plataforma, o usuário assume integral responsabilidade por todo conteúdo publicado, incluindo textos, imagens, comentários e demais materiais compartilhados. O usuário declara ser autor original do conteúdo ou possuir os direitos e permissões necessários para sua utilização, garantindo que suas publicações não violem direitos de propriedade intelectual, direitos autorais, marcas registradas ou outros direitos de terceiros.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '3.2 CONDUTA E COMPORTAMENTO NA PLATAFORMA:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⚖️ É vedada a publicação de conteúdo ilegal, difamatório, obsceno, discriminatório ou que promova violência, assédio ou atividades criminosas. O usuário compromete-se a manter um ambiente respeitoso e colaborativo, alinhado aos valores de impacto positivo e responsabilidade social da comunidade. A plataforma reserva-se o direito de remover conteúdo inadequado e aplicar medidas restritivas sem aviso prévio.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '3.3 USO ADEQUADO DOS RECURSOS DA PLATAFORMA:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🎯 O usuário compromete-se a utilizar as funcionalidades da plataforma de acordo com suas finalidades legítimas, respeitando os demais participantes da comunidade e contribuindo de forma construtiva para os projetos e missões disponibilizadas. É proibido o uso da plataforma para fins comerciais não autorizados, spam ou qualquer atividade que comprometa o funcionamento adequado do sistema.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '3.4 LIMITAÇÕES DE RESPONSABILIDADE DA PLATAFORMA:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🛡️ A plataforma atua como facilitadora de conexões e disponibilizadora de recursos, não sendo responsável pelo conteúdo gerado pelos usuários ou pelas interações estabelecidas entre os participantes da comunidade. Embora sejam adotadas medidas razoáveis de monitoramento, a plataforma não pode ser responsabilizada por danos decorrentes de conteúdo inadequado ou comportamento inadequado de usuários.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '3.5 INDENIZAÇÃO E ISENÇÃO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⚡ O usuário concorda em isentar e indenizar a plataforma de quaisquer reivindicações, danos, perdas ou ações legais decorrentes do uso inadequado do serviço, violação destes termos ou conteúdo publicado pelo usuário. A responsabilidade da plataforma é limitada conforme permitido pela legislação aplicável, sem garantias expressas ou implícitas quanto ao conteúdo de terceiros.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '🤝 A conformidade com estas responsabilidades é essencial para manter um ambiente seguro, respeitoso e colaborativo para todos os participantes da comunidade.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.black87,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 004 - Política de Privacidade e Proteção de Dados (LGPD)
class BlockBuild004 extends StatelessWidget {
  const BlockBuild004({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '4. POLÍTICA DE PRIVACIDADE E PROTEÇÃO DE DADOS (LGPD)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📢 Lei nº 13.709/2018 – É pra valer!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Este aplicativo respeita e cumpre integralmente a Lei Geral de Proteção de Dados Pessoais (LGPD), instituída pela Lei nº 13.709/2018, que regula o tratamento de dados pessoais, inclusive nos meios digitais, com o objetivo de proteger os direitos fundamentais de liberdade, privacidade e o livre desenvolvimento da personalidade da pessoa natural (Art. 1º).',
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.1 PRINCÍPIOS FUNDAMENTAIS (ART. 6º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🔐 O tratamento de dados pessoais observa rigorosamente os seguintes princípios:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6),
        Text(
          '• Finalidade: uso legítimo e específico dos dados para propósitos informados ao titular\n• Adequação: compatibilidade do tratamento com as finalidades informadas\n• Necessidade: coleta mínima e essencial para atingir suas finalidades\n• Livre acesso: transparência total ao titular sobre o tratamento\n• Qualidade dos dados: precisão, clareza, relevância e atualização\n• Transparência: informações claras e acessíveis sobre o tratamento\n• Segurança: proteção contra acessos não autorizados e situações acidentais\n• Prevenção: medidas para evitar danos aos titulares\n• Não discriminação: impossibilidade de tratamento para fins discriminatórios\n• Responsabilização e prestação de contas: demonstração de cumprimento das normas',
          style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.2 BASES LEGAIS PARA TRATAMENTO (ART. 7º E 11º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⚖️ O tratamento de dados pessoais fundamenta-se nas seguintes bases legais: consentimento do titular (Art. 7º, I); cumprimento de obrigação legal ou regulatória (Art. 7º, II); execução de políticas públicas (Art. 7º, III); realização de estudos por órgão de pesquisa (Art. 7º, IV); execução de contrato ou procedimentos preliminares (Art. 7º, V); exercício regular de direitos (Art. 7º, VI); proteção da vida ou incolumidade física (Art. 7º, VII); tutela da saúde (Art. 7º, VIII); legítimo interesse (Art. 7º, IX); proteção do crédito (Art. 7º, X).',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.3 PROTEÇÃO DE MENORES DE IDADE (ART. 14º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🚫 ATENÇÃO ESPECIAL: É terminantemente proibido o tratamento de dados pessoais de crianças e adolescentes sem o consentimento específico e destacado de pelo menos um dos responsáveis legais. O consentimento deve ser obtido de forma clara, verificável e com base em informações adequadas à compreensão do responsável legal.',
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 6),
        Text(
          '👶 Para menores de 18 anos: É obrigatória a presença e autorização expressa de responsável legal durante o cadastro. Qualquer tentativa de uso por menores desacompanhada de autorização será considerada violação grave e poderá acarretar suspensão imediata da conta, além de medidas legais cabíveis conforme Art. 52 a 54.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.red),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.4 DIREITOS DOS TITULARES (ART. 18º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '👤 O titular dos dados pessoais tem direito a obter do controlador, a qualquer momento e mediante requisição:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'I - Confirmação da existência de tratamento (Art. 18, I)\nII - Acesso aos dados (Art. 18, II)\nIII - Correção de dados incompletos, inexatos ou desatualizados (Art. 18, III)\nIV - Anonimização, bloqueio ou eliminação de dados desnecessários (Art. 18, IV)\nV - Portabilidade dos dados a outro fornecedor (Art. 18, V)\nVI - Eliminação dos dados tratados com consentimento (Art. 18, VI)\nVII - Informação sobre entidades com as quais o controlador compartilhou dados (Art. 18, VII)\nVIII - Informação sobre a possibilidade de não fornecer consentimento (Art. 18, VIII)\nIX - Revogação do consentimento (Art. 18, IX)',
          style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.5 RESPONSABILIDADES E OBRIGAÇÕES (ART. 8º, 37º, 40º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📋 O usuário é integralmente responsável pelas informações que compartilha, incluindo dados próprios ou de terceiros. É dever do usuário garantir que os dados inseridos estejam corretos, atualizados e não violem direitos de terceiros. O controlador deve manter registro das operações de tratamento que realizar (Art. 37) e implementar programa de governança em privacidade (Art. 50).',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.6 SEGURANÇA E BOAS PRÁTICAS (ART. 46º A 50º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🛡️ Adotamos medidas técnicas e administrativas aptas a proteger os dados pessoais de acessos não autorizados e de situações acidentais ou ilícitas de destruição, perda, alteração, comunicação ou difusão (Art. 46). Incidentes de segurança serão comunicados à Autoridade Nacional de Proteção de Dados (ANPD) e aos titulares afetados em prazo razoável (Art. 48).',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.7 TRANSFERÊNCIA INTERNACIONAL (ART. 33º A 36º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🌍 A transferência internacional de dados pessoais somente será permitida para países ou organismos internacionais que proporcionem grau de proteção de dados pessoais adequado (Art. 33), mediante consentimento específico do titular (Art. 33, I) ou quando necessária para cooperação jurídica internacional (Art. 33, II).',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.8 CONSENTIMENTO E REVOGAÇÃO (ART. 5º, XII E ART. 8º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📣 O consentimento é livre, informado e inequívoco para finalidade determinada (Art. 5º, XII). Deve ser fornecido por escrito ou por outro meio que demonstre a manifestação de vontade do titular (Art. 8º). O titular pode revogar o consentimento a qualquer momento mediante manifestação expressa (Art. 8º, §5º), sem prejuízo da legalidade do tratamento realizado com base no consentimento anteriormente manifestado.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '4.9 SANÇÕES ADMINISTRATIVAS (ART. 52º):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⚠️ O descumprimento das disposições da LGPD sujeita o infrator às seguintes sanções: advertência com indicação de prazo para adoção de medidas corretivas; multa simples de até 2% do faturamento; multa diária; publicização da infração; bloqueio dos dados pessoais; eliminação dos dados pessoais; suspensão parcial do funcionamento do banco de dados; suspensão do exercício da atividade de tratamento; proibição parcial ou total do exercício de atividades relacionadas a tratamento de dados.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.red),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '✅ O cumprimento integral da LGPD é compromisso fundamental desta plataforma para garantir a proteção dos direitos fundamentais de privacidade e proteção de dados pessoais de todos os usuários.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 005 - Direitos do Usuário e Procedimentos de Cancelamento
class BuildBlock005 extends StatelessWidget {
  const BuildBlock005({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '5. DIREITOS DO USUÁRIO E PROCEDIMENTOS DE CANCELAMENTO',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '5.1 RESCISÃO VOLUNTÁRIA E DIREITOS DO USUÁRIO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🚪 O usuário possui o direito irrestrito de encerrar sua conta e descontinuar o uso dos serviços a qualquer momento, sem necessidade de justificativa. O procedimento de cancelamento pode ser realizado através da área de perfil do aplicativo ou mediante contato direto com a equipe de suporte. Após a solicitação de cancelamento, o acesso à plataforma será encerrado e a rescisão do acordo com estes Termos de Uso entrará em vigor imediatamente.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.2 EFEITOS DA RESCISÃO VOLUNTÁRIA:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📋 A rescisão voluntária do serviço não anula as obrigações ou responsabilidades assumidas durante o período de utilização da plataforma, especialmente aquelas relacionadas a conteúdo publicado, violações dos Termos de Uso ou compromissos financeiros pendentes que tenham ocorrido antes do cancelamento. O usuário permanece responsável por todas as ações realizadas em sua conta até o momento efetivo do encerramento.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.3 SUSPENSÃO OU ENCERRAMENTO POR VIOLAÇÃO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⚠️ A plataforma reserva-se o direito de suspender ou encerrar contas imediatamente, sem aviso prévio, em casos de violação grave ou persistente destes Termos de Uso. Incluem-se nestas situações: publicação de material ilegal, criminoso, ofensivo ou discriminatório; uso inadequado dos recursos da plataforma; tentativas de fraude ou manipulação do sistema; e comportamento que comprometa a segurança ou integridade da comunidade.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.red),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.4 RETENÇÃO DE INFORMAÇÕES PARA FINS LEGAIS:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🔒 Em casos de encerramento por violação, a plataforma poderá reter informações necessárias para fins de investigação, cumprimento de obrigações legais, defesa em processos judiciais ou cooperação com autoridades competentes, conforme estabelecido na legislação aplicável. A retenção será limitada ao estritamente necessário e pelo período determinado por lei.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.5 DIREITOS À REMOÇÃO DE DADOS PESSOAIS (LGPD):',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🗑️ Em conformidade com a Lei Geral de Proteção de Dados (LGPD), o usuário possui o direito de solicitar a exclusão de seus dados pessoais armazenados na plataforma. Após o cancelamento da conta, é possível requisitar a remoção definitiva dos dados pessoais, que será realizada em prazo razoável, exceto quando a retenção for legalmente exigida para cumprimento de obrigações regulatórias, fiscais, jurídicas ou para defesa de direitos em processos judiciais.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.green),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.6 LIMITAÇÕES À REMOÇÃO DE CONTEÚDO PÚBLICO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '💬 O direito à remoção de dados não se estende automaticamente a conteúdos publicados de forma pública, como comentários, publicações em projetos comunitários ou interações em fóruns, que podem permanecer na plataforma de forma anônima ou vinculados a uma conta desativada. A exclusão específica deste conteúdo público pode ser solicitada separadamente e será avaliada quanto à viabilidade técnica e impacto na integridade das discussões comunitárias.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '5.7 PROCEDIMENTOS E PRAZOS:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⏱️ Solicitações de cancelamento de conta são processadas em até 48 horas úteis. Pedidos de exclusão de dados pessoais são atendidos em até 15 dias úteis, podendo ser prorrogados por igual período mediante justificativa. O usuário será informado sobre o andamento do processo através do e-mail cadastrado e receberá confirmação da conclusão das solicitações.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '✅ O exercício destes direitos é gratuito e pode ser realizado a qualquer momento, constituindo garantia fundamental da relação entre usuário e plataforma.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 006 - Alterações nos Termos e Condições Gerais
class BuildBlock006 extends StatelessWidget {
  const BuildBlock006({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '6. ALTERAÇÕES NOS TERMOS E CONDIÇÕES GERAIS',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '6.1 DIREITO DE MODIFICAÇÃO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📝 A plataforma reserva-se o direito de modificar, aprimorar ou atualizar estes Termos e Condições Gerais a qualquer momento, conforme necessário. Tais alterações são essenciais para adaptação a mudanças na legislação vigente, implementação de novas funcionalidades do serviço, aprimoramento da experiência do usuário ou para abordar questões de segurança, privacidade e conformidade legal.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '6.2 VIGÊNCIA DAS ALTERAÇÕES:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '⏰ As modificações entrarão em vigor imediatamente após sua publicação na plataforma, exceto quando especificado prazo diverso para adequação do usuário. A data da última atualização será sempre indicada no início ou final deste documento para facilitar o acompanhamento das revisões realizadas.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '6.3 NOTIFICAÇÃO E TRANSPARÊNCIA:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '📢 Para garantir a transparência e o conhecimento adequado, os usuários serão notificados sobre alterações substanciais através de: aviso em destaque na interface principal da plataforma; comunicação por e-mail para o endereço cadastrado; notificações push no aplicativo móvel; ou outros canais de comunicação apropriados e acessíveis aos usuários.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '6.4 ACEITAÇÃO DAS ALTERAÇÕES:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '✅ Ao continuar utilizando a plataforma após a publicação das alterações, o usuário demonstra sua aceitação incondicional dos novos Termos e Condições. O uso continuado da plataforma após a data de vigência das modificações constitui concordância explícita e irrevogável com os termos revisados, estabelecendo nova relação contratual entre as partes.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.green),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '6.5 DIREITO DE RECUSA E CANCELAMENTO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '🚫 Caso o usuário não concorde com as modificações realizadas, deve cessar imediatamente o uso do serviço e seguir o procedimento de cancelamento de conta estabelecido no BLOCO 005 destes Termos. A não manifestação de discordância no prazo de 30 (trinta) dias após a notificação será interpretada como aceitação tácita das alterações.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.red),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
        Text(
          '6.6 RECOMENDAÇÃO DE ACOMPANHAMENTO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '👁️ Recomenda-se que o usuário revise periodicamente estes Termos e Condições para manter-se informado sobre as políticas, direitos e obrigações vigentes. O acompanhamento regular das atualizações garante o uso consciente e adequado da plataforma, evitando mal-entendidos ou violações involuntárias.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12),
        Text(
          '🔄 A atualização contínua destes Termos reflete o compromisso da plataforma com a transparência, conformidade legal e aprimoramento constante da experiência do usuário.',
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

/// BLOCO 007 - Disposições Legais e Foro Competente
class BuildBlock007 extends StatelessWidget {
  const BuildBlock007({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '7. DISPOSIÇÕES LEGAIS E FORO COMPETENTE',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          '7.1 LEGISLAÇÃO APLICÁVEL:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '🇧🇷 Estes Termos e Condições Gerais são regidos, interpretados e executados de acordo com as leis da República Federativa do Brasil, incluindo, mas não se limitando a: Constituição Federal de 1988; Código Civil Brasileiro (Lei nº 10.406/2002); Código de Defesa do Consumidor (Lei nº 8.078/1990); Lei Geral de Proteção de Dados Pessoais - LGPD (Lei nº 13.709/2018); e demais normas correlatas em vigor.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        const Text(
          '7.2 FORO COMPETENTE ELEITO:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '🏛️ Fica expressamente eleito o Foro da Comarca do Rio de Janeiro, Estado do Rio de Janeiro, para dirimir quaisquer dúvidas, litígios, controvérsias ou questões decorrentes destes Termos de Uso, de sua interpretação, cumprimento ou execução, com exclusão de qualquer outro foro, por mais privilegiado que seja.',
          style: TextStyle(
            fontSize: 15,
            height: 1.4,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        const Text(
          '7.3 DIREITOS DO CONSUMIDOR:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '🛡️ Nada do disposto nestes Termos prejudica os direitos irrenunciáveis assegurados pelo Código de Defesa do Consumidor aos usuários qualificados como consumidores, incluindo o direito de ajuizar ação no foro de seu domicílio quando cabível, conforme previsto no artigo 101, inciso I, da Lei nº 8.078/1990.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.green),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        const Text(
          '7.4 DISPOSIÇÕES FINAIS:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '📋 Caso qualquer disposição destes Termos seja considerada inválida, ilegal ou inexequível por tribunal competente, tal invalidade não afetará as demais cláusulas, que permanecerão em pleno vigor e efeito. A plataforma poderá substituir a cláusula inválida por outra válida e de efeito econômico similar.',
          style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        // GRANDE FINAL - SEM CONST NO CONTAINER
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.green.shade50],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200, width: 2),
          ),
          child: const Column(
            children: [
              Text(
                '🎯 ACEITE E VIGÊNCIA 🎯',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                '✨ Ao clicar em "ACEITO" ou utilizar qualquer funcionalidade desta plataforma, o usuário declara ter lido, compreendido e aceito integralmente todos os termos e condições aqui estabelecidos. ✨',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                '🤝 Seja bem-vindo(a) à nossa comunidade! 🤝',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AcceptanceButtons extends StatelessWidget {
  const AcceptanceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Cores leves (pastel)
    const Color lightGreen = Color(0xFFD6F5E6); // verde leve
    const Color lightRed = Color(0xFFF8D6D6); // vermelho leve
    const Color greenText = Color(0xFF3AB16B); // verde para o texto
    const Color redText = Color(0xFFD34C4C); // vermelho para o texto

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text(
              'Sim',
              style: TextStyle(color: greenText, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(lightGreen),
              elevation: MaterialStateProperty.all(8),
              shadowColor: MaterialStateProperty.all(
                greenText.withOpacity(0.2),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              overlayColor: MaterialStateProperty.all(
                greenText.withOpacity(0.1),
              ), // efeito ao clicar
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () => context.go('/login'),
            child: const Text(
              'Não',
              style: TextStyle(color: redText, fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(lightRed),
              elevation: MaterialStateProperty.all(8),
              shadowColor: MaterialStateProperty.all(redText.withOpacity(0.2)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              overlayColor: MaterialStateProperty.all(
                redText.withOpacity(0.1),
              ), // efeito ao clicar
            ),
          ),
        ],
      ),
    );
  }
}
