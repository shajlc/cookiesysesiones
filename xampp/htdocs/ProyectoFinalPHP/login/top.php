<?php
require 'funcs/conexion.php';
include 'funcs/funcs.php';
include 'consultas.php';
session_start_timeout(3600); //Iniciar una nueva sesión o reanudar la existente
$busquedas = getTop6Busquedas();
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
        <title>Productos Recientes</title>
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
                        <li class="active"><a href="top.php">Productos Recientes</a></li>
                        <li><a href="categorias.php">Categorías</a></li>
                        <?php if ($_SESSION['tipo_usuario'] == 1) { ?>
                            <li><a href='#'><?php echo $nomusuario; ?></a></li>
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


        <div class="container">
            <div class="container" style="padding : 50px 0px;">
                <?php
                $comprados = array();
                $comprados = isset($_COOKIE["comprados"]) ? json_decode($_COOKIE["comprados"]) : array();

                if (count($comprados) > 0) {
                    ?>
                    <h1 style="clear : both;">Artículos más comprados</h1>
                    <?php
                    $i = 0;
                    foreach ($comprados as $comprado) {
                        ?>
                        <div class="col-md-4 col-xs-12" style="<?php echo ($i % 3 == 0 ? 'clear : left;' : ''); ?>">
                            <div class="col-md-12 col-xs-12" style="text-align: center;">
                                <img class="col-md-12 col-xs-12" style="max-height: 150px; width : auto;" src="imagenes/productos/<?php echo $comprado[2] ?>" />
                            </div>
                            <p class="col-md-12 col-xs-12"><?php echo $comprado[1] ?></p>
                            <p class="col-md-12 col-xs-12"><?php echo $comprado[3] ?> €</p>
                        </div>

                        <?php
                        $i++;
                    }
                }
                ?>
                <h1 style="clear : both;">Búsquedas más habituales</h1>
                <?php
                if (count($busquedas) > 0) {
                    $i = 0;
                    foreach ($busquedas as $busqueda) {
                        ?>
                        <a href="welcome.php?categoria=<?php echo $busqueda[1] ?>&busqueda=<?php echo $busqueda[2] ?>">
                            <div class="col-md-4 col-xs-12" style="<?php echo ($i % 3 == 0 ? 'clear : left;' : ''); ?>">
                                <img class="col-md-12 col-xs-12" src="imagenes/categorias/<?php echo $busqueda[4] ?>" />
                                <p class="col-md-12 col-xs-12"><?php echo $busqueda[5] ?></p>
                                <p class="col-md-12 col-xs-12"><?php echo $busqueda[2] ?></p>
                            </div>
                        </a>

                        <?php
                        $i++;
                    }
                }
                ?>

            </div>



        </div>
        <footer id="footer" style="">
            <!-- top footer -->


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