<?php
# C:\laragon\www\ci4_react_netx_typescript\src\app\Controllers\SecurityMonitoring\ApiController.php
namespace App\Controllers\SecurityMonitoring;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
# 
// use App\Controllers\Pattern\TokenCsrfController;
// use App\Controllers\Pattern\MessageController;
// use App\Controllers\Pattern\ObjetoDbController;
// use App\Controllers\Pattern\SystemUploadDbController;
# 
use Exception;

class ApiController extends ResourceController
{
    use ResponseTrait;
    private $ModelResponse;
    private $uri;
    private $tokenCsrf;
    private $DbController;
    private $message;

    public function __construct()
    {
        $this->uri = new \CodeIgniter\HTTP\URI(current_url());
        // $this->DbController = new ObjetoDbController();
        // $this->tokenCsrf = new TokenCsrfController();
        // $this->message = new MessageController();
        #
    }

    # route POST /www/index.php/project/method
    # route GET /www/index.php/project/method
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function index($parameter = NULL)
    {
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }

    # Prepara o retorno da API
    private function setApiRespond(string $status = 'success', string $getMethod = 'GET', array $requestDb = array(), $message = 'API loading data (dados para carregamento da API)')
    {
        # $message = 'API loading data (dados para carregamento da API)',
        $apiRespond = [
            'status' => $status,
            'message' => $message,
            'date' => date('Y-m-d'),
            'api' => [
                'version' => '1.0',
                'method' => $getMethod,
                'description' => 'API Description',
                'content_type' => 'application/x-www-form-urlencoded'
            ],
            'result' => $requestDb,
            'metadata' => [
                'page_title' => 'Application title',
                'getURI' => $this->uri->getSegments(),
                // Você pode adicionar campos comentados anteriormente se forem relevantes
                // 'method' => '__METHOD__',
                // 'function' => '__FUNCTION__',
            ]
        ];

        return $apiRespond;
    }

    # Salva o request no banco de dados
    private function saveRequest(bool $choice_update = false, string $token_csrf = 'erro', array $processRequest = array())
    {
        $processRequestSuccess = false;
        $server = $_SERVER['SERVER_NAME'];
        if ($server !== '127.0.0.1') {
            $passToken = $this->tokenCsrf->valid_token_csrf($token_csrf);
        } else {
            $passToken = true;
        }
        if ($choice_update === true) {
            if ($passToken) {
                $id = (isset($processRequest['id'])) ? ($processRequest['id']) : (array());
                $dbResponse = $this->DbController->dbUpdate($id, $processRequest);
                if (isset($dbResponse["affectedRows"]) && $dbResponse["affectedRows"] > 0) {
                    $processRequestSuccess = true;
                }
            }
        } elseif ($choice_update === false) {
            if ($passToken) {
                // return $this->response->setJSON($processRequest, 200);
                $dbResponse = $this->DbController->dbCreate($processRequest);
                if (isset($dbResponse["affectedRows"]) && $dbResponse["affectedRows"] > 0) {
                    $processRequestSuccess = true;
                }
            }
        } else {
            $this->message->message(['ERRO: Dados enviados inválidos'], 'danger');
            $dbResponse = array();
            $processRequestSuccess = false;
        }
        #
        $dbSave = [
            'processRequestSuccess' => $processRequestSuccess,
            'dbResponse' => $dbResponse,
            'status' => !isset($processRequestSuccess) || $processRequestSuccess !== true ? 'trouble' : 'success',
            'message' => !isset($processRequestSuccess) || $processRequestSuccess !== true ? 'Erro - requisição que foi bem-formada mas não pôde ser seguida devido a erros semânticos.' : 'API loading data (dados para carregamento da API)',
            'cod_http' => !isset($processRequestSuccess) || $processRequestSuccess !== true ? 422 : 201,
        ];
        #
        return $dbSave;
    }

