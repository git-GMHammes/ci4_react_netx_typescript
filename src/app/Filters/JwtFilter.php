<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\Response;
use Config\Services;

class JwtFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        $uri = new \CodeIgniter\HTTP\URI(current_url());
        $filtro = $uri->getSegments();
        $server = base_url();
        if (
            in_array('anonymous', $filtro)
            && in_array('obsolete', $filtro)
            || in_array('home', $filtro)
            || $server === 'http://127.0.0.1:56000/src/public/'
        ) {
            return;
        }
        // Incluindo os arquivos manualmente
        require_once(APPPATH . 'Libraries/JWT/src/BeforeValidException.php');
        require_once(APPPATH . 'Libraries/JWT/src/ExpiredException.php');
        require_once(APPPATH . 'Libraries/JWT/src/SignatureInvalidException.php');
        require_once(APPPATH . 'Libraries/JWT/src/JWT.php');
        require_once(APPPATH . 'Libraries/JWT/src/Key.php');

        $keys = [
            "key1" => new \Firebase\JWT\Key(KEY_JWT, 'HS256')
        ];
        // myPrint($keys, 'src\app\Filters\EprocMniJwtFilter.php');

        $authHeader = $request->getServer('HTTP_AUTHORIZATION');
        $arr = explode(' ', $authHeader);

        // Verifica se o cabeçalho de autorização está no formato correto
        if (count($arr) != 2) {
            $request = service('request');
            $apiRespond['getMethod'] = $request->getMethod();
            $apiRespond['method'] = __METHOD__;
            $apiRespond['function'] = __FUNCTION__;
            $apiRespond['message'] = '403 Forbidden - Directory access is forbidden.';
            $response = Services::response();
            return $response->setJSON($apiRespond)->setStatusCode(ResponseInterface::HTTP_UNAUTHORIZED);
        }

        $token = $arr[1];
        // myPrint($token, 'src\app\Filters\EprocMniJwtFilter.php');

        if ($token) {
            try {
                $decoded = \Firebase\JWT\JWT::decode($token, $keys['key1']);
                // myPrint($decoded, 'src\app\Filters\EprocMniJwtFilter.php');
            } catch (\Exception $e) {
                $response = Services::response();
                return $response->setJSON(['error' => $e->getMessage()])->setStatusCode(ResponseInterface::HTTP_UNAUTHORIZED);
            }
        } else {
            $response = Services::response();
            return $response->setJSON(['error' => 'Token not found'])->setStatusCode(ResponseInterface::HTTP_UNAUTHORIZED);
        }

        // Zera as variáveis após a verificação
        // $authHeader = null;
        // $arr = null;
        // $token = null;
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Do something here
    }
}