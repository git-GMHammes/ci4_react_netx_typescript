<?php

namespace App\Controllers\Pattern;
use CodeIgniter\Controller;

use Exception;

class SystemBaseController extends Controller
{
    private $message;
    private $view_path = 'novodeposito';
    public function __construct()
    {
        $this->message = array();
    }
    #
    # route POST /www/sigla/rota
    # route GET /www/sigla/rota
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function index()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # use App\Controllers\SystemBaseController;
    # private $pagination;
    # $this->pagination = new SystemBaseController();
    # $linksArray = $this->pagination->extractPaginationLinks($paginationLinks);
    public function extractPaginationLinks($paginationLinks)
    {
        $dom = new \DOMDocument();
        @$dom->loadHTML($paginationLinks);
        $links = [];

        foreach ($dom->getElementsByTagName('a') as $node) {
            $href = $node->getAttribute('href');
            $parsedUrl = parse_url($href);
            parse_str($parsedUrl['query'], $queryParams);

            $page = isset($queryParams['page']) ? $queryParams['page'] : 1;

            // Tradução dos textos (Exemplo: adaptado para português)
            $text = $node->textContent;
            // myPrint($text, '', true);
            $text = str_replace("Previous", "Anterior", $text);
            $text = str_replace("First", "Primeiro", $text);
            $text = str_replace("Next", "Próximo", $text);
            $text = str_replace("Last", "Último", $text);

            $links[] = [
                'href' => '?page=' . $page,
                'text' => $text
            ];
        }
        // exit('FIM');
        return $links;
    }

    # use App\Controllers\SystemBaseController;
    # private $recebeBase;
    # $this->recebeBase = new SystemBaseController();
    # $data_calendario  = $this->recebeBase->recebeData($ano, $mes, $dia);
    function recebeData($parameter1, $parameter2 = null, $paramenter3 = null)
    {
        $data_calendario = '';

        $date = \DateTime::createFromFormat('Y-m-d', $parameter1);
        $valida = $date && $date->format('Y-m-d') === $parameter1;

        if (
            strlen($parameter1) === 10 &&
            $valida
        ) {
            $data_calendario = $parameter1;
        } else {
            switch (true) {
                case ($parameter1 && $parameter2 && $paramenter3):
                    // Quando tem parameter1, mês e paramenter2
                    $data_calendario = "$parameter1-$parameter2-$paramenter3";
                    break;

                case ($parameter1 && $parameter2):
                    // Quando tem apenas parameter1 e parameter2
                    $data_calendario = "$parameter1-$parameter2";
                    break;

                case ($parameter1):
                    // Quando tem apenas o parameter1
                    $data_calendario = "$parameter1";
                    break;

                default:
                    $data_calendario = null;
                    break;
            }
        }
        // myPrint($data_calendario, 'src\app\Controllers\SystemBaseController.php');
        return $data_calendario;
    }


    # use App\Controllers\SystemBaseController;
    # private $viewValidacao;
    # $this->viewValidacao = new SystemBaseController();
    # $loadView2 = $this->viewValidacao->camposValidacao();
    public function camposValidacao()
    {
        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposValidacao';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }
        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposValidacao';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }

        // Remove a extensão .php dos arquivos e adiciona o caminho
        $files = array_map(function ($file) {
            return $this->view_path . '/' . 'camposValidacao/' . pathinfo($file, PATHINFO_FILENAME);
        }, $files);

        return $files;
    }

    # use App\Controllers\SystemBaseController;
    # private $viewPadroes;
    # $this->viewPadroes = new SystemBaseController();
    # $loadView3 = $this->viewPadroes->camposValidacao();
    public function camposPadroes()
    {
        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposPadroes';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }
        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposPadroes';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }

        // Remove a extensão .php dos arquivos e adiciona o caminho
        $files = array_map(function ($file) {
            return $this->view_path . '/' . 'camposPadroes/' . pathinfo($file, PATHINFO_FILENAME);
        }, $files);

        return $files;
    }

    # use App\Controllers\SystemBaseController;
    # private $viewCamposFormatacao;
    # $this->viewCamposFormatacao = new SystemBaseController();
    # $loadView3 = $this->viewCamposFormatacao->camposFormatacao();
    public function camposFormatacao()
    {
        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposFormatacao';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }

        // Caminho da pasta que deseja listar
        $folderPath = APPPATH . 'Views' . DIRECTORY_SEPARATOR . $this->view_path . DIRECTORY_SEPARATOR . 'camposFormatacao';

        if (is_dir($folderPath)) {
            $files = array_diff(scandir($folderPath), ['.', '..']);
        } else {
            $files = [];
        }

        // Remove a extensão .php dos arquivos e adiciona o caminho
        $files = array_map(function ($file) {
            return $this->view_path . '/' . 'camposFormatacao/' . pathinfo($file, PATHINFO_FILENAME);
        }, $files);

        return $files;
    }
}
