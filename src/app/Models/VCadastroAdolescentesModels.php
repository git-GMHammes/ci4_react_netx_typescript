<?php

namespace App\Models;

use CodeIgniter\Database\Query;
use CodeIgniter\Model;
use App\Controllers\SystemMessageController;

class VCadastroAdolescentesModels extends Model
{

    protected $DBGroup = DB_CONNECTION;

    protected $table = 'v_cadastro_adolescentes';
    protected $primaryKey = 'CadastroID';
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
    protected $dbRead;
    public function getColumnsFromTable($parameter1 = 'column', $parameter2 = 'value_type', $parameter3 = 'value_key')
    {
        $ModelBaseCrud = new BaseCrudModel;
        $getTable = $ModelBaseCrud->getColumnsFromTable($this->table, $this->primaryKey, $parameter1, $parameter2, $parameter3);
        return $getTable;
    }

    public function dbRead($keyVariable = NULL, $keyValue = NULL)
    {
        $ModelBaseCrud = new BaseCrudModel;
        // exit('src\app\Models\VCadastroAdolescentesModels.php');
        $this->dbRead = $ModelBaseCrud->dbRead($this->table, $this->primaryKey, $keyVariable, $keyValue);
        return $this;
    }
}
