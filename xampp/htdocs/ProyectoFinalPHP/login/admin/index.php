<?php
session_start();
require 'funcs/conexion.php';
include 'funcs/funcs.php';
include 'consultas.php';
$idCategoriaSeleccionada = 0;
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
    $resultado = array($id,$nombre,$imagen,$cantidad,$costeUnitario);
    $carrito[] = $resultado;
    $_SESSION["carrito"] = $carrito;
    
    
}

if (isset($_REQUEST["busqueda"]) && isset($_REQUEST["categoria"])) {
    $categoria = $_REQUEST["categoria"];
    $busqueda = $_REQUEST["busqueda"];
    $idCategoriaSeleccionada = $categoria;
    if ($categoria != 0) {
        $productos = getProductoPalabraClavePorCategoria($busqueda, $categoria);
        //var_dump($productos);
    }
    else {
        $productos = getProductoPalabraClave($busqueda);
    }
    $_SESSION["categoria"] = $categoria;
    $_SESSION["busqueda"] = $busqueda;
    
}
else {
    if (isset($_SESSION["busqueda"]) && isset($_SESSION["categoria"])) {
        $categoria = $_SESSION["categoria"];
        $busqueda = $_SESSION["busqueda"];
        $idCategoriaSeleccionada = $categoria;

        if ($categoria != 0) {
            $productos = getProductoPalabraClavePorCategoria($busqueda, $categoria);
        }
        else {
            $productos = getProductoPalabraClave($busqueda);
        }
    }
    else {
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
            body {
                padding-top: 20px;
                padding-bottom: 20px;
            }

            .active-cyan-2 input[type=text]:focus:not([readonly]) {
                border-bottom: 1px solid #4dd0e1;
                box-shadow: 0 1px 0 0 #4dd0e1;
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
									<img src="./img/logo.png" alt="">
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
										<span>Your Cart</span>
                                                                                <?php 
                                                                                    $carrito = array();
                                                                                    if (isset($_SESSION["carrito"])) {
                                                                                        $carrito = $_SESSION["carrito"];
                                                                                    }
                                                                                ?>
										<div class="qty"><?php echo count($carrito)?></div>
									</a>
									<div class="cart-dropdown">
										<div class="cart-list">
                                                                                    <?php if (isset($_SESSION["carrito"])) {
                                                                                        $carrito = $_SESSION["carrito"];
                                                                                        $total = 0;
                                                                                        $idx = 0;
                                                                                        foreach($carrito as $producto) {
                                                                                    ?>
											<div class="product-widget">
												<div class="product-img">
													<img src="imagenes/productos/<?php echo $producto[2]; ?>" alt="">
												</div>
												<div class="product-body">
													<h3 class="product-name"><a href="#"><?php echo $producto[1]; ?></a></h3>
													<h4 class="product-price"><span class="qty"><?php echo $producto[3]; ?>x</span><?php echo $producto[4]; ?></h4>
												</div>
												<button class="delete" onclick="document.location.href='borrardelcarro.php?idx=<?php echo $idx?>'"><i class="fa fa-close"></i></button>
											</div>
                                                                                    <?php
                                                                                            $idx++;
                                                                                            $total = $total + ((int)$producto[3]) * ((float)$producto[4]);
                                                                                        } 
                                                                                    ?>
                                                                                <?php
                                                                                    }
                                                                                ?>
										</div>
										<div class="cart-summary">
											<small><?php echo count($carrito);?> Item(s) selected</small>
											<h5>SUBTOTAL: <?php echo $total ?></h5>
										</div>
										<div class="cart-btns">
											<a href="#">View Cart</a>
											<a href="#">Checkout  <i class="fa fa-arrow-circle-right"></i></a>
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
						<li class="active"><a href="welcome.php">Home</a></li>
						<li><a href="#">Hot Deals</a></li>
						<li><a href="categorias.php">Categories</a></li>
						<?php if ($_SESSION['tipo_usuario'] == 1) { ?>
                                                    <li class="dropdown">
                                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                          Admin
                                                        </a>
                                                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                                          <a class="dropdown-item" href="admin/productos/">Productos</a>
                                                          <a class="dropdown-item" href="admin/categorias/">Categorias</a>
                                                          <a class="dropdown-item" href="admin/usuarios/">Usuarios</a>
                                                          <div class="dropdown-divider"></div>
                                                          <a class="dropdown-item" href="#">Something else here</a>
                                                        </div>
                                                      </li>
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

            <!--<nav class='navbar navbar-default'>
                <div class='container-fluid'>
                    <div class='navbar-header'>
                        <button type='button' class='navbar-toggle collapsed' data-toggle='collapse' data-target='#navbar' aria-expanded='false' aria-controls='navbar'>
                            <span class='sr-only'>Men&uacute;</span>
                            <span class='icon-bar'></span>
                            <span class='icon-bar'></span>
                            <span class='icon-bar'></span>
                        </button>
                    </div>

                    <div id='navbar' class='navbar-collapse collapse'>
                        <ul class='nav navbar-nav'>
                            <li class='active'><a href='welcome.php'>Inicio</a></li>			
                        </ul>

                        
                        

                        -

                        
                    </div>
                </div>
            </nav>-->
            <div class="container">
                    <div class="col-md-offset-0 col-md-12 col-xs-12 col-xs-offset-0" style="padding : 30px;">
                                <form method="POST" class="col-md-8 col-md-offset-2 col-xs-12">
                                    <div class="col-xs-12 col-md-5">
                                        <select class="form-control" name="categoria">
                                            <option value="0" <?php echo $idCategoriaSeleccionada == 0 ? 'selected' : '';?>>All Categories</option>
                                            <?php
                                                $categorias = getCategorias();
                                                foreach($categorias as $categoria) {
                                                    ?>
                                                    <option value="<?php echo $categoria[0]; ?>" <?php echo $idCategoriaSeleccionada == $categoria[0] ? 'selected' : '';?>><?php echo $categoria[1];?></option>
                                                    <?php
                                                }

                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-12 col-md-5">
                                        <input class="form-control" name="busqueda" placeholder="Search here">
                                    </div>
                                    <div class="col-xs-12 col-md-2">
                                        <button type="submit" class="btn btn-primary form-control">Search</button>
                                    </div>
                                </form>
                        
                    </div>
                
            </div>
            <div class="container">
                    <?php
                        if(count($productos) > 0) {
                            $i = 0;
                            foreach ($productos as $producto) {
                                ?>
                <div class="col-md-4 col-xs-12" style="<?php echo ($i % 3 == 0 ? 'clear : left;' : ''); ?>">
                        <img class="col-md-12 col-xs-12" src="imagenes/productos/<?php echo $producto[3]?>" />
                        <p class="col-md-12 col-xs-12"><?php echo $producto[0]?></p>
                        <p class="col-md-12 col-xs-12" style="font-weight : 900;"><?php echo $producto[2]?></p>
                        <p class="col-md-12 col-xs-12"><?php echo $producto[1]?></p>
                        <p class="col-md-4 col-xs-4" style="font-weight : 700; font-size : 1.2em;"><?php echo $producto[5]?> €</p>
                        <form method="POST">
                        <input type="hidden" name="h_id" value="<?php echo $producto[4]?>" />
                        <input type="hidden" name="h_nombre" value="<?php echo $producto[0]?>" />
                        <input type="hidden" name="h_imagen" value="<?php echo $producto[3]?>" />
                        <input type="hidden" name="h_coste" value="<?php echo $producto[5]?>" />
                        <div class="form-group col-xs-offset-1 col-xs-5 text-center float-left clearfix" style="clear : both;">
                            <label for="txtCantidad">Cantidad</label>
                            <input name="txtCantidad" type="number" class="form-control input-sm" />
                        </div>
                        <div class="form-group col-xs-5">
                            <br />
                            <input type="submit" class="btn btn-default form-control" value="Comprar"/></label>
                        </div>
                        </form>
                        
               </div>
             
                            <?php
                            $i++;
                           }
                        }
                    ?>
                
            </div>
            
            
        </div>
        <!-- jQuery Plugins -->
        <script src="js/jquery-3.4.0.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/slick.min.js"></script>
        <script src="js/nouislider.min.js"></script>
        <script src="js/jquery.zoom.min.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>		