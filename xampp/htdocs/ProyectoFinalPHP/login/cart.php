<?php
require 'funcs/conexion.php';
include 'funcs/funcs.php';
include 'consultas.php';
session_start_timeout(3600); //Iniciar una nueva sesión o reanudar la existente
$idCategoriaSeleccionada = 0;
$t_busqueda = "";
$productos = array();

if (isset($_POST["h_id"]) && isset($_POST["h_nombre"]) && isset($_POST["h_imagen"]) && isset($_POST["txtCantidad"]) && isset($_POST["h_coste"])) {
    $id = $_POST["h_id"];
    $nombre = $_POST["h_nombre"];
    $imagen = $_POST["h_imagen"];
    $cantidad = $_POST["txtCantidad"];
    $costeUnitario = $_POST["h_coste"];

    $carrito = array();
    if (isset($_SESSION["carrito"])) {
        $carrito = $_SESSION["carrito"];
    }
    $resultado = array($id, $nombre, $imagen, $cantidad, $costeUnitario);
    $carrito[] = $resultado;
    $_SESSION["carrito"] = $carrito;

    $comprados = array();


    $comprados = isset($_COOKIE["comprados"]) ? json_decode($_COOKIE["comprados"]) : array();

    $idxmod = -1;
    $idx = 0;
    if (count($comprados) > 0) {
        for ($idx = 0; $idx < count($comprados); $idx++) {
            if ((int) $comprados[$idx][0] == $id) {
                $idxmod = $idx;
            }
        }

        if ($idxmod == -1) {
            $comprado = array($id, $nombre, $imagen, $costeUnitario, $cantidad);
            $comprados[] = $comprado;
        } else {
            $comprados[$idxmod][4] += $cantidad;
        }
    } else {
        $comprado = array($id, $nombre, $imagen, $costeUnitario, $cantidad);
        $comprados[] = $comprado;
    }

    $json = json_encode($comprados);
    // la cookie durará 30 días
    setcookie("comprados", $json, mktime() . /* time()+60*60*24*30 */ 0, isset($params['path']), isset($params['domain']), isset($params['secure']), isset($params['httponly']));
    //unset($_COOKIE["comprados"]);
}

if (isset($_REQUEST["busqueda"]) && isset($_REQUEST["categoria"])) {
    $categoria = $_REQUEST["categoria"];
    $busqueda = $_REQUEST["busqueda"];
    $idCategoriaSeleccionada = $categoria;
    $t_busqueda = $busqueda;
    if ($categoria != 0) {
        $productos = getProductoPalabraClavePorCategoria($busqueda, $categoria);
        //var_dump($productos);
    } else {
        $productos = getProductoPalabraClave($busqueda);
    }
    anhadeBusqueda($categoria, $busqueda);
    $_SESSION["categoria"] = $categoria;
    $_SESSION["busqueda"] = $busqueda;
} else {
    if (isset($_SESSION["busqueda"]) && isset($_SESSION["categoria"])) {
        $categoria = $_SESSION["categoria"];
        $busqueda = $_SESSION["busqueda"];
        $idCategoriaSeleccionada = $categoria;

        if ($categoria != 0) {
            $productos = getProductoPalabraClavePorCategoria($busqueda, $categoria);
        } else {
            $productos = getProductoPalabraClave($busqueda);
        }
    } else {
        $productos = getProductosTodos();
    }
}

if (!isset($_SESSION["id_usuario"])) { //Si no ha iniciado sesión redirecciona a index.php
    header("Location: index.php");
}

$idUsuario = $_SESSION['id_usuario'];

$sql = "SELECT id, nombre FROM usuarios WHERE id = '$idUsuario'";
$result = $mysqli->query($sql);

$row = $result->fetch_assoc();
$nomusuario = $row["nombre"];
?>
<!--Buscar PHP-->

