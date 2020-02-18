<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <!--BUSCADOR DE PRODUCTOS-->
        <?php
        session_start();
        require 'funcs/conexion.php';
        include 'funcs/funcs.php';
        include 'consultas.php';
        $productos = getProductoPalabraClave($_POST['busqueda']); //se recupera los producto
        foreach ($productos as $producto) {
            echo '<div><img src="https://libbys.es/wordpress/wp-content/uploads/2018/10/estadosfruta.jpg"><h4>' . $producto[0] . '</h4><span>' . $producto[1] . '</span><h4>' . $producto[2] . '</h4></div>';
        }
        ?> 



    </body>
</html>
