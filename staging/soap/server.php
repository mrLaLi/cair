<?php

ini_set("soap.wsdl_cache_enabled", 0);
ini_set("soap.wsdl_cache_ttl", 1);

function login($login, $password)
{
  return "some string";
}

function doFilter($params)
{
  return "some string";
}

$server = new SoapServer("scheme.wsdl");
$server->addFunction("login");
$server->addFunction("doFilter");
$server->handle();

?>
