
╔════════════════════════════════════════════════════════════════╗
║              📤 EXPORTAR DATOS PARA POSTGRESQL                 ║
╚════════════════════════════════════════════════════════════════╝


   Illuminate\Database\QueryException 

  SQLSTATE[08006] [7] connection to server at "127.0.0.1", port 5432 failed: Connection refused (0x0000274D/10061)
	Is the server running on that host and accepting TCP/IP connections? (Connection: pgsql, SQL: select * from "users")

  at vendor\laravel\framework\src\Illuminate\Database\Connection.php:824
    820▕                     $this->getName(), $query, $this->prepareBindings($bindings), $e
    821▕                 );
    822▕             }
    823▕ 
  ➜ 824▕             throw new QueryException(
    825▕                 $this->getName(), $query, $this->prepareBindings($bindings), $e
    826▕             );
    827▕         }
    828▕     }

  1   vendor\laravel\framework\src\Illuminate\Database\Connectors\Connector.php:66
      PDOException::("SQLSTATE[08006] [7] connection to server at "127.0.0.1", port 5432 failed: Connection refused (0x0000274D/10061)
	Is the server running on that host and accepting TCP/IP connections?")

  2   vendor\laravel\framework\src\Illuminate\Database\Connectors\Connector.php:66
      PDO::__construct("pgsql:host=127.0.0.1;dbname='task_management';port=5432;client_encoding='utf8';sslmode=prefer", "postgres", Object(SensitiveParameterValue), [])

