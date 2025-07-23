<?php

namespace App\Controllers\Pattern;

use App\Controllers\MessageController;
use CodeIgniter\Controller;
use Exception;

class MailController extends Controller
{
    private $message;
    private $uri;
    public function __construct()
    {
        $this->message = new MessageController();
        $this->uri = new \CodeIgniter\HTTP\URI(current_url());
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

    protected function stringToArray($email)
    {
        if (is_null($email)) {
            return [];
        }

        if (!is_array($email)) {
            $email = (string) $email; // Garantir que $email seja uma string
            return (strpos($email, ',') !== false) ? preg_split('/[\s,]/', $email, -1, PREG_SPLIT_NO_EMPTY) : (array) trim($email);
        }

        return $email;
    }

    # use App\Controllers\SystemMailController;
    # private $sendMail;
    # $this->sendMail = new SystemMailController();
    # $this->sendMail->sendPerguntaAgenersa($parameter = array());
    public function sendPerguntaAgenersa($parameter = array())
    {
        $setFrom = isset($parameter['setFrom']) ? ($parameter['setFrom']) : ('gfs@proderj.rj.gov.br');
        $setMail = isset($parameter['setMail']) ? ($parameter['setMail']) : ('gustavo.hammes@extreme.digital');
        $setCC = isset($parameter['setCC']) ? ($parameter['setCC']) : ('sistema.gustavo@gmail.com');
        // $setMail = 'ouvidoria@agenersa.rj.gov.br';
        $templateEmail['pergunta_agenersa'] = isset($parameter['pergunta_agenersa']) ? ($parameter['pergunta_agenersa']) : ('Erro ao processar a pergunta');
        $messageMail = view('agenersa/pergunta/main', $templateEmail);
        #
        // return view('agenersa/pergunta/main', $templateEmail);
        # 
        $config['protocol'] = 'smtp';
        $config['SMTPHost'] = 'relay.proderj.rj.gov.br';
        $config['SMTPCrypto'] = false;
        $config['SMTPPort'] = 25;
        $config['mailType'] = 'html';
        $config['SMTPTimeout'] = 256;
        $config['mailPath'] = '/usr/sbin/sendmail';
        # 
        $config['charset'] = 'utf-8';
        $config['wordWrap'] = true;
        $email = \Config\Services::email();
        # -- Config Settings
        $email->setHeader('Content-Type', 'text/html; charset=UTF-8');
        $email->setHeader('Content-Transfer-Encoding', 'quoted-printable');
        $email->initialize($config);
        $email->setFrom($setFrom, 'Portal Agenenrsa');
        $email->setTo($this->stringToArray($setMail));
        $email->setCC($this->stringToArray($setCC));
        $email->setSubject('[Pergunta/AGENERSA]: Caixa de Perguntas (' . date('d/m/Y H:i:s') . ')');
        $email->setMessage($messageMail);
        # -- Anexar a imagem
        $email->attach(FCPATH . 'assets/img/agenersa/LogoAgenersa_Centro.png', 'inline', 'image1');
        #
        $sendMessage = $email->send();
        $result = $sendMessage;
    }

    # use App\Controllers\SystemMailController;
    # private $sendMail;
    # $this->sendMail = new SystemMailController();
    # $this->sendMail->sendOuvidoriaAgenersa($parameter = array());
    # 'success', 'warning', 'danger'
    public function sendOuvidoriaAgenersa($parameter1 = array(), $parameter2 = array())
    {
        
        try {
            if (
                isset($parameter1['destination'])
                && $parameter1['destination'] == 'cliente'
            ) {
                $setMail = isset($parameter1['email']) ? ($parameter1['email']) : (null);
            } else {
                $setMail = 'ouvidoria@agenersa.rj.gov.br';
                // $setMail = 'mensagem.gustavo@gmail.com';
                $parameter1['destination'] = 'ouvidoria';
            }
            $templateEmail['result'] = $parameter1;
            $templateEmail['upload'] = $parameter2;
            $messageMail = view('agenersa/ouvidoria/mail/template', $templateEmail);
            // http://servicoapi.proderj.rj.gov.br/agenersa/ouvidoria/endpoint/enviar
            // return view('agenersa/ouvidoria/mail/template', $templateEmail);
            $protocol = isset($parameter1['protocolo']) ? ($parameter1['protocolo']) : (null);
            #
            $config['protocol'] = 'smtp';
            $config['SMTPHost'] = 'relay.proderj.rj.gov.br';
            $config['SMTPCrypto'] = false;
            $config['SMTPPort'] = 25;
            $config['mailType'] = 'html';
            $config['SMTPTimeout'] = 256;
            $config['mailPath'] = '/usr/sbin/sendmail';
            // $config['charset']  = 'iso-8859-1';
            $config['charset'] = 'utf-8';
            $config['wordWrap'] = true;
            $email = \Config\Services::email();
            # -- Config Settings
            $email->setHeader('Content-Type', 'text/html; charset=UTF-8');
            $email->setHeader('Content-Transfer-Encoding', 'quoted-printable');
            $email->initialize($config);
            $email->setFrom('ouvidoria@agenersa.rj.gov.br', 'Ouvidoria');
            $email->setTo($this->stringToArray($setMail));
            $email->setCC($this->stringToArray('gustavo.hammes@extreme.digital'));
            $email->setSubject('[Ouvidoria/AGENERSA]: Confirmação de Envio (' . date('d/m/Y H:i:s') . ')');
            $email->setMessage($messageMail);
            $sendMessage = $email->send();
            $result = $sendMessage;
        } catch (Exception $e) {
            $result = $this->message->message(array($e), 'danger', $parameter1, 5);
            // myPrint($result, 'src\app\Controllers\SystemMailController.php');
            return $result;
        }
    }
}
