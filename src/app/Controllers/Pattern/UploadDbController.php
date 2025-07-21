<?php

namespace App\Controllers;

// use App\Models\System\UploadModel;
use App\Controllers\Pattern\MessageController;

use Exception;

class UploadDbController extends BaseController
{
    private $ModelUpload;
    private $message;
    private $uri;

    public function __construct()
    {
        // $this->ModelUpload = new UploadModel();
        $this->uri = new \CodeIgniter\HTTP\URI(current_url());
        $this->message = new MessageController();
    }

    # route POST /www/sigla/rota
    # route GET /www/sigla/rota
    # Informação sobre o controller
    # retorno do controller [JSON]
    public function index()
    {
        exit('403 Forbidden - Directory access is forbidden.');
    }

    # use App\Controllers\SystemUploadDbController;
    # private $DbController;
    # $this->DbController = new SystemUploadDbController();
    # $this->DbController->dbFields($fileds = array();
    public function dbFields($processRequestFields = array())
    {
        // myPrint($processRequestFields, 'src\app\Controllers\SystemUploadDbController.php', true);
        $dbCreate = array();
        (isset($processRequestFields['submitField'])) ? ($dbCreate['dbField'] = $processRequestFields['submitField']) : (NULL);
        // myPrint($dbCreate, 'src\app\Controllers\SystemUploadDbController.php');
        return ($dbCreate);
    }

    # use App\Controllers\SystemUploadDbController;
    # private $DbController;
    # $this->DbController = new SystemUploadDbController();
    # $this->DbController->dbUpdate($fileds = array();
    public function dbUpdate($id, $parameter = array())
    {
        $dbUpdate = $this->dbFields($parameter);
        $this->ModelUpload->dbUpdate(
            $id,
            $this->dbFields($dbUpdate),
        );
        if ($this->ModelUpload->affectedRows() > 0) {
            $this->message->message(['Update realizado com sucesso'], 'success');;
            $processRequestSuccess = true;
        } else {
            $processRequestSuccess = false;
        }
        return array(
            'status' => $processRequestSuccess,
            'id' => $id,
            'parameter' => $dbUpdate
        );
    }

    # use App\Controllers\SystemUploadDbController;
    # private $DbController;
    # $this->DbController = new SystemUploadDbController();
    # $this->DbController->dbCreate($fileds = array();
    public function dbCreate($parameter = array())
    {
        // myPrint($parameter, 'src\app\Controllers\SystemUploadDbController.php', true);
        // myPrint($this->dbFields($parameter), 'src\app\Controllers\SystemUploadDbController.php', true);
        $this->ModelUpload->dbCreate($this->dbFields($parameter));
        $id = ($this->ModelUpload->affectedRows() > 0) ? ($this->ModelUpload->insertID()) : (NULL);
        if ($this->ModelUpload->affectedRows() > 0) {
            $this->message->message(['Create realizado com sucesso'], 'success');
            $processRequestSuccess = true;
        } else {
            $processRequestSuccess = false;
        }
        return array(
            'status' => $processRequestSuccess,
            'id' => $id,
        );
    }

    # use App\Controllers\SystemUploadDbController;
    # private $DbController;
    # $this->DbController = new SystemUploadDbController();
    # $this->DbController->dbRead($parameter);
    public function dbRead($parameter = NULL)
    {
        try {
            if ($parameter !== NULL) {
                $dbResponse = $this->ModelUpload
                    ->where('aplication_id', $parameter)
                    ->where('deleted_at', NULL)
                    ->orderBy('updated_at', 'asc')
                    ->dBread()
                    ->find();
                #
            } else {
                $dbResponse = $this->ModelUpload
                    ->where('deleted_at', NULL)
                    ->orderBy('updated_at', 'asc')
                    ->dBread()
                    ->findAll();
            };
        } catch (Exception $e) {
            $dbResponse = array(
                'message' => array('danger' => $e->getMessage()),
                'page_title' => 'Application title',
                'getURI' => $this->uri->getSegments(),
            );
            $this->message->message(array($e->getMessage()), 'danger',);
        }
        $result = $dbResponse;
        return $result;
    }
}
