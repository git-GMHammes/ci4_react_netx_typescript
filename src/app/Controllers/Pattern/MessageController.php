<?php

namespace App\Controllers\Pattern;

use CodeIgniter\Controller;
use Exception;

class MessageController extends Controller
{
    private $message;
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

    # use App\Controllers\MessageController;
    # private $message;
    # $this->message = new MessageController();
    # $this->message->message($message = array(), $typeMessage, $dataValue = array(), $tempData = 5);
    # 'success', 'warning', 'danger'
    public function message($message = array(), $typeMessage = '', $dataValue = array(), $tempData = 5)
    {
        if (session()->get('message')) {
            session()->remove('message');
            // myPrint(session()->get('message'), '');
        }
        // myPrint($message, '', true);
        // myPrint($typeMessage, '', true);
        // myPrint($dataValue, '', true);
        // myPrint($tempData, '', true);
        try {
            // ['success', 'warning', 'danger'];
            if ($message !== array()) {
                $setMessage['message'][$typeMessage] = $message;
                session()->set('message', $setMessage);
                #
                session()->markAsTempdata('message', $tempData);
                #
                if ($dataValue !== array()) {
                    session()->set('value_form', $dataValue);
                }
                session()->markAsTempdata('message', $tempData);
            }
            // if (session()->get('message')) {
            // $apiSession = session()->get('message');
            // myPrint($apiSession, '');
            // }
        } catch (Exception $e) {
            $message['message']['danger'] = $e->getMessage();
            session()->set('message', $message);
            session()->markAsTempdata('message', $tempData);
        }
    }
}
