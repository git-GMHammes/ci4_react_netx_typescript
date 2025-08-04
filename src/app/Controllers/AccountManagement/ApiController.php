<?php
# C:\laragon\www\ci4_react_netx_typescript\src\app\Controllers\SecurityMonitoring\ApiController.php
namespace App\Controllers\AccountManagement;

use CodeIgniter\RESTful\ResourceController;
use CodeIgniter\API\ResponseTrait;
# 
use App\Controllers\AccountManagement\DbController;
use App\Controllers\Pattern\TokenCsrfController;
use App\Controllers\Pattern\MailController;
use App\Controllers\Pattern\MessageController;
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
    private $Mail;

    public function __construct()
    {
        $this->uri = new \CodeIgniter\HTTP\URI(current_url());
        $this->tokenCsrf = new TokenCsrfController();
        $this->Mail = new MailController();
        $this->message = new MessageController();
        $this->DbController = new DbController();
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
        // myPrint('$processRequest :: ', $processRequest, true);
        if (
            $server === '127.0.0.1'
            || $server === 'localhost'
            || $server === 'habilidade.com'
        ) {
            $passToken = true;
        } else {
            $passToken = $this->tokenCsrf->valid_token_csrf($token_csrf);
        }
        // myPrint('$passToken :: ', $passToken, true);
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
                // myPrint('$processRequest :: ', $processRequest);
                $dbResponse = $this->DbController->dbCreate($processRequest);
                if (isset($dbResponse["affectedRows"]) && $dbResponse["affectedRows"] > 0) {
                    $processRequestSuccess = true;
                    $this->Mail->sendMail($processRequest);
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

    # route POST /www/index.php/habilidade/usuario/api/salvar/(:any)
    # route GET /www/index.php/habilidade/usuario/api/salvar/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function create_update($parameter = NULL)
    {
        # Parâmentros para receber um POST
        $dbReadCPF = [];
        $dbReadWhatsapp = [];
        $dbReadEmail = [];
        $request = service('request');
        $getMethod = $request->getMethod();
        $processRequest = (array) $request->getVar();
        #
        try {
            if (isset($processRequest['data_nascimento'])) {
                $processRequest['data_nascimento'] = $this->validateAmericanDate($processRequest['data_nascimento']);
                if (empty($processRequest['data_nascimento'])) {
                    $code = 422;
                    $response = $this->getResponseApiRest($getMethod, $code);
                    return $this->response->setStatusCode($code)->setJSON($response);
                }
            }
            if (isset($processRequest['whatsapp'])) {
                $processRequest['zapMail'] = $processRequest['whatsapp'];
                $processRequest['whatsapp'] = $this->treatTelephone($processRequest['whatsapp']);
                $processRequest['user'] = $this->treatTelephone($processRequest['whatsapp']);
                $processRequest['login'] = $this->treatTelephone($processRequest['whatsapp']);
            } else {
                $processRequest['zapMail'] = '';
            }
            if ($this->treatDuplicity($processRequest)) {
                $code = 409;
                $response = $this->getResponseApiRest($getMethod, $code);
                return $this->response->setStatusCode($code)->setJSON($response);
            }
            #
            if ($getMethod == 'GET') {
                return $this->response->setStatusCode(200)->setJSON(['status' => 'invalid', 'message' => 'A requisição foi processada com sucesso, mas não há conteúdo para retornar no corpo da resposta.', 'date' => date('Y-m-d'), 'api' => ['version' => '1.0', 'method' => $getMethod, 'description' => 'API Description', 'content_type' => 'application/x-www-form-urlencoded'], 'result' => ['data' => 'void'], 'metadata' => ['page_title' => 'Application title', 'getURI' => ['index.php', 'fph', 'usuario', 'api', 'atualizar']]]);
            }
            #
            $token_csrf = (isset($processRequest['token_csrf']) ? $processRequest['token_csrf'] : 'erro');
            $json = isset($processRequest['json']) && $processRequest['json'] == 1 ? 1 : 0;
            $choice_update = (isset($processRequest['id']) && !empty($processRequest['id'])) ? (true) : (false);
            $senha = $processRequest['senha'];
            $hashSeguro = password_hash($senha, PASSWORD_DEFAULT);
            $processRequest['senha'] = $hashSeguro;
            #
            $dbSave = $this->saveRequest($choice_update, $token_csrf, $processRequest);
            $apiRespond = $this->setApiRespond($dbSave['status'], $getMethod, $dbSave['dbResponse']);
            $response = $this->response->setStatusCode(201)->setJSON(body: $apiRespond);
        } catch (\Exception $e) {
            $apiRespond = $this->setApiRespond('error', $getMethod, $processRequest, $e->getMessage());
            $response = $this->response->setStatusCode(500)->setJSON($apiRespond);
        }
        #
        return $response;
    }

    private function treatTelephone($parameter)
    {
        // Remove tudo que não for dígito usando expressão regular
        $digits = preg_replace('/\D/', '', $parameter);
        return $digits;
    }
    private function treatDuplicity($processRequest)
    {
        if (isset($processRequest['cpf'])) {
            $dbReadCPF = $this->DbController->dbReadCPF($processRequest['cpf']);
        }
        if (isset($processRequest['whatsapp'])) {
            $dbReadWhatsapp = $this->DbController->dbReadWhatsapp($processRequest['whatsapp']);
        }
        if (isset($processRequest['email'])) {
            $dbReadEmail = $this->DbController->dbReadEmail($processRequest['email']);
        }
        if (
            isset($dbReadCPF['dbResponse'][0]['id'])
            || isset($dbReadWhatsapp['dbResponse'][0]['id'])
            || isset($dbReadEmail['dbResponse'][0]['id'])
        ) {
            return true;
        } else {
            return false;
        }
    }
    private function validateAmericanDate($data)
    {
        // Remove espaços
        $data = trim($data);

        // Verifica se está no formato DD-MM-AAAA
        if (preg_match('/^(\d{2})-(\d{2})-(\d{4})$/', $data, $matches)) {
            $dia = $matches[1];
            $mes = $matches[2];
            $ano = $matches[3];
            // Valida a data
            if (checkdate((int) $mes, (int) $dia, (int) $ano)) {
                return "$ano-$mes-$dia";
            } else {
                return '';
            }
        }

        // Verifica se está no formato AAAA-MM-DD
        if (preg_match('/^(\d{4})-(\d{2})-(\d{2})$/', $data, $matches)) {
            $ano = $matches[1];
            $mes = $matches[2];
            $dia = $matches[3];
            if (checkdate((int) $mes, (int) $dia, (int) $ano)) {
                return "$ano-$mes-$dia";
            } else {
                return '';
            }
        }

        // Não é formato válido
        return '';
    }
    private function getResponseApiRest($getMethod, $code, $getMessage = false)
    {
        switch ($code) {

            case 200:
                $status = 'success';
                $message = 'Requisição bem-sucedida, autenticado.';
                $resposta = 'Código de status HTTP 200 OK. Indica que a solicitação foi processada com sucesso pelo servidor e, no contexto de autenticação, significa que o login foi realizado corretamente. O usuário forneceu as credenciais válidas e agora está autenticado para acessar os recursos protegidos. Nenhum erro ocorreu durante o processo de autenticação.';
                break;

            case 401:
                $status = 'error';
                $message = 'Não autorizado, autenticação, necessária.';
                $resposta = 'Código de status HTTP 401 Unauthorized. O servidor não conseguiu autenticar a solicitação porque as credenciais fornecidas (login e senha) estão incorretas ou ausentes. Esse erro ocorre quando o acesso ao recurso solicitado requer autenticação válida, mas as informações enviadas não são reconhecidas ou não foram fornecidas. Para corrigir, verifique se o login e a senha estão corretos e envie as credenciais apropriadas no cabeçalho da requisição.';
                break;

            case 409:
                $status = 'error';
                $message = 'Conflito, recurso, existente.';
                $resposta = 'Código de status HTTP 409 Conflict. O servidor não pôde completar a solicitação devido a um conflito com o estado atual do recurso. Esse erro geralmente ocorre quando há uma tentativa de criar ou atualizar um recurso que já existe ou conflita com outra operação simultânea. Para corrigir, verifique se os dados enviados não entram em conflito com registros existentes ou revise a lógica da aplicação para tratar atualizações concorrentes adequadamente.';
                break;

            case 422:
                $status = 'error';
                $message = 'Entidade inválida, processável. Verifique os dados enviados.';
                $resposta = 'Código de status HTTP 422 Unprocessable Entity. O servidor entende o tipo de conteúdo da solicitação e a sintaxe está correta, mas não conseguiu processar as instruções presentes. Esse erro geralmente ocorre quando os dados fornecidos estão semanticamente errados ou incompletos para a operação solicitada, como ao enviar um formulário com campos obrigatórios ausentes ou valores inválidos. Para corrigir, revise os dados enviados e garanta que estão em conformidade com as regras esperadas pelo endpoint.';
                break;

            default:
                $status = 'error';
                $message = isset($getMessage) ? $getMessage : 'Não Sou uma chaleira. Nenhum codigo foi definido.';
                $resposta = "Código de status HTTP 418 I'm a teapot. Esse código é uma resposta humorística definida pelo protocolo HTCPCP, indicando que o servidor se recusa a preparar café porque é uma chaleira. Não deve ser usado em aplicações reais, mas serve como resposta divertida quando a solicitação não faz sentido ou para fins de teste/brincadeira em APIs.";
                break;
        }

        $response = [
            'status' => $status,
            'message' => $message,
            "date" => date('Y-m-d'),
            "api" => [
                "version" => "1.0",
                "method" => $getMethod,
                "description" => "API Description",
                "content_type" => "application/x-www-form-urlencoded"
            ],
            "result" => [
                "resposta" => $resposta,
            ],
            "metadata" => [
                "page_title" => "Application title",
                "getURI" => $this->uri->getSegments(),
            ]
        ];
        return $response;
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

    # route POST /www/index.php/habilidade/gerenciamento/usuario/api/login/(:any)
    # route GET /www/index.php/habilidade/gerenciamento/usuario/api/login/(:any)
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function AccountLogin($parameter = NULL)
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
        try {
            #
            $requestDb = [];
            $senhaInformada = '';
            $senhaHashBanco = '';
            if (
                isset($processRequest['login'])
                && isset($processRequest['senha'])
            ) {
                $senhaInformada = $processRequest['senha'];
                $requestDb = $this->DbController->dbReadLogin($processRequest['login'], $page, $limit);
            }
            if (isset($requestDb['dbResponse'][0]['senha'])) {
                $senhaHashBanco = $requestDb['dbResponse'][0]['senha'];
            } else {
                $apiRespond = $this->setApiRespond('error', $getMethod, $requestDb, 'Usuário ou senha inválidos');
                return $this->response->setStatusCode(401)->setJSON($apiRespond);
            }
            $verifyLogin = password_verify($senhaInformada, $senhaHashBanco);
            if ($verifyLogin) {
                $code = 200;
                $response = $this->getResponseApiRest($getMethod, $code);
                return $this->response->setStatusCode($code)->setJSON($response);
            } else {
                $code = 401;
                $response = $this->getResponseApiRest($getMethod, $code);
                return $this->response->setStatusCode($code)->setJSON($response);
            }
            #

        } catch (\Exception $e) {
            $code = 500;
            $message = $e->getMessage();
            $response = $this->getResponseApiRest($getMethod, $code, $message);
            return $this->response->setStatusCode($code)->setJSON($response);
        }
    }

}
#
?>