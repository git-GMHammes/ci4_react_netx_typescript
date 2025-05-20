<?php
/**
 * Script para exibir a estrutura de diretórios em formato de árvore vertical
 * similar ao comando 'tree' em sistemas Linux/Windows
 */

// Função recursiva para exibir a estrutura de diretórios
function exibirEstrutura($diretorio, $prefixo = '') {
    // Verifica se o diretório existe
    if (!is_dir($diretorio)) {
        echo "O diretório $diretorio não existe!";
        return;
    }
    
    // Verifica se o diretório atual é node_modules
    $dirName = basename($diretorio);
    if ($dirName === 'node_modules') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
    if ($dirName === 'system') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
    if ($dirName === 'debugbar') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
    if ($dirName === 'session') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
    if ($dirName === 'logs') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
    if ($dirName === 'uploads') {
        // Apenas mostra o diretório node_modules, mas não seu conteúdo
        return;
    }
        
    // Lista os arquivos e pastas do diretório
    $itens = scandir($diretorio);
    
    // Array para armazenar diretórios e arquivos separadamente
    $diretorios = [];
    $arquivos = [];
    
    // Separa diretórios e arquivos
    foreach ($itens as $item) {
        if ($item != '.' && $item != '..') {
            $caminho = $diretorio . '/' . $item;
            if (is_dir($caminho)) {
                $diretorios[] = $item;
            } else {
                $arquivos[] = $item;
            }
        }
    }
    
    // Ordena os arrays
    sort($diretorios);
    sort($arquivos);
    
    // Combina os arrays, diretórios primeiro
    $todos = array_merge($diretorios, $arquivos);
    
    // Número total de itens
    $total = count($todos);
    
    // Para cada item
    for ($i = 0; $i < $total; $i++) {
        $item = $todos[$i];
        $caminho = $diretorio . '/' . $item;
        $isUltimo = ($i == $total - 1);
        
        // Exibe o item atual
        echo $prefixo . ($isUltimo ? "└── " : "├── ");
        
        if (is_dir($caminho)) {
            echo $item . "\\" . PHP_EOL;
            
            // Prefixo para os itens do próximo nível
            $novoPrefixo = $prefixo . ($isUltimo ? "    " : "│   ");
            
            // Chama recursivamente para o subdiretório
            exibirEstrutura($caminho, $novoPrefixo);
        } else {
            $extensao = pathinfo($item, PATHINFO_EXTENSION);
            echo $item . " (." . $extensao . ")" . PHP_EOL;
        }
    }
}

// Configura o tipo de conteúdo como texto plano
header('Content-Type: text/plain; charset=utf-8');

// Exibe o cabeçalho
echo "[NEXTJS] http:// + localhost ou 127.0.0.1 -- portas(7777 ou 9999)/" . PHP_EOL;
echo "│" . PHP_EOL;
echo "└── script\\" . PHP_EOL;

// Exibe a estrutura a partir do diretório 'script'
exibirEstrutura('../../script', "    ");

// Adiciona uma linha em branco entre as exibições
echo PHP_EOL;
// Adiciona uma linha em branco entre as exibições
echo PHP_EOL;
?>

/*
  possíveis ambientes dev para react:
  [DEV1/Docker]
  cd C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend
  npm run dev -- --host 127.0.0.1 --port 7777
  
  [DEV2/Laragon]
  cd C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend
  npm run dev -- --host localhost --port 9999
*/

cd C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend
npm list
 
