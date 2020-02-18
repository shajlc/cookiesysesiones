<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of consultas
 *
 * @author Shalc
 */
//Para obtener 
function getProductoPalabraClave($palabraClave) {
    $palabraClave='%'.$palabraClave.'%';
    global $mysqli;
    $productos=array();//Crea un array productos
    $stmt = $mysqli->prepare("SELECT p.nombre_producto, p.descripcion, c.nombre_categoria, p.foto ,p.id_producto, p.coste `productos` FROM productos p INNER JOIN `categorias_productos` c ON p.categorias_productos_id_categoria = c.id_categoria WHERE nombre_producto LIKE ? OR descripcion LIKE ? OR categorias_productos_id_categoria IN (SELECT id_categoria FROM categorias_productos WHERE nombre_categoria LIKE ?)");//Hacemos la consulta en el nombre del producto, descripcion y categoria
    $stmt->bind_param("sss", $palabraClave, $palabraClave,$palabraClave);//ponemos 3 string por qué son 3
    $stmt->execute();//Se ejecuta
    $stmt->store_result();//Me muestra los resultados (almacena)
    $stmt->bind_result($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);//liga los indices de la consulta
    while($stmt->fetch()){//recorrera cada uno de los resultados cogidos
        $resultado=array($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);
        $productos[]=$resultado;
    }
    //$num = $stmt->num_rows;//Me guarda en una variable el número de 
    $stmt->close();//Cierra la consulta
    return $productos;
}

function getProductoPalabraClavePorCategoria($palabraClave,$id_categoria) {
    $palabraClave='%'.$palabraClave.'%';
    global $mysqli;
    $productos=array();//Crea un array productos
    $stmt = $mysqli->prepare("SELECT p.nombre_producto, p.descripcion, c.nombre_categoria, p.foto, p.id_producto, p.coste FROM `productos` p INNER JOIN `categorias_productos` c ON p.categorias_productos_id_categoria = c.id_categoria WHERE (nombre_producto LIKE ? "
            . "OR descripcion LIKE ? )"
            . " AND categorias_productos_id_categoria  =  ?");
            
    $stmt->bind_param("ssi", $palabraClave, $palabraClave,$id_categoria);//ponemos 3 string por qué son 3
    $stmt->execute();//Se ejecuta
    $stmt->store_result();//Me muestra los resultados (almacena)
    $stmt->bind_result($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);//liga los indices de la consulta
    while($stmt->fetch()){//recorrera cada uno de los resultados cogidos
        $resultado=array($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);
        $productos[]=$resultado;
    }
    //$num = $stmt->num_rows;//Me guarda en una variable el número de 
    $stmt->close();//Cierra la consulta
    return $productos;
}

function getProductosTodos() {
    global $mysqli;
    $productos=array();//Crea un array productos
    $stmt = $mysqli->prepare("SELECT p.nombre_producto, p.descripcion, c.nombre_categoria, p.foto, p.id_producto, p.coste FROM `productos` p INNER JOIN `categorias_productos` c ON p.categorias_productos_id_categoria = c.id_categoria ");
    $stmt->execute();//Se ejecuta
    $stmt->store_result();//Me muestra los resultados (almacena)
    $stmt->bind_result($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);//liga los indices de la consulta
    while($stmt->fetch()){//recorrera cada uno de los resultados cogidos
        $resultado=array($nombre_producto, $descripcion, $nombre_categoria, $foto, $id_producto, $coste);
        $productos[]=$resultado;
    }
    //$num = $stmt->num_rows;//Me guarda en una variable el número de 
    $stmt->close();//Cierra la consulta
    return $productos;
}

function getCategorias() {
    global $mysqli;
    $categorias=array();//Crea un array productos
    $stmt = $mysqli->prepare("SELECT c.id_categoria, c.nombre_categoria, c.imagen_categoria, c.descripcion_categoria FROM `categorias_productos` c");
    $stmt->execute();//Se ejecuta
    $stmt->store_result();//Me muestra los resultados (almacena)
    $stmt->bind_result($id_categoria, $nombre_categoria, $imagen, $descripcion);//liga los indices de la consulta
    while($stmt->fetch()){//recorrera cada uno de los resultados cogidos
        $resultado=array($id_categoria, $nombre_categoria, $imagen, $descripcion);
        $categorias[]=$resultado;
    }
    //$num = $stmt->num_rows;//Me guarda en una variable el número de 
    $stmt->close();//Cierra la consulta
    return $categorias;
}

function anhadeBusqueda($categoria, $busqueda) {
    global $mysqli;
    $mysqli->query('CALL annadir_registro_historico(' . $categoria . ',"' . $busqueda . '")');
}

function getTop6Busquedas() {
    global $mysqli;
    $historicos=array();//Crea un array historicos
    $stmt = $mysqli->prepare("SELECT b.id_historico_de_busquedas, b.id_categoria, b.busqueda, b.numbusquedas, c.imagen_categoria, c.nombre_categoria FROM `historico_de_busquedas` b INNER JOIN `categorias_productos` c ON c.id_categoria = b.id_Categoria ORDER BY numbusquedas DESC LIMIT 0,6");
;
    $stmt->execute();//Se ejecuta
    $stmt->store_result();//Me muestra los resultados (almacena)
    $stmt->bind_result($id_historico, $categoria, $busqueda, $numbusquedas, $imagen, $nomcategoria);//liga los indices de la consulta
    while($stmt->fetch()){//recorrera cada uno de los resultados cogidos
        $resultado=array($id_historico, $categoria, $busqueda, $numbusquedas, $imagen, $nomcategoria);
        $historicos[]=$resultado;
    }
    //$num = $stmt->num_rows;//Me guarda en una variable el número de 
    $stmt->close();//Cierra la consulta
    return $historicos;
}

