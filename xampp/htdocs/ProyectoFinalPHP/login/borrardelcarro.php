<?php

session_start();
if (isset($_SESSION["carrito"]) && isset($_GET["idx"])) {
    $carrito = $_SESSION["carrito"];
    $idx = $_GET["idx"];
    $idx = (int) $idx;
    $buffer = array();
    for ($i = 0; $i < count($carrito); $i++) {
        if ($i != $idx) {
            $buffer[] = $carrito[$i];
        }
    }
    $_SESSION["carrito"] = $buffer;
}
header("Location: welcome.php");
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