    # route POST /www/index.php/habilidade/vigilancia/api/salvar/(:any)
    # route GET /www/index.php/habilidade/vigilancia/api/salvar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function create_update($parameter = NULL)
    {
        $dbResponse = array();
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }

    # route POST /www/index.php/projeto/objeto/api/filtrar/(:any)
    # route GET /www/index.php/projeto/objeto/api/filtrar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function dbFilter($parameter = NULL)
    {
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }


    # route POST /www/index.php/projeto/objeto/api/listar/(:any)
    # route GET /www/index.php/projeto/objeto/api/listar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function dbRead($parameter = NULL)
    {
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }

    # route POST /www/index.php/projeto/objeto/api/deletar/(:any)
    # route GET /www/index.php/projeto/objeto/api/deletar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function dbDelete($parameter = NULL)
    {
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }

    # route POST /www/index.php/projeto/objeto/api/limpar/(:any)
    # route GET /www/index.php/projeto/objeto/api/limpar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function dbClear($parameter = NULL)
    {
        $request = service('request');
        $apiRespond['getMethod'] = $request->getMethod();
        $apiRespond['method'] = __METHOD__;
        $apiRespond['function'] = __FUNCTION__;
        $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
        return $this->response->setStatusCode(403)->setJSON($apiRespond);
    }

    # route POST /www/index.php/habilidade/anonymous/api/obsolete/(:any)
    # route GET /www/index.php/habilidade/anonymous/api/obsolete/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function foolishness($parameter = NULL)
    {
        # Parâmentros para receber um POST
        $request = service('request');
        $getMethod = $request->getMethod();
        $pageGet = $this->request->getGet('page');
        $limitGet = $this->request->getGet('limit');
        $limit = (isset($limitGet) && !empty($limitGet)) ? ($limitGet) : (10);
        $page = (isset($pageGet) && !empty($pageGet)) ? ($pageGet) : (1);
        $processRequest = (array) $request->getVar();
        $json = isset($processRequest['json']) && $processRequest['json'] == 1 ? 1 : 0;
        $id = isset($processRequest['id']) ? ($processRequest['id']) : ($parameter);
        #
        #
        require_once(APPPATH . 'Libraries/JWT/src/BeforeValidException.php');
        require_once(APPPATH . 'Libraries/JWT/src/ExpiredException.php');
        require_once(APPPATH . 'Libraries/JWT/src/SignatureInvalidException.php');
        require_once(APPPATH . 'Libraries/JWT/src/JWT.php');
        require_once(APPPATH . 'Libraries/JWT/src/Key.php');

        $payload = [
            'iss' => base_url(),
            'aud' => base_url(),
            'iat' => time(),
            'exp' => time() + (5 * 12 * 30 * 24 * 60 * 60),
            // 'exp' => time() + (30),
            'data' => [
                'userId' => 'fiaptpa',
                'email' => 'gfs@proderj.rj.gov.br'
            ]
        ];
        $secretKey = KEY_JWT;
        $jwt = \Firebase\JWT\JWT::encode($payload, $secretKey, 'HS256');
        // myPrint($getMethod, 'C:\Users\Habilidade.Com\AppData\Roaming\Code\User\snippets\php.json');
        try {
            #
            $request = array(
                'Auth Type' => 'OAuth 2.0',
                'Bearer' => 'Bearer',
                'jwt' => $jwt,
            );
            #
            $apiRespond = $this->setApiRespond('success', $getMethod, $request);
            $response = $this->response->setStatusCode(201)->setJSON($apiRespond);
        } catch (\Exception $e) {
            $apiRespond = $this->setApiRespond('error', $getMethod, $requestDb, $e->getMessage());
            // myPrint('Exception $e :: ', $e->getMessage());
            $response = $this->response->setStatusCode(500)->setJSON($apiRespond);
        }
        if ($json == 1) {
            return $response;
            // return redirect()->back();
            // return redirect()->to('project/endpoint/parameter/parameter/' . $parameter);
        } else {
            return $response;
        }
    }


}
#
?>