<html>
    <head>
        <!-- META necesario -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Welcome</title>
        <!-- Bootstrap -->
        <link rel="stylesheet" href="css2/bootstrap.min.css" >
        <link rel="stylesheet" href="css2/bootstrap-theme.min.css" >
        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

        <!-- Font Awesome Icon -->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="css/style.css"/>


        <style>
            .active-cyan-2 input[type=text]:focus:not([readonly]) {
                border-bottom: 1px solid #4dd0e1;
                box-shadow: 0 1px 0 0 #4dd0e1;
            }

            .nav .open>a, .nav .open>a:focus, .nav .open>a:hover  {
                background-color: transparent;
            }

            .fa{
                color: white;
            }

        </style>
    </head>

    <body>

        <header>
            <!-- MAIN HEADER -->
            <div id="header">
                <!-- container -->
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <!-- LOGO -->
                        <div class="col-md-3">
                            <div class="header-logo">
                                <a href="#" class="logo">
                                    <img src="" alt="">
                                </a>
                            </div>
                        </div>
                        <!-- /LOGO -->

                        <!-- SEARCH BAR -->


                        <!-- ACCOUNT -->
                        <div class="col-md-offset-6 col-md-3 clearfix">
                            <div class="header-ctn">
                                <!-- Cart -->
                                <div class="dropdown">
                                    <a class="dropdown-toggle" data-toggle="dropdown" aria-expanded="true">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>Tu carrito</span>
                                        <?php
                                        $carrito = array();
                                        if (isset($_SESSION["carrito"])) {
                                            $carrito = $_SESSION["carrito"];
                                        }
                                        ?>
                                        <div class="qty"><?php echo count($carrito) ?></div>
                                    </a>
                                    <div class="cart-dropdown">
                                        <div class="cart-list">
                                            <?php
                                            if (isset($_SESSION["carrito"])) {
                                                $carrito = $_SESSION["carrito"];
                                                $total = 0;
                                                $idx = 0;
                                                foreach ($carrito as $producto) {
                                                    ?>
                                                    <div class="product-widget">
                                                        <div class="product-img">
                                                            <img src="imagenes/productos/<?php echo $producto[2]; ?>" alt="">
                                                        </div>
                                                        <div class="product-body">
                                                            <h3 class="product-name"><a href="#"><?php echo $producto[1]; ?></a></h3>
                                                            <h4 class="product-price"><span class="qty"><?php echo $producto[3]; ?>x</span><?php echo $producto[4]; ?></h4>
                                                        </div>
                                                        <button class="delete" onclick="document.location.href = 'borrardelcarro.php?idx=<?php echo $idx ?>'"><i class="fa fa-close"></i></button>
                                                    </div>
                                                    <?php
                                                    $idx++;
                                                    $total = $total + ((int) $producto[3]) * ((float) $producto[4]);
                                                }
                                                ?>
                                                <?php
                                            }
                                            ?>
                                        </div>
                                        <div class="cart-summary">
                                            <small><?php echo count($carrito); ?> Item(s) selected</small>
                                            <h5>SUBTOTAL: <?php echo $total ?></h5>
                                        </div>
                                        <div class="cart-btns">
                                            <a href="cart.php">Ver Carrito</a>
                                            <a href="checkout.php">Realizar Pago  <i class="fa fa-arrow-circle-right"></i></a>
                                        </div>

                                    </div>
                                </div>
                                <!-- /Cart -->

                                <!-- Menu Toogle -->
                                <div class="menu-toggle">
                                    <a href="#">
                                        <i class="fa fa-bars"></i>
                                        <span>Menu</span>
                                    </a>
                                </div>
                                <!-- /Menu Toogle -->
                            </div>
                        </div>
                        <!-- /ACCOUNT -->
                    </div>
                    <!-- row -->
                </div>
                <!-- container -->
            </div>
            <!-- /MAIN HEADER -->
        </header>
        <!-- /HEADER -->
        <!-- NAVIGATION -->
        <nav id="navigation">
            <!-- container -->
            <div class="container">
                <!-- responsive-nav -->
                <div id="responsive-nav">
                    <!-- NAV -->
                    <ul class="main-nav nav navbar-nav">
                        <li><a href="welcome.php">Inicio</a></li>
                        <li><a href="top.php">Productos recientes</a></li>
                        <li><a href="categorias.php">Categorías</a></li>
                        <?php if (isset($_SESSION['tipo_usuario'])) { ?>
                            <li><a href='#' style="color: red; font-weight: 900; text-decoration: none;"><?php echo $nomusuario; ?></a></li>
                        <?php } ?>
                    </ul>
                    <ul class='nav navbar-nav navbar-right'>
                        <li><a href='logout.php'>Cerrar Sesi&oacute;n</a></li>
                    </ul>
                    <!-- /NAV -->
                </div>
                <!-- /responsive-nav -->
            </div>
            <!-- /container -->
        </nav>
        <!-- /NAVIGATION -->


        <div class="container" style="padding : 30px 0px;">
            <?php
            if (isset($_SESSION["carrito"])) {
                $carrito = $_SESSION["carrito"];
                $total = 0;
                $idx = 0;
                foreach ($carrito as $producto) {
                    ?>
                    <div class="col-xs-12" style="clear : both;margin-top : 20px;border-bottom : solid 5px #D10024;padding : 10px;border-radius : 5px;">
                        <div class="col-xs-10 col-xs-offset-1 col-md-4" style="text-align : center;margin-left : 0px;"><img style="max-height : 100px; width : auto;" src="imagenes/productos/<?php echo $producto[2]; ?>" alt="" /></div>
                        <div class="col-xs-10 col-xs-offset-1 col-md-4" style="text-align : left; font-size : 20px; margin-left : 0px; padding : 40px 0px; line-height: 20px;"><?php echo $producto[3]; ?>x <?php echo $producto[1]; ?></div>
                        <div class="col-xs-10 col-xs-offset-1 col-md-4" style="text-align : left; font-size : 20px; margin-left : 0px; font-weight: 800;padding : 40px 0px; line-height: 20px; text-align: right;"><?php echo ((int) $producto[3]) * ((float) $producto[4]) ?> €</div>
                    </div>
                    <?php
                    $idx++;
                    $total = $total + ((int) $producto[3]) * ((float) $producto[4]);
                }
            }
            ?>
            <div class="col-xs-12" style="clear : both;margin-top : 20px;border-bottom : solid 5px #D10024;padding : 10px;border-radius : 5px;">
                <div class="col-xs-12 col-md-4" style="text-align : center;"></div>
                <div class="col-xs-12 col-md-4" style="text-align : left; font-size : 20px; padding : 15px 0px; line-height: 20px;">TOTAL</div>
                <div class="col-xs-12 col-md-4" style="text-align : left; font-size : 20px; font-weight: 800;padding : 15px 0px; line-height: 20px;text-align: right;"><?php echo $total ?> €</div>

            </div>
            <div class="col-md-1 col-md-offset-11 col-xs-4 col-xs-offset-4">
                <a href="checkout.php" class="btn btn-primary" style="margin-top : 30px;" >Comprar</a>
            </div>

        </div>



        <footer id="footer">


            <!-- bottom footer -->
            <div id="bottom-footer" class="section">
                <div class="container">
                    <!-- row -->
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <ul class="footer-payments">
                                <li><a href="#"><i class="fa fa-cc-visa"></i></a></li>
                                <li><a href="#"><i class="fa fa-credit-card"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-paypal"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-mastercard"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-discover"></i></a></li>
                                <li><a href="#"><i class="fa fa-cc-amex"></i></a></li>
                            </ul>
                            <span class="copyright">
                                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                                Copyright ©<script>document.write(new Date().getFullYear());</script>Supermercado Aldi <i class="fa fa-heart-o" aria-hidden="true"></i> 
                            </span>
                        </div>
                    </div>
                    <!-- /row -->
                </div>
                <!-- /container -->
            </div>
            <!-- /bottom footer -->
        </footer>


        <!-- jQuery Plugins -->
        <script src="js/jquery-3.4.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>		