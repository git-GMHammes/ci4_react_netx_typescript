<?php
#
namespace App\Controllers\Pattern;

use CodeIgniter\Controller;
use Exception;


class MailController extends Controller
{
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


    # route POST /www/index.php/exemple/group/api/exibir/(:any))
    # route GET /www/index.php/exemple/group/api/exibir/(:any))
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function SendMail($parameter = NULL)
    {
        # Parâmentros para receber um POST
        $getMethod = 'Pattern';
        $json = 1;
        #
        if (isset($parameter['senha'])) {
            unset($parameter['senha']);
        }
        if (isset($parameter['user'])) {
            unset($parameter['user']);
        }
        if (isset($parameter['data_nascimento'])) {
            $parameter['data_nascimento'] = $this->DateBr($parameter['data_nascimento']);
        }
        if (
            isset($parameter['zapMail'])
            && !empty($parameter['zapMail'])
        ) {
            $parameter['whatsapp'] = $parameter['zapMail'];
            unset($parameter['zapMail']);
        }
        // myPrint('$parameter :: ', $parameter);
        #
        try {
            // Verifica se os parâmetros foram recebidos corretamente
            if (!is_array($parameter) || empty($parameter['email'])) {
                throw new \Exception('Parâmetros inválidos ou email de destino não informado.');
            }

            $emailConfig = [
                'protocol' => 'smtp',
                'SMTPHost' => 'smtp.kinghost.net',
                'SMTPUser' => 'sendmail@habilidade.com',
                'SMTPPass' => F58B9E8A887C14D97BA7B94BC407EB86,
                'SMTPPort' => 465,
                'SMTPCrypto' => 'ssl',
                'mailType' => 'html',
                'charset' => 'utf-8',
                'newline' => "\r\n",
                'wordWrap' => true,
                'validate' => true,
            ];

            $email = \Config\Services::email();
            $email->initialize($emailConfig);

            // Monta o corpo do email
            $body = '<h3>Dados recebidos:</h3><ul>';

            foreach ($parameter as $key => $value) {
                $body .= '<li><b>' . ucwords(str_replace('_', ' ', $key)) . ':</b> ' . $value . '</li>';
            }
            $body .= '</ul>';

            $protocolo = strtoupper(md5(time() . rand(1000, 9999)));
            $email->setFrom($emailConfig['SMTPUser'], 'Habilidade.Com');
            $email->setTo($parameter['email']);
            $email->setSubject('Confirmação de Cadastro - Protocolo : ' . $protocolo);
            $email->setMessage($body);

            if ($email->send()) {
                return json_encode(['status' => 'success', 'msg' => 'E-mail enviado com sucesso!']);
            } else {
                // Debug de erro
                return json_encode(['status' => 'error', 'msg' => $email->printDebugger(['headers'])]);
            }
        } catch (\Exception $e) {
            return json_encode(['status' => 'error', 'msg' => $e->getMessage()]);
        }
    }
    private function DateBr($parameter)
    {
        // Tenta criar um objeto DateTime com o formato esperado
        $date = \DateTime::createFromFormat('Y-m-d', $parameter);

        // Verifica se a data é válida e se não há erros de parsing
        if ($date && $date->format('Y-m-d') === $parameter) {
            // Retorna no formato brasileiro
            return $date->format('d/m/Y');
        } else {
            // Retorna nulo ou uma mensagem de erro, se preferir
            return '';
        }
    }

    # route POST /www/index.php/projeto/objeto/api/cadastrar/(:any)
    # route GET /www/index.php/projeto/objeto/api/cadastrar/(:any)
    # route POST /www/index.php/projeto/objeto/api/atualizar/(:any)
    # route GET /www/index.php/projeto/objeto/api/atualizar/(:any)
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
}
#
?>