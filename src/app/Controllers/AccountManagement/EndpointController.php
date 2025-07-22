<?php 

namespace App\Controllers;

use CodeIgniter\RESTful\AccountManagement;
use CodeIgniter\API\ResponseTrait;
use App\Controllers\Pattern\TokenCsrfController;

use Exception;

class EndpointController extends ResourceController
{
    private $template = 'analise/templates/main';
    private $app_message_card = 'analise/AppMessageCard';
    private $app_loading = 'analise/AppLoading';
    private $app_footer = 'analise/AppFooter';
    private $app_json = 'analise/AppJson';
    private $app_head = 'analise/AppHead';
    private $app_menu = 'analise/AppMenu';
    private $message = 'analise/message';
    private $viewFormatacao;
    private $ModelResponse;
    private $viewValidacao;
    private $viewPadroes;
    private $tokenCsrf;
    private $token;
    private $uri;
    #
    public function __construct()
    {
        $this->uri = new \CodeIgniter\HTTP\URI(current_url());
        // $this->viewFormatacao = new SystemBaseController();
        // $this->viewValidacao = new SystemBaseController();
        // $this->viewPadroes = new SystemBaseController();
        // $this->tokenCsrf = new TokenCsrfController();
        $this->tokenCsrf = new TokenCsrfController();
        $this->token = isset($_COOKIE['token']) ? $_COOKIE['token'] : '123';
    }

    private function setAQpiRespond(string $status = null, string $message = '', array $requestJSONform = array(), array $loadView = array(), string $getMethod = null)
    {
        $apiRespond = [
            'status' => $status,
            'message' => $message !== '' ? $message : 'API loading data (dados para carregamento da API)',
            'date' => date('Y-m-d'),
            'api' => [
                'version' => '1.0',
                'method' => $getMethod,
                'description' => 'API Description',
                'content_type' => 'application/x-www-form-urlencoded'
            ],
            'result' => $requestJSONform,
            'loadView' => $loadView,
            'metadata' => [
                'page_title' => 'Título do Método',
                'getURI' => $this->uri->getSegments(),
                'method' => '__METHOD__',
                'function' => '__FUNCTION__',
            ]
        ];
        return $apiRespond;
    }
    private function setRequestJSONform(string $id = NULL, int $page = 1, int $limit = 10)
    {
        $requestJSONform = array(
            'id' => $id,
            'page' => $page,
            'limit' => $limit,
        );
        return $requestJSONform;
    }

    private function setView(array $loadView5 = array())
    {
        $loadView1 = array(
            $this->app_head,
            $this->app_menu,
            $this->message,
            $this->app_message_card,
            $this->app_loading,
            $this->app_json,
        );
        #
        // $loadView2 = $this->viewValidacao->camposValidacao();
        // $loadView3 = $this->viewPadroes->camposPadroes();
        // $loadView4 = $this->viewFormatacao->camposFormatacao();
        if (
            isset($loadView2) &&
            isset($loadView3) &&
            isset($loadView4) &&
            isset($loadView5) &&
            $loadView5 !== array()
        ) {
            $loadView6 = array(
                // $this->app_footer,
            );
            $loadView = array_merge($loadView1, $loadView2, $loadView3, $loadView4, $loadView5, $loadView6);
        } elseif (
            isset($loadView5) &&
            $loadView5 !== array()
        ) {
            $loadView = $loadView5;
        } else {
            $loadView6 = array(
                // $this->app_footer,
            );
            $loadView = array_merge($loadView1, $loadView6);
        }

        return $loadView;
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function index()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbRead()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbFilter()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbCreate()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbUpdate()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbDelete()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [view]
    public function dbCleanner()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }
}

?>