<?php

namespace App\Models;

use CodeIgniter\Database\Query;
use CodeIgniter\Model;
use App\Controllers\Pattern\MessageController;
use App\Models\BaseCrudModel;

class UserManagementModels extends Model
{

    protected $DBGroup = DB_CONNECTION;

    protected $table = 'user_management';
    protected $primaryKey = 'id';
    protected $useAutoIncrement = true;
    protected $returnType = 'array';
    protected $allowedFields = [];
    protected $validationRules = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;
    protected $useTimestamps = false;
    protected $createdField  = 'created_at';
    protected $updatedField  = 'updated_at';
    protected $deletedField  = 'deleted_at';
    protected $dbCreate;
    protected $dbRead;
    protected $dbUpdate;
    protected $dBdelete;
    protected $message;
    protected $affectedRows;

    public function getColumnsFromTable($parameter1 = 'column', $parameter2 = 'value_type', $parameter3 = 'value_key')
    {
        $ModelBaseCrud = new BaseCrudModel;
        $getTable = $ModelBaseCrud->getColumnsFromTable($this->table, $this->primaryKey, $parameter1, $parameter2, $parameter3);
        return $getTable;
    }
    public function dbCreate($dbCreate)
    {
        $ModelBaseCrud = new BaseCrudModel;
        $this->dbCreate = $ModelBaseCrud->dbCreate($this->table, $this->primaryKey, $dbCreate);
        return $this;
    }
    public function dbRead($keyVariable = NULL, $keyValue = NULL)
    {
        $ModelBaseCrud = new BaseCrudModel;
        $this->dbRead = $ModelBaseCrud->dbRead($this->table, $this->primaryKey, $keyVariable, $keyValue);
        return $this;
    }

    public function dbUpdate($key, $dbUpdate)
    {
        $ModelBaseCrud = new BaseCrudModel;
        $this->dbUpdate = $ModelBaseCrud->dbUpdate($this->table, $this->primaryKey, $key, $dbUpdate);
        return $this;
    }

    public function dBdelete($parameter, $key)
    {
        // myPrint($parameter, $key, 'src\app\Models\AdolescentesModels.php');
        $ModelBaseCrud = new BaseCrudModel;
        $this->dBdelete = $ModelBaseCrud->dBdelete($this->table, $this->primaryKey, $parameter, $key);
        return $this;
    }
}
