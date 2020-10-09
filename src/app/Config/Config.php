<?php

namespace App\Config;

class Config
{
    public $debug_mode;
    public $db_config;
    public $smarty;

    static $instance = null;

    private function __construct()
    {
    }

    private function __clone()
    {
    }

    static function load()
    {
        // 如果配置缓存无效则读取配置并缓存配置
        if (!self::$instance) {

            self::$instance = new Config();

            self::$instance->debug_mode = $is_debug_mode = getenv("DEBUG_MODE") ?? false;

            $props = array("db_name" => "message_board", "db_addr" => "127.0.0.1", "db_user" => "admin", "db_pass" => "example", "db_type" => "mysql");


            foreach ($props as $name => $_) {
                $prefix = $is_debug_mode ? "DEV_" : "";
                $value = getenv($prefix . (strtoupper($name)));
                if ($value) {
                    $props[$name] = $value;
                }
            }

            self::$instance->debug_mode = $is_debug_mode;
            self::$instance->db_config = new DBConfig($props["db_addr"], $props["db_name"], $props["db_user"], $props["db_pass"], $props["db_type"]);
            self::$instance->smarty = new \Smarty();
            # 重新设置smarty的目录设置
            self::$instance->smarty->setTemplateDir(__DIR__ . "/../../templates");
            self::$instance->smarty->setCompileDir(__DIR__ . "/../../templates_c/");
            self::$instance->smarty->setConfigDir(__DIR__ . "/../../configs/");
            self::$instance->smarty->setCacheDir(__DIR__ . "/../../cache/");
        }

        return self::$instance;
    }
}
