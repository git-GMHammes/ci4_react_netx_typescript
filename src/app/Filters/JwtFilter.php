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
        if (in_array('anonymous', $filtro) && in_array('obsolete', $filtro)) {
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
            $response = Services::response();
            return $response->setJSON(['error' => 'Invalid authorization header'])->setStatusCode(ResponseInterface::HTTP_UNAUTHORIZED);
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