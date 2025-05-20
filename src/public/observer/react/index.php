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
echo "[NEXT] http:// + localhost ou 127.0.0.1 -- portas(7777 ou 9999)/" . PHP_EOL;
echo "│" . PHP_EOL;
echo "└── script\\" . PHP_EOL;

// Exibe a estrutura a partir do diretório 'script'
exibirEstrutura('../../script', "    ");

// Adiciona uma linha em branco entre as exibições
echo PHP_EOL;
// Adiciona uma linha em branco entre as exibições
echo PHP_EOL;
?>
