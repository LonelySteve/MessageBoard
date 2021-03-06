<?php

namespace App\SqlBuilder;

class SqlBuilderFactory
{
    static function from_type($name)
    {
        switch ($name) {
            case "mysql":
                return MySqlBuilder::class;
            case "pgsql":
                return PostgreSqlBuilder::class;
            default:
                throw new \InvalidArgumentException("Unsupported database type (${$name})!");
        }
    }
}
