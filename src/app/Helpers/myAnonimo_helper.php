<?php

/**
 * This file is part of CodeIgniter 4 framework.
 *
 * (c) CodeIgniter Foundation <admin@codeigniter.com>
 *
 * For the full copyright and license information, please view
 * the LICENSE file that was distributed with this source code.
 */

use CodeIgniter\HTTP\Response;


// CodeIgniter Decriptografar
if (!function_exists('ehTokenCriptografado')) {
    # retorna os dados de um determinado item no código
    function ehTokenCriptografado($valor)
    {
        // Verifica se o valor parece ser um token criptografado, com base nas regras fornecidas

        // Se o valor contiver números ou caracteres especiais (que não são números), tratamos como token
        if (preg_match('/[^A-Za-z0-9]/', $valor)) {
            return true; // Considera como token criptografado
        }

        // Se o valor for o CPF e contiver letras, consideramos como token
        if (strlen($valor) == 11 && preg_match('/[A-Za-z]/', $valor)) {
            return true; // Considera como token CPF
        }

        return false; // Não é um token, retorna false
    }
}

// CodeIgniter Criptografar
if (!function_exists('criptografar')) {
    # retorna os dados de um determinado item no código
    function criptografar($valor)
    {
        // Dados para tokenização
        $dadosParaCriptografar = [
            [
                "data" => $valor,
                "tokentemplate" => "FIAPTPA",
                "tokengroup" => "FIAPTPA"
            ]
        ];

        // Configuração da autenticação
        $authString = 'FIATokenize:i@VL20S60#@|';
        $authBase64 = base64_encode($authString);

        // myPrint($dadosParaCriptografar, $authBase64);

        // Requisição à API de tokenização
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://10.19.224.4/vts/rest/v2.0/tokenize");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($dadosParaCriptografar));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Basic ' . $authBase64,
            'Accept: application/json',
            'Access-Control-Allow-Origin": "*"',
        ]);

        // Ignorar verificação de certificado (somente para testes)
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

        $response = curl_exec($ch);

        if (curl_errno($ch)) {
            curl_close($ch);
            throw new Exception("Erro na comunicação com a API de anonimização: " . curl_error($ch));
        }

        curl_close($ch);

        $tokenizedData = json_decode($response, true);

        if (!isset($tokenizedData[0]['token'])) {
            throw new Exception("Erro na anonimização dos dados.");
        }

        return $tokenizedData[0]['token'];

    }
}

// CodeIgniter Decriptografar
if (!function_exists('decriptografar')) {
    # retorna os dados de um determinado item no código
    function decriptografar($valor)
    {
        // Verifica se o valor está vazio
        if (empty($valor)) {
            return null;
        }

        // Configuração da autenticação
        $authString = 'FIATokenize:i@VL20S60#@|';
        $authBase64 = base64_encode($authString);

        // Dados a serem detokenizados (criptografados)
        $dadosParaDetokenizar = [
            'token' => $valor, // Substitua pelo valor do token a ser detokenizado
            'tokentemplate' => 'FIAPTPA',
            'tokengroup' => 'FIAPTPA'
        ];

        // Inicia a requisição CURL
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://10.19.224.4/vts/rest/v2.0/detokenize");
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($dadosParaDetokenizar));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Authorization: Basic ' . $authBase64,
            'Accept: application/json',
            'Access-Control-Allow-Origin: *',
        ]);

        // Desabilita a verificação do certificado SSL (apenas em ambientes de desenvolvimento)
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);

        // Executa a requisição CURL
        $response = curl_exec($ch);
        $err = curl_error($ch);

        // Captura o código de status HTTP
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        // Fecha a conexão CURL
        curl_close($ch);

        // Verifica se houve algum erro na requisição
        if ($err) {
            // Se houve erro, loga o erro
            log_message('error', "Erro CURL: " . $err);
            return null;
        }

        // Se o código HTTP não for 200, retorna null
        if ($httpCode != 200) {
            log_message('error', "Erro HTTP: " . $httpCode . " - Resposta da API: " . $response);
            return null;
        }

        // Decodifica a resposta JSON
        $response_data = json_decode($response, true);

        // Verifica se a resposta contém dados válidos
        if (isset($response_data['data'])) {
            return $response_data['data'];
        }

        // Se a resposta não for válida, loga e retorna null
        log_message('error', "Resposta inválida da API: " . $response);
        return null;
    }
}
?>