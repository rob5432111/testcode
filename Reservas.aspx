<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reservas.aspx.cs" Inherits="SistemaRegistro.Reservas" %>

<!DOCTYPE html>

<html lang="es" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title></title>
     <!-- Bootstrap Core CSS -->
    <link href="reservas/css/bootstrap.min.css" rel="stylesheet"/>

    <!-- Bootstrap DateTimePicker -->
    <link href="reservas/css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="reservas/css/landing-page.css" rel="stylesheet"/>

    <!-- Custom Fonts -->
    <link href="assets/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>

    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css"/>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
    <form id="form1" runat="server">
        
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top topnav" role="navigation">
        <div class="container topnav">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand topnav" href="#">Playa Cristal</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#inicio">Inicio</a>
                    </li>
                    <li>
                        <a href="#habitaciones">Habitaciones</a>
                    </li>
                    <li>
                        <a href="#reservas">Reservas</a>
                    </li>
                    <li>
                        <a href="#contacto">Contacto</a>
                    </li>
                    <li>
                        <a href="Inicio.aspx">Iniciar Sesión</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>


    <!-- Header -->
    <a id="inicio"></a>
    <div class="intro-header">
        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Playa Cristal</h1>
                        <h3>El descanso inolvidable</h3>
                        <hr class="intro-divider"/>
                        <ul class="list-inline intro-social-buttons">
                            <li>
                                <a href="#reservas" class="btn btn-default btn-lg"><i class="fa fa-bed fa-fw"></i><span class="network-name">Reservar</span></a>
                            </li>
                            
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.intro-header -->

    <!-- Page Content -->

	<a id="habitaciones"></a>
    <div class="content-section-a">

        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer"/>
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Habitaciones Familiares</h2>
                    <p class="lead">12 cabañas familiares con sala al aire libre debidamente equipado con capacidad de 4 a 5 personas por cabaña.</p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="reservas/images/hab3.png" alt="" />
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-a -->

    <div class="content-section-b">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                    <hr class="section-heading-spacer"/>
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Habitaciones Matrimoniales</h2>
                    <p class="lead">4 suites matrimoniales, cómodamente equipadas con Aire Acondicionado, Directv y Frigo Bar.</p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <img class="img-responsive" src="reservas/images/hab1.jpg" alt=""/>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-b -->

    <div class="content-section-a">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer"/>
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Comodidad inigualable</h2>
                    <p class="lead">Disfrute de un descanso en una de las más hermosas playas de Ecuador, con la comodidad de su hogar.</p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="reservas/images/hab2.png" alt="" />
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-a -->


    <a id="reservas"></a>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container">
                    <div class="row uniform">
                        <div class="col-lg-5 col-sm-6">
                            <hr class="section-heading-spacer" />
                            <div class="clearfix"></div>
                            <h2 class="section-heading">Reservas</h2>
                        </div>
                    </div>
                    <div class="row uniform">
                        <div class="col-lg-3 col-lg-offset-2 col-sm-5 col-xs-11">
                            <label for="inp_nombre">Ingrese su nombre:</label>
                            <input id="inp_nombre" runat="server" type="text" placeholder="Nombre" maxlength="100" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="inp_nombre"
                                ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-lg-3 col-sm-5 col-xs-11">
                            <label for="inp_email">Ingrese su e-mail:</label>
                            <input id="inp_email" runat="server" type="text" placeholder="E-mail" maxlength="100" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="inp_email"
                                ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="remail" runat="server" ForeColor="Red"
                                CssClass="validator" Display="Dynamic"
                                ControlToValidate="inp_email" ErrorMessage="Ingrese un email valido"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"> 
                            </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-lg-2 col-sm-4 col-xs-11">
                            <label for="inp_telf_1">Ingrese un teléfono:</label>
                            <input id="inp_telf_1" runat="server" type="text" placeholder="Teléfono 1" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" ControlToValidate="inp_telf_1"
                                ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>

                        </div>
                        <div class="col-lg-2 col-sm-4 col-xs-11">
                            <label for="inp_telf_2">Teléfono opcional</label>
                            <input id="inp_telf_2" runat="server" type="text" placeholder="Teléfono 2" />
                        </div>
                    </div>
                    <div class="clearfix"></div>

                    <div class="row">
                        <div class="col-lg-3 col-lg-offset-1">
                            <h3>Fechas de Reserva:</h3>
                        </div>
                    </div>

                    <div class="container">
                        <div class="form-group">
                            <label for="inp_f_desde" class="col-lg-1 col-lg-offset-2 col-sm-2 control-label">
                                Desde: &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" Display="Dynamic" ControlToValidate="inp_f_v1"
                                    ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </label>
                            <div class="input-group date form_date col-lg-4 col-sm-6" data-date="" data-date-format="dd MM yyyy" data-link-field="inp_f_desde" data-link-format="yyyy-mm-dd">
                                <input class="form-control" type="text" id="inp_f_v1" runat="server" value="" readonly="true" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                            </div>

                            <input type="hidden" id="inp_f_desde" value="" runat="server" /><br />
                            <label for="inp_f_hasta" class="col-lg-1 col-lg-offset-2 col-sm-2 control-label">
                                Hasta: &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Display="Dynamic" ControlToValidate="inp_f_v2"
                                    ForeColor="Red" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </label>
                            <div class="input-group date form_date col-lg-4 col-sm-6" data-date="" data-date-format="dd MM yyyy" data-link-field="inp_f_hasta" data-link-format="yyyy-mm-dd">
                                <input class="form-control" id="inp_f_v2" runat="server" type="text" value="" readonly="true" />
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span class="fa fa-calendar"></span></span>

                            </div>
                            <input type="hidden" id="inp_f_hasta" value="" runat="server" /><br />
                            <asp:CustomValidator runat="server" ID="cusCustom" CssClass="validator" Display="Dynamic"
                                OnServerValidate="custDate_ServerValidate"
                                ForeColor="Red" ErrorMessage="Fechas incorrectas" />
                        </div>
                    </div>

                    <div class="container">
                        <div class="row uniform">
                            <label for="ddl_cant_h" class="col-lg-2 col-lg-offset-2 col-sm-2 control-label">Cantidad habitaciones:</label>
                            <div class="col-lg-2 col-sm-4 col-xs-8">
                                <asp:DropDownList ID="ddl_cant_h" runat="server" AutoPostBack="true" CssClass="ddl"
                                    OnSelectedIndexChanged="ddl_cant_h_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5 o más</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-10 col-lg-offset-1 col-sm-10 col-sm-offset-1 col-xs-11">
                                <h4>Nota: Se considera menor a las personas que tengan 12 años o menos, ya que el costo de la habitación es diferente.</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row uniform">
                        <div class="col-lg-10 col-lg-offset-1 col-sm-10 col-sm-offset-1">
                            <asp:Label ForeColor="Red" ID="lbl_5h" runat="server" Text="Si desea reservar 5 o más habitaciones una persona encargada del hotel se 
                        pondrá en contacto con usted lo más pronto posible, por favor deje sus datos y si desea un comentario."
                                Visible="false"></asp:Label>
                        </div>
                    </div>



                    <asp:Panel ID="pnl_h_1" runat="server" Visible="true" CssClass="panel col-lg-5">

                        <div class="col-lg-12">
                            <div class="row uniform">
                                <div class="col-sm-offset-1 col-xs-offset-1 ">
                                    <p>Habitación 1</p>
                                    <asp:CustomValidator runat="server" ID="CustomValidator2" CssClass="validator" Display="Dynamic"
                                        OnServerValidate="custCant1_ServerValidate"
                                        ForeColor="Red" ErrorMessage="Seleccione mínimo 1 persona" />
                                </div>
                            </div>
                            <div class="row uniform">
                                <label for="ddl_a_1" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Adultos:</label>
                                <div class="col-lg-2 col-sm-3 col-xs-7">
                                    <asp:DropDownList ID="ddl_a_1" runat="server" AutoPostBack="true" CssClass="ddl" OnSelectedIndexChanged="ddl_a_1_SelectedIndexChanged">
                                        <asp:ListItem Selected="True">0</asp:ListItem>
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <label for="ddl_m_1" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Menores:</label>
                                <div class="col-lg-2 col-sm-3 col-xs-7">
                                    <asp:DropDownList ID="ddl_m_1" runat="server" AutoPostBack="true" CssClass="ddl">
                                        <asp:ListItem Selected="True">0</asp:ListItem>
                                        <asp:ListItem>1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-lg-5 col-sm-2 col-xs-12">
                                    <asp:RadioButtonList ID="rbtn_tipo_h_1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbtn_tipo_h_1_SelectedIndexChanged">
                                        <asp:ListItem Selected="true">Familiar</asp:ListItem>
                                        <asp:ListItem>Matrimonial</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>


                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnl_h_2" runat="server" Visible="false" CssClass="panel col-lg-5">
                        <div class="row uniform">
                            <div class="col-sm-offset-3 col-xs-offset-1 ">
                                <p>Habitación 2</p>
                                <asp:CustomValidator runat="server" ID="CustomValidator3" CssClass="validator" Display="Dynamic"
                                    OnServerValidate="custCant2_ServerValidate"
                                    ForeColor="Red" ErrorMessage="Seleccione mínimo 1 persona" />

                            </div>
                        </div>
                        <div class="row uniform">
                            <label for="ddl_a_2" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Adultos:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_a_2" runat="server" AutoPostBack="true" CssClass="ddl" OnSelectedIndexChanged="ddl_a_2_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <label for="ddl_m_2" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Menores:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_m_2" runat="server" AutoPostBack="true" CssClass="ddl">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-5 col-sm-2 col-xs-12">
                                <asp:RadioButtonList ID="rbtn_tipo_h_2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbtn_tipo_h_2_SelectedIndexChanged">
                                    <asp:ListItem Selected="true">Familiar</asp:ListItem>
                                    <asp:ListItem>Matrimonial</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>


                        </div>

                    </asp:Panel>
                    <asp:Panel ID="pnl_h_3" runat="server" Visible="false" CssClass="panel col-lg-5">
                        <div class="row uniform">
                            <div class="col-sm-offset-3 col-xs-offset-1 ">
                                <p>Habitación 3</p>
                                <asp:CustomValidator runat="server" ID="CustomValidator1" CssClass="validator" Display="Dynamic"
                                    OnServerValidate="custCant3_ServerValidate"
                                    ForeColor="Red" ErrorMessage="Seleccione mínimo 1 persona" />
                            </div>
                        </div>
                        <div class="row uniform">
                            <label for="ddl_a_3" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Adultos:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_a_3" runat="server" AutoPostBack="true" CssClass="ddl" OnSelectedIndexChanged="ddl_a_3_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <label for="ddl_m_3" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Menores:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_m_3" runat="server" AutoPostBack="true" CssClass="ddl">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-5 col-sm-2 col-xs-12">
                                <asp:RadioButtonList ID="rbtn_tipo_h_3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbtn_tipo_h_3_SelectedIndexChanged">
                                    <asp:ListItem Selected="true">Familiar</asp:ListItem>
                                    <asp:ListItem>Matrimonial</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>


                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnl_h_4" runat="server" Visible="false" CssClass="panel col-lg-5">
                        <div class="row uniform">
                            <div class="col-sm-offset-4 col-xs-offset-1 ">
                                <p>Habitación 4</p>
                                <asp:CustomValidator runat="server" ID="CustomValidator4" CssClass="validator" Display="Dynamic"
                                    OnServerValidate="custCant4_ServerValidate"
                                    ForeColor="Red" ErrorMessage="Seleccione mínimo 1 persona" />
                            </div>
                        </div>
                        <div class="row uniform">
                            <label for="ddl_a_4" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Adultos:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_a_4" runat="server" AutoPostBack="true" CssClass="ddl" OnSelectedIndexChanged="ddl_a_4_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <label for="ddl_m_4" class="col-lg-2 col-sm-2 col-xs-2 control-label label"># Menores:</label>
                            <div class="col-lg-2 col-sm-2 col-xs-7">
                                <asp:DropDownList ID="ddl_m_4" runat="server" AutoPostBack="true" CssClass="ddl">
                                    <asp:ListItem Selected="True">0</asp:ListItem>
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-lg-5 col-sm-2 col-xs-12">
                                <asp:RadioButtonList ID="rbtn_tipo_h_4" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbtn_tipo_h_4_SelectedIndexChanged">
                                    <asp:ListItem Selected="true">Familiar</asp:ListItem>
                                    <asp:ListItem>Matrimonial</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                        </div>
                    </asp:Panel>

                    <div class="row">

                        <div class="form-group col-lg-offset-2 col-lg-8 col-sm-10 col-xs-10">
                            <h3>Déjanos tu comentario:</h3>
                        </div>

                        <div class="form-group col-lg-offset-2 col-lg-8 col-sm-10 col-xs-10">
                            <asp:TextBox CssClass="form-control input-lg" ID="txt_comentario" runat="server" TextMode="MultiLine" MaxLength="200" Height="60px" Width="100%"></asp:TextBox>
                        </div>

                        <div class="form-group col-lg-2 col-lg-offset-5 col-sm-3 col-sm-offset-4 col-xs-6 col-xs-offset-3">
                            <asp:Button ID="btn_reservar" CssClass="button form-control" runat="server" Text="Reservar" OnClick="btn_reservar_Click" />
                        </div>
                        <div class="form-group col-lg-10 col-lg-offset-2 col-sm-10 col-sm-offset-2 col-xs-10 col-xs-offset-2">
                            <asp:Label ID="Label2" runat="server" Text="" ForeColor="Red" Font-Size="Larger"></asp:Label>
                        </div>


                    </div>
                </div>


                <div id="snackbar">
                    <asp:Label ID="Label1" runat="server" Text="Listo!" CssClass="alerta"></asp:Label></div>
            </ContentTemplate>

        </asp:UpdatePanel>

	<a  name="contacto"></a>
    <div class="banner">

        <div class="container">

            <div class="row">
                <div class="col-lg-6">
                    <h2>Contáctenos</h2>
                </div>
                <div class="col-lg-6">
                    <ul class="list-inline banner-social-buttons">
                        <li>
                            <a href="#" class="btn btn-default btn-lg"><i class="fa fa-facebook fa-fw"></i> <span class="network-name">Facebook</span></a>
                        </li>
                        <li>
                            <a href="http://playacristalresort.wixsite.com/home" class="btn btn-default btn-lg"><i class="fa fa-home fa-fw"></i> <span class="network-name">Página Web</span></a>
                        </li>
                        <li>
                            <a href="#" class="btn btn-default btn-lg"><i class="fa fa-instagram fa-fw"></i> <span class="network-name">Instagram</span></a>
                        </li>
                    </ul>
                </div>
            </div>
            
        </div>
        <!-- /.container -->

    </div>
    <!-- /.banner -->

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="list-inline">
                        <li>
                            <a href="#">Inicio</a>
                        </li>
                        <li class="footer-menu-divider">&sdot;</li>
                        <li>
                            <a href="#habitaciones">Habitaciones</a>
                        </li>
                        <li class="footer-menu-divider">&sdot;</li>
                        <li>
                            <a href="#reservas">Reservas</a>
                        </li>
                        <li class="footer-menu-divider">&sdot;</li>
                        <li>
                            <a href="#contacto">Contacto</a>
                        </li>
                    </ul>
                    <p class="copyright text-muted small">Copyright  RobDav2017&copy;. All Rights Reserved</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="reservas/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script type="text/javascript" src="reservas/js/bootstrap.min.js"></script>     
    <script type="text/javascript" src="reservas/js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>        
    <script type="text/javascript" src="reservas/js/bootstrap-datetimepicker.es.js" charset="UTF-8"></script>
    <script src="assets/js/confirmar_reservas.js"></script>

        <script type="text/javascript">

            function BindControlEvents() {

                $(function () {

                    $('.form_date').datetimepicker({
                        language: 'es',
                        weekStart: 1,
                        todayBtn: 1,
                        autoclose: 1,
                        todayHighlight: 1,
                        startView: 2,
                        minView: 2,
                        forceParse: 0

                    });
                });

                $('.form_date').on('click', function (e) {
                    var lbl2 = $('#Label2');
                    lbl2.text(' ');
                    
                });
            }



            //Initial bind
            $(document).ready(function () {
                BindControlEvents();
            });

            //Re-bind for callbacks
            var prm = Sys.WebForms.PageRequestManager.getInstance();

            prm.add_endRequest(function () {
                BindControlEvents();
            });


           
        </script>

    </form>
</body>
</html>