frontend@0.0.0 C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend
+-- @eslint/js@9.21.0
+-- @popperjs/core@2.11.8
+-- @types/react-dom@19.0.4
+-- @types/react@19.0.10
+-- @vitejs/plugin-react@4.3.4
+-- axios@1.8.4
+-- bootstrap-icons@1.11.3
+-- bootstrap@5.3.3
+-- eslint-plugin-react-hooks@5.2.0
+-- eslint-plugin-react-refresh@0.4.19
+-- eslint@9.21.0
+-- globals@15.15.0
+-- lucide-react@0.482.0
+-- react-bootstrap@2.10.9
+-- react-dom@19.0.0
+-- react-hook-form@7.54.2
+-- react-input-mask@3.0.0-alpha.2
+-- react-router-dom@7.4.0
+-- react@19.0.0
`-- vite@6.2.1

# ESTRTURA de INICIALIZAÇÃO	
src/public/script/react_modelo_v1/frontend/src/main.jsx
    ↓
    ↓ (Invoca)
    ↓
src/public/script/react_modelo_v1/frontend/src/App.jsx
    ↓
    ↓ (Invoca)
    ↓
src/public/script/react_modelo_v1/frontend/src/routes/index.jsx

// C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend\src\main.jsx
import ReactDOM from 'react-dom/client';
import { HashRouter } from 'react-router-dom';
import App from './App';
import './index.css';
// Importe apenas o bundle do Bootstrap, que já inclui o Popper.js
import 'bootstrap/dist/js/bootstrap.bundle.min.js';
import 'bootstrap/dist/css/bootstrap.min.css';

// Definir o tema escuro
document.documentElement.setAttribute('data-bs-theme', 'dark');

ReactDOM.createRoot(document.getElementById('root')).render(
  <HashRouter>
    <App />
  </HashRouter>
);

// C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend\src\App.jsx
// C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend\src\App.jsx
import React, { useState, useEffect } from 'react';
import Routes from './routes/index.jsx';
import Header from './components/Header';
import Footer from './components/Footer';
import NavVertical from './components/NavVertical';
import NavHorizontal from './components/NavHorizontal';
import './App.css';

function App() {
  const [navOpen, setNavOpen] = useState(false);

  // Função para alternar o estado do menu lateral
  const toggleNav = () => {
    setNavOpen(!navOpen);
  };

  useEffect(() => {
    const handleResize = () => {
      if (window.innerWidth < 768) {
        setTimeout(() => {
          setNavOpen(false);
        }, 2000);
      }
    };

    // Executar no carregamento inicial
    handleResize();

    // Adicionar listener para redimensionamento
    window.addEventListener('resize', handleResize);

    // Cleanup
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []);

  return (
    <div className="app d-flex flex-column min-vh-100">
      <Header />
      <NavHorizontal />
      <div className="content-wrapper flex-grow-1 d-flex">
        <NavVertical isOpen={navOpen} toggleNav={toggleNav} />
        <main className={`p-3 flex-grow-1 ${navOpen ? 'ms-200' : 'ms-45'}`}>
          <Routes />
        </main>
      </div>
      <Footer />
    </div>
  );
}

export default App;

// C:\laragon\www\sgcpro\src\public\script\react_modelo_v1\frontend\src\routes\index.jsx
import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';

// Páginas principais
import Home from '../pages/Home';
import TesteSession from '../pages/Teste/SessionCookie';
import PaginaProvisoria from '../pages/Teste/PaginaProvisoria';
import PaginaModal from '../pages/Teste/PaginaModal';

// Circuitos
import CircuitosListar from '../pages/Circuito/AppListar';
import CircuitosCadastrar from '../pages/Circuito/AppCadastrar';
import CircuitosConsultar from '../pages/Circuito/AppConsultar';

// Secretarias
import SecretariasListar from '../pages/Secretaria/AppListar';
import SecretariasCadastrar from '../pages/Secretaria/AppCadastrar';
import SecretariasConsultar from '../pages/Secretaria/AppConsultar';

// Cobranças
import CobrancasListar from '../pages/Cobranca/AppListar';
import CobrancasCadastrar from '../pages/Cobranca/AppCadastrar';
import CobrancasConsultar from '../pages/Cobranca/AppConsultar';

// Contatos
import ContatosListar from '../pages/Contato/AppListar';
import ContatosCadastrar from '../pages/Contato/AppCadastrar';
import ContatosConsultar from '../pages/Contato/AppConsultar';

// Contrato (não encontrei Contato_operadoras na estrutura de diretórios)
import ContratosListar from '../pages/Contrato/AppListar';
import ContratosCadastrar from '../pages/Contrato/AppCadastrar';
import ContratosConsultar from '../pages/Contrato/AppConsultar';

// Empresas
import EmpresasListar from '../pages/Empresa/AppListar';
import EmpresasCadastrar from '../pages/Empresa/AppCadastrar';
import EmpresasConsultar from '../pages/Empresa/AppConsultar';

const RouteConfig = () => {
    return (
        <Routes>
            {/* Rotas principais */}
            <Route path="/" element={<Home />} />
            <Route path="/teste-session" element={<TesteSession />} />
            <Route path="/pagina-provisoria" element={<PaginaProvisoria />} />
            <Route path="/pagina-modal" element={<PaginaModal />} />
            
            {/* Rotas de Circuitos */}
            <Route path="/circuito/listar" element={<CircuitosListar />} />
            <Route path="/circuito/cadastrar" element={<CircuitosCadastrar />} />
            <Route path="/circuito/consultar" element={<CircuitosConsultar />} />
            
            {/* Rotas de Secretarias */}
            <Route path="/Secretaria/listar" element={<SecretariasListar />} />
            <Route path="/Secretaria/cadastrar" element={<SecretariasCadastrar />} />
            <Route path="/Secretaria/consultar" element={<SecretariasConsultar />} />
            
            {/* Rotas de Cobranças */}
            <Route path="/cobranca/listar" element={<CobrancasListar />} />
            <Route path="/cobranca/cadastrar" element={<CobrancasCadastrar />} />
            <Route path="/cobranca/consultar" element={<CobrancasConsultar />} />
            
            {/* Rotas de Contatos */}
            <Route path="/contato/listar" element={<ContatosListar />} />
            <Route path="/contato/cadastrar" element={<ContatosCadastrar />} />
            <Route path="/contato/consultar" element={<ContatosConsultar />} />
            
            {/* Rotas de Contratos */}
            <Route path="/contrato/listar" element={<ContratosListar />} />
            <Route path="/contrato/cadastrar" element={<ContratosCadastrar />} />
            <Route path="/contrato/consultar" element={<ContratosConsultar />} />
            
            {/* Rotas de Empresas */}
            <Route path="/empresa/listar" element={<EmpresasListar />} />
            <Route path="/empresa/cadastrar" element={<EmpresasCadastrar />} />
            <Route path="/empresa/consultar" element={<EmpresasConsultar />} />
            
            {/* Rota de fallback (redireciona URLs desconhecidas para Home) */}
            <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
    );
};

export default RouteConfig;