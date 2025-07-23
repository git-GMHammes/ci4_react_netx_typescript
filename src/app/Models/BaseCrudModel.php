<?php

namespace App\Models;

use CodeIgniter\Database\Query;
use CodeIgniter\Model;
use App\Controllers\Pattern\MessageController;

class BaseCrudModel extends Model
{

    protected $DBGroup = DB_CONNECTION;

    protected $table = '';
    protected $primaryKey = '';
    protected $useAutoIncrement = true;
    protected $returnType = 'array';
    protected $allowedFields = [];
    protected $validationRules = [];
    protected $validationMessages = [];
    protected $skipValidation = false;

    protected $useTimestamps = false;
    protected $createdField = 'created_at';
    protected $updatedField = 'updated_at';
    protected $deletedField = 'deleted_at';

    protected $dbInsert;
    protected $dbRead;
    protected $message;
    protected $affectedRows;
    protected $erro_db;

    // App\Models\BaseCrudModel;
    // $ModelBaseCrud = new BaseCrudModel;
    // $ModelBaseCrud->getColumnsFromTable($dbTable, $primaryKey, $parameter1 = 'column', $parameter2 = 'value_type', $parameter3 = 'value_key');
    // $dbTable, $primaryKey;
    public function getColumnsFromTable($dbTable, $primaryKey, $parameter1 = 'column', $parameter2 = 'value_type', $parameter3 = 'value_key')
    {
        $getTable = array();
        // myPrint($dbTable, '', true);
        // myPrint($primaryKey, '');
        $this->primaryKey = (string) $primaryKey;
        $this->table = $dbTable;
        # input: getColumnsFromTable('tab_link', 'column', 'type', 'key')
        if ($parameter1 == 'column' && $parameter2 == 'value_type' && $parameter3 == 'value_key') {
            // exit('if 1');
            $query = $this->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$this->table';");
            foreach ($query->getResultArray() as $key => $value_columns) {
                $getTable['COLUMN'][] = $value_columns['COLUMN_NAME'];
                // myPrint($getTable['COLUMN'], '', true);
            }
        } elseif ($parameter1 == 'column' && $parameter2 == 'type' && $parameter3 == 'value_key') {
            // exit('else if 2');
            $query = $this->query("SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$this->table';");
            foreach ($query->getResultArray() as $key => $value_columns) {
                $getTable['COLUMN'][] = $value_columns['COLUMN_NAME'] . ', ' . $value_columns['DATA_TYPE'];
            }
        } elseif ($parameter1 == 'column' && $parameter2 == 'type' && $parameter3 == 'key') {
            // exit('else if 3');
            $query = $this->query("SELECT COLUMN_NAME, DATA_TYPE, COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$this->table';");
            foreach ($query->getResultArray() as $key => $value_columns) {
                $getTable['COLUMN'][] = $value_columns['COLUMN_NAME'] . ', ' . $value_columns['DATA_TYPE'] . ', ' . $value_columns['COLUMN_KEY'];
            }
        }
        // myPrint($query, 'src\app\Models\BaseCrudModel.php');
        return $getTable;
    }

    public function dbCreate($dbTable, $primaryKey, $dbCreate)
    {
        $this->message = new MessageController();
        $this->table = $dbTable;
        $this->primaryKey = $primaryKey;
        $this->allowedFields = array_keys($dbCreate);
        try {
            $this->dbInsert = $this->insert($dbCreate);
            // myPrint($this, 'src\app\Models\AdolescentesModels.php');
            $this->affectedRows = $this->db->affectedRows();
            if ($this->affectedRows > 0) {
                $this->message->message([''], 'success', $dbCreate, 5);
            }
        } catch (\Throwable $th) {
            if (DEBUG_MY_PRINT) {
                myPrint($th->getMessage(), 'src/app/Models/.php');
            }
            $this->erro_db['aviso'] = $th->getMessage();
            $message = $th->getMessage();
            $this->message->message([$message], 'danger', $dataValue = array(), 5);
        }
        return $this;
    }

    public function dbRead($dbTable, $primaryKey, $keyVariable = NULL, $keyValue = NULL)
    {
        // myPrint('$dbTable :: ', $dbTable, true);
        // myPrint('$primaryKey :: ', $primaryKey, true);
        // myPrint('$keyVariable :: ', $keyVariable, true);
        // myPrint('$keyVariable :  ', $keyVariable, true);
        // myPrint('$keyValue :: ', $keyValue, true);
        $this->message = new MessageController();
        // $getColumnsFromTable = array();
        $this->table = $dbTable;
        $this->primaryKey = $primaryKey;
        $getColumnsFromTable = $this->getColumnsFromTable($this->table, $this->primaryKey)['COLUMN'];
        // myPrint('$getColumnsFromTable :: ', $getColumnsFromTable, true);
        $this->allowedFields = $getColumnsFromTable;
        #
        try {
            if ($keyVariable !== NULL && $keyValue !== NULL) {
                $this->dbRead = $this->where($keyVariable, $keyValue);
            } elseif ($keyVariable !== NULL && $keyValue == NULL) {
                $this->dbRead = $this->select($this->allowedFields);
            } else {
                $this->dbRead = $this->select($this->allowedFields);
            }
            $this->affectedRows = $this->db->affectedRows();
        } catch (\Throwable $th) {
            if (DEBUG_MY_PRINT) {
                myPrint($th->getMessage(), 'src/app/Models/.php');
            }
            $message = $th->getMessage();
            $this->message->message([$message], 'danger', $getColumnsFromTable = array(), 5);
        }
        // myPrint('$this->dbRead->findAll() :: ', $this->dbRead->findAll());
        return $this;
    }

    public function dbUpdate($dbTable, $primaryKey, $key, $dbUpdate)
    {
        // myPrint($key, $dbUpdate);
        $this->table = $dbTable;
        $this->primaryKey = $primaryKey;
        $this->message = new MessageController();
        try {
            if (
                isset($dbUpdate)
            ) {
                $this->allowedFields = array_keys($dbUpdate);
                // myPrint($this->allowedFields, true);
            }
            if (
                isset($key)
                && is_array($key)
                && isset($dbUpdate)
            ) {
                // Configura a atualização
                $this->set($dbUpdate);
                $this->where($key);
                $this->update();
            } else {
                $this->update($key, $dbUpdate);
            }
            $this->affectedRows = $this->db->affectedRows();
            if ($this->affectedRows > 0) {
                $this->message->message([''], 'success', $dbUpdate = array(), 5);
            } else {
                $this->message->message([''], 'danger', $dbUpdate = array(), 5);
            }
        } catch (\Throwable $th) {
            if (DEBUG_MY_PRINT) {
                myPrint($th->getMessage(), 'src/app/Models/.php');
            }
            $message = $th->getMessage();
            $this->message->message([$message], 'danger', $dbUpdate = array(), 5);
        }
        return $this;
    }

    public function dBdelete($dbTable, $primaryKey, $parameter, $key = NULL)
    {
        $this->message = new MessageController();
        $this->table = $dbTable;
        $this->primaryKey = $primaryKey;
        try {
            if ($key === NULL) {
                if (is_array($parameter)) {
                    // Se $parameter for um array, aplicamos cada par chave-valor como condição WHERE
                    foreach ($parameter as $param => $value) {
                        $this->where($param, $value);
                    }
                } else {
                    // Comportamento original mantido: exclusão onde deleted_at não é nulo
                    $this->where('deleted_at !=', NULL);
                }
                $this->delete();
            } else {
                // Comportamento original mantido para quando $key não é nulo
                $this->where($parameter, $key);
                $this->delete();
            }
        } catch (\Throwable $th) {
            if (DEBUG_MY_PRINT) {
                myPrint($th->getMessage(), 'src/app/Models/.php');
            }
            $message = $th->getMessage();
            $this->message->message([$message], 'danger', array(), 5);
        }
        return $this;
    }
}
