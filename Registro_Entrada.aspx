<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro_Entrada.aspx.cs" Inherits="SistemaRegistro.Registro_Entrada" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>Registro Entrada</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
        <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />       
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
         
        
        <div id="wrapper">
            <div id="main">
			
                <div class="row uniform">
            			
				<div class="4u 3u(medium)">
				</div>
				<div class="6u$ 6u$(medium)">
					<h2>Registro de Entrada</h2>
				</div>
			
			</div>

                <asp:UpdatePanel id="upnl_1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <div class="inner">

                            <div class="row 25% uniform" style="margin-left: 3.5em;">

                                <div class="2u$ 4u$(small) 11u$(xsmall)">
                                    <h3>Reservas:</h3>
                                </div>
                                <div class="4u 6u(small) 11u$(xsmall)" style="margin-bottom: 2em;">
                                    <label>Seleccione una reserva:</label>
                                    <ul class="feature-icons">
                                        <li class="fa-sort-down fa-fw" aria-hidden="true">
                                            <asp:DropDownList ID="ddl_b_cli" runat="server" AppendDataBoundItems="true"
                                                DataTextField="Reserva" DataValueField="Id_Reserva"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddl_b_cli_SelectedIndexChanged">
                                                <asp:ListItem Value="0" Selected="True">-Reservas-</asp:ListItem>
                                            </asp:DropDownList>
                                        </li>
                                    </ul>
                                </div>
                                <div class="3u$ 4u$(small) 11u$(xsmall)" >
                                   
                                    <asp:Button CssClass="offset" ID="btn_mod_reg" runat="server" Text="Modificar Registro" CausesValidation ="false" Visible="false" OnClick="btn_mod_reg_Click"/>
                                </div>
                            </div>

                            <asp:Panel ID="pnl_mod_reg" runat="server" CssClass="panel" Visible="false">
                                <div class="row 25% uniform" style="margin-left: 3.5em;">
                                     <div class="3u$ 4u$(small) 11u$(xsmall)">
                                        <h3>Modificar Registro:</h3>
                                    </div>
                                    <div class="4u 6u(small) 11u$(xsmall)" style="margin-bottom: 2em;">
                                        <label>Seleccione el registro a modificar:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-sort-down fa-fw" aria-hidden="true">
                                                <asp:DropDownList ID="ddl_reg" runat="server" AppendDataBoundItems="true"
                                                    DataTextField="Registro" DataValueField="Id_Registro_Cliente"
                                                    AutoPostBack="True" OnSelectedIndexChanged="ddl_reg_SelectedIndexChanged" >
                                                    <asp:ListItem Value="0">-Registros-</asp:ListItem>
                                                </asp:DropDownList>
                                            </li>
                                        </ul>
                                    </div>
                                     <div class="2u 3u(small) 11u$(xsmall)" style="margin-bottom: 2em;">
                                         <br />
                                         <asp:Button ID="btn_cancelar_mod" runat="server" Text="Cancelar" CausesValidation="false" OnClick="btn_cancelar_mod_Click"/>
                                    </div>
                                </div>

                            </asp:Panel>

                            <div class="row 25% uniform" style="margin-left: 3.5em;">
                                <div class="2u$ 4u$(small) 11u$(xsmall)">
                                    <h3>Cliente</h3>
                                </div>
                                <div class="3u 4u(small) 11u$(xsmall)">
                                   <label>Identificación del cliente:</label>
                                    <ul class="feature-icons">
                                        <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                            <asp:TextBox ID="txt_documento" runat="server" MaxLength="50" OnTextChanged="txt_documento_TextChanged" AutoPostBack="True"></asp:TextBox>
                                        </li>
                                    </ul>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="validator" Display="Dynamic"
                                        ControlToValidate="txt_documento" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" CssClass="validator" Display="Dynamic" ValidationGroup="mod_cliente"
                                        ControlToValidate="txt_documento" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="4u 5u(small) 11u$(xsmall)">
                                    <label>Nombre del cliente:</label>
                                    <ul class="feature-icons">
                                        <li class="fa-user fa-fw" aria-hidden="true">
                                            <input runat="server" id="inp_nombre" type="text" value="" placeholder="Nombre" maxlength="100" />
                                        </li>
                                    </ul>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" CssClass="validator" Display="Dynamic" ValidationGroup="mod_cliente"
                                        ControlToValidate="inp_nombre" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                                <div class="2u 2u$(small) 11u$(xsmall)">                                    
                                    <asp:Button CssClass="offset" ID="btn_mas" runat="server" Text="Más" CausesValidation="false" OnClick="btn_mas_Click" />
                                </div>

                            </div>

                            <asp:Panel ID="pnl_cliente" CssClass="panel" runat="server" Visible="false">
                                <div class="row 25% uniform" style="margin-left: 3.5em;">

                                    <div class="6u$ 10u$(small) 11u$(xsmall)">
                                        <h3>Crear/Modificar Cliente</h3>
                                    </div>

                                    <div class="6u$ 10u$(small) 11u$(xsmall)">
                                        <label>Dirección del cliente:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-home fa-fw" aria-hidden="true">
                                                <input runat="server" id="inp_direccion" type="text" value="" placeholder="Dirección" maxlength="200" />
                                            </li>
                                        </ul>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="validator"
                                            Display="Dynamic" ValidationGroup="mod_cliente"
                                            ControlToValidate="inp_direccion" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="9u$ 10u$(small) 11u$(xsmall)">
                                        <label>e-Mail:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-envelope-o fa-fw">
                                                <input runat="server" id="inp_email" type="text" value="" placeholder="Correo" maxlength="100" />
                                            </li>
                                        </ul>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="validator" Display="Dynamic"
                                            ControlToValidate="inp_email" runat="server" ValidationGroup="mod_cliente"
                                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="remail" runat="server" ForeColor="Red"
                                            CssClass="validator" Display="Dynamic" ValidationGroup="mod_cliente"
                                            ControlToValidate="inp_email" ErrorMessage="Ingrese un email valido"
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">
                                        </asp:RegularExpressionValidator>
                                    </div>

                                    <div class="3u 5u(small) 11u$(xsmall)">
                                       <label>Teléfono:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-phone fa-fw">
                                                <input runat="server" id="inp_telefono1" type="text" value="" placeholder="Teléfono 1" maxlength="20" />
                                            </li>
                                        </ul>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="mod_cliente"
                                            ControlToValidate="inp_telefono1" runat="server" CssClass="validator" Display="Dynamic"
                                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>



                                    <div class="3u$ 5u$(small) 11u$(xsmall)" style="margin-bottom: 2em;">
                                       <label>Teléfono (opcional):</label>
                                        <ul class="feature-icons">
                                            <li class="fa-phone fa-fw">
                                                <input runat="server" id="inp_telefono2" type="text" value="" placeholder="Teléfono 2" maxlength="20" />
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="3u 5u$(small) 11u$(xsmall)">
                                        <label>Edad:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-birthday-cake fa-fw">
                                                <input runat="server" id="inp_edad" type="text" value="" placeholder="Edad" maxlength="2" />
                                            </li>
                                        </ul>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="inp_edad" CssClass="validator"
                                            MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="mod_cliente"
                                            Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                    </div>
                                    <div class="3u 5u(small) 11u$(xsmall)">
                                        <label>Nacionalidad:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                <input runat="server" id="inp_nac" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                            </li>
                                        </ul>
                                    </div>

                                    <div class="3u$ 5u$(small) 11u$(xsmall)">
                                        <label>Género:</label>
                                        <ul class="feature-icons">
                                            <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                <asp:DropDownList ID="ddl_gen" runat="server">
                                                    <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                    <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                    <asp:ListItem Value="Empresa">Empresa</asp:ListItem>
                                                </asp:DropDownList>
                                            </li>
                                        </ul>
                                    </div>
                                    
                                    <div class="3u 5u(small) 11u$(xsmall)">
                                        <asp:Button ID="btn_guardar_cli" runat="server" Text="Actualizar Cliente" ValidationGroup="mod_cliente" OnClick="btn_guardar_cli_Click" />
                                    </div>
                                    <div class="3u 4u(small) 11u$(xsmall)">
                                        <asp:Button ID="btn_nuevo_cli" runat="server" Text="Nuevo Cliente" ValidationGroup="mod_cliente" OnClick="btn_nuevo_cli_Click" />
                                    </div>
                                    <div class="2u$ 3u$(small) 11u$(xsmall)">
                                        <asp:Button ID="btn_cancelar" runat="server" Text="Menos" CausesValidation="False" OnClick="btn_cancelar_Click" />
                                    </div>
                                    <div class="12u$">
                                        <br />
                                    </div>
                                </div>

                            </asp:Panel>

                            <div class="row 25% uniform" style="margin: 1.5em 0 1.5em 3.5em;">


                                <div class="4u$ 6u$(small) 11u$(xsmall)" style="margin-bottom: 2em;">
                                     <label>Habitación asignada:</label>
                                    <asp:Label ID="lbl_h_asignada" runat="server" Text=""></asp:Label>
                                </div>

                                <div class="2u 3u(small) 3u(xsmall)">
                                    <p>Fecha Ingreso:</p>
                                </div>
                                <div class="3u 8u$(small) 8u$(xsmall)">
                                    <ul class="feature-icons">
                                        <li class="fa-calendar fa-fw" aria-hidden="true">
                                            <asp:TextBox ID="txt_f_ingreso" runat="server" TextMode="Date"></asp:TextBox>
                                        </li>
                                    </ul>
                                    <asp:CustomValidator runat="server" ID="cusCustom" CssClass="validator" Display="Dynamic"
                                        OnServerValidate="custDate_ServerValidate"
                                        ForeColor="Red" ErrorMessage="Fecha y/o tiempo incorrecto" />

                                </div>
                                <div class="2u 3u(small) 4u(xsmall)">
                                    <p>Hora Ingreso:</p>
                                </div>
                                <div class="2u$ 4u$(small) 6u$(xsmall)">
                                    <ul class="feature-icons">
                                        <li class="fa-clock-o fa-fw" aria-hidden="true">
                                            <asp:TextBox ID="txt_h_ingreso" runat="server" TextMode="Time"></asp:TextBox>
                                        </li>
                                    </ul>


                                </div>
                                <div class="2u 3u(small) 3u(xsmall)">
                                    <p>Fecha Salida:</p>
                                </div>
                                <div class="3u 8u$(small) 8u$(xsmall)">
                                    <asp:Label ID="lbl_f_salida" runat="server" Text=""></asp:Label>
                                </div>

                            </div>



                            <asp:Panel ID="pnl_huesped" runat="server" Visible="true">
                                <div class="row uniform">
                                    <div class="2u$ 3u$(small)" style="margin-left: 4em;">
                                        <h3>Huéspedes</h3>
                                    </div>
                                    <div class="2u 3u(small) 4u(xsmall)">
                                        # Personas: 
                                    </div>
                                    <div class="2u$ 2u$(small) 5u$(xsmall)">
                                        <ul class="feature-icons">
                                            <li class="fa-list-ol fa-fw" aria-hidden="true">
                                                <asp:DropDownList ID="ddl_cant_p" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddl_cant_p_SelectedIndexChanged">
                                                    <asp:ListItem Selected="True">1</asp:ListItem>
                                                    <asp:ListItem>2</asp:ListItem>
                                                    <asp:ListItem>3</asp:ListItem>
                                                    <asp:ListItem>4</asp:ListItem>
                                                    <asp:ListItem>5</asp:ListItem>
                                                </asp:DropDownList>
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <asp:Panel ID="pnl_h_1" runat="server">
                                    <div class="row 25% uniform" style="margin-left: 3.5em;">
                                        <div class="6u$ 10u$(small) 11u$(xsmall)">
                                            <h3>Huésped 1</h3>
                                        </div>
                                        <div class="3u 4u(small) 11u$(xsmall)">
                                             <label>Identificación:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                                    <asp:TextBox ID="txt_h_doc_1" runat="server" AutoPostBack="true" OnTextChanged="txt_h_doc_1_TextChanged"></asp:TextBox>
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="validator" Display="Dynamic"
                                                ControlToValidate="txt_h_doc_1" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="huesped1"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="4u 5u(small) 11u$(xsmall)">
                                            <label>Nombre:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-user fa-fw" aria-hidden="true">
                                                    <input runat="server" id="inp_h_nombre_1" type="text" value="" placeholder="Nombre" maxlength="100" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" CssClass="validator" Display="Dynamic" ValidationGroup="huesped1"
                                                ControlToValidate="inp_h_nombre_1" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="3u 5u$(small) 11u$(xsmall)">                                            
                                            <label>Edad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-birthday-cake fa-fw">
                                                    <input runat="server" id="inp_h_edad_1" type="text" value="" placeholder="Edad" maxlength="2" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" CssClass="validator" Display="Dynamic" ValidationGroup="huesped1"
                                                ControlToValidate="inp_h_edad_1" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="inp_h_edad_1" CssClass="validator"
                                                MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="huesped1"
                                                Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                        </div>
                                        <div class="3u 5u(small) 11u$(xsmall)">
                                           <label>Nacionalidad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                    <input runat="server" id="inp_h_nac_1" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" CssClass="validator" Display="Dynamic" ValidationGroup="huesped1"
                                                ControlToValidate="inp_h_nac_1" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="3u$ 5u$(small) 11u$(xsmall)">
                                            <label>Género:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                    <asp:DropDownList ID="ddl_h_genero_1" runat="server">
                                                        <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                        <asp:ListItem Value="Femenino">Femenino</asp:ListItem>                                                        
                                                    </asp:DropDownList>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </asp:Panel>

                                <asp:Panel ID="pnl_h_2" runat="server" Visible="false">
                                    <div class="row 25% uniform" style="margin-left: 3.5em;">
                                        <div class="6u$ 10u$(small) 11u$(xsmall)">
                                            <h3>Huésped 2</h3>
                                        </div>
                                        <div class="3u 4u(small) 11u$(xsmall)">
                                            
                                            <label>Identificación:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                                    <asp:TextBox ID="txt_h_doc_2" runat="server" AutoPostBack="true" OnTextChanged="txt_h_doc_2_TextChanged"></asp:TextBox>
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" CssClass="validator" Display="Dynamic"
                                                ControlToValidate="txt_h_doc_2" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="huesped2"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="4u 5u(small) 11u$(xsmall)">
                                           <label>Nombre:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-user fa-fw" aria-hidden="true">
                                                    <input runat="server" id="inp_h_nombre_2" type="text" value="" placeholder="Nombre" maxlength="100" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" CssClass="validator" Display="Dynamic" ValidationGroup="huesped2"
                                                ControlToValidate="inp_h_nombre_2" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="3u 5u$(small) 11u$(xsmall)">
                                           <label>Edad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-birthday-cake fa-fw">
                                                    <input runat="server" id="inp_h_edad_2" type="text" value="" placeholder="Edad" maxlength="2" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" CssClass="validator" Display="Dynamic" ValidationGroup="huesped2"
                                                ControlToValidate="inp_h_edad_2" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="inp_h_edad_2" CssClass="validator"
                                                MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="huesped2"
                                                Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                        </div>
                                        <div class="3u 5u(small) 11u$(xsmall)">
                                            <label>Nacionalidad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                    <input runat="server" id="inp_h_nac_2" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" CssClass="validator" Display="Dynamic" ValidationGroup="huesped2"
                                                ControlToValidate="inp_h_nac_2" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="3u$ 5u$(small) 11u$(xsmall)">
                                             <label>Género:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                    <asp:DropDownList ID="ddl_h_genero_2" runat="server">
                                                        <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                        <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                    </asp:DropDownList>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </asp:Panel>

                                <asp:Panel ID="pnl_h_3" runat="server" Visible="false">
                                    <div class="row 25% uniform" style="margin-left: 3.5em;">
                                        <div class="6u$ 10u$(small) 11u$(xsmall)">
                                            <h3>Huésped 3</h3>
                                        </div>
                                        <div class="3u 4u(small) 11u$(xsmall)">
                                            <label>Identificación:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                                    <asp:TextBox ID="txt_h_doc_3" runat="server" AutoPostBack="true" OnTextChanged="txt_h_doc_3_TextChanged"></asp:TextBox>
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" CssClass="validator" Display="Dynamic"
                                                ControlToValidate="txt_h_doc_3" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="huesped3"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="4u 5u(small) 11u$(xsmall)">
                                            <label>Nombre:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-user fa-fw" aria-hidden="true">
                                                    <input runat="server" id="inp_h_nombre_3" type="text" value="" placeholder="Nombre" maxlength="100" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" CssClass="validator" Display="Dynamic" ValidationGroup="huesped3"
                                                ControlToValidate="inp_h_nombre_3" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="3u 5u$(small) 11u$(xsmall)">
                                           <label>Edad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-birthday-cake fa-fw">
                                                    <input runat="server" id="inp_h_edad_3" type="text" value="" placeholder="Edad" maxlength="2" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator17" CssClass="validator" Display="Dynamic" ValidationGroup="huesped3"
                                                ControlToValidate="inp_h_edad_3" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator4" runat="server" ControlToValidate="inp_h_edad_3" CssClass="validator"
                                                MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="huesped3"
                                                Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                        </div>
                                        <div class="3u 5u(small) 11u$(xsmall)">
                                            <label>Nacionalidad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                    <input runat="server" id="inp_h_nac_3" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator18" CssClass="validator" Display="Dynamic" ValidationGroup="huesped3"
                                                ControlToValidate="inp_h_nac_3" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="3u$ 5u$(small) 11u$(xsmall)">
                                             <label>Género:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                    <asp:DropDownList ID="ddl_h_genero_3" runat="server">
                                                        <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                        <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                    </asp:DropDownList>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </asp:Panel>

                                <asp:Panel ID="pnl_h_4" runat="server" Visible="false">
                                    <div class="row 25% uniform" style="margin-left: 3.5em;">
                                        <div class="6u$ 10u$(small) 11u$(xsmall)">
                                            <h3>Huésped 4</h3>
                                        </div>
                                        <div class="3u 4u(small) 11u$(xsmall)">
                                            <label>Identificación:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                                    <asp:TextBox ID="txt_h_doc_4" runat="server" AutoPostBack="true" OnTextChanged="txt_h_doc_4_TextChanged"></asp:TextBox>
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator19" CssClass="validator" Display="Dynamic"
                                                ControlToValidate="txt_h_doc_4" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="huesped4"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="4u 5u(small) 11u$(xsmall)">
                                           <label>Nombre:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-user fa-fw" aria-hidden="true">
                                                    <input runat="server" id="inp_h_nombre_4" type="text" value="" placeholder="Nombre" maxlength="100" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator20" CssClass="validator" Display="Dynamic" ValidationGroup="huesped4"
                                                ControlToValidate="inp_h_nombre_4" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="3u 5u$(small) 11u$(xsmall)">
                                            <label>Edad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-birthday-cake fa-fw">
                                                    <input runat="server" id="inp_h_edad_4" type="text" value="" placeholder="Edad" maxlength="2" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator21" CssClass="validator" Display="Dynamic" ValidationGroup="huesped4"
                                                ControlToValidate="inp_h_edad_4" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="inp_h_edad_4" CssClass="validator"
                                                MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="huesped4"
                                                Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                        </div>
                                        <div class="3u 5u(small) 11u$(xsmall)">
                                            <label>Nacionalidad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                    <input runat="server" id="inp_h_nac_4" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator22" CssClass="validator" Display="Dynamic" ValidationGroup="huesped4"
                                                ControlToValidate="inp_h_nac_4" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="3u$ 5u$(small) 11u$(xsmall)">
                                             <label>Género:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                    <asp:DropDownList ID="ddl_h_genero_4" runat="server">
                                                        <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                        <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                    </asp:DropDownList>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </asp:Panel>

                                <asp:Panel ID="pnl_h_5" runat="server" Visible="false">
                                    <div class="row 25% uniform" style="margin-left: 3.5em;">
                                        <div class="6u$ 10u$(small) 11u$(xsmall)">
                                            <h3>Huésped 5</h3>
                                        </div>
                                        <div class="3u 4u(small) 11u$(xsmall)">
                                            <label>Identificación:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-drivers-license-o fa-fw" aria-hidden="true">
                                                    <asp:TextBox ID="txt_h_doc_5" runat="server" AutoPostBack="true" OnTextChanged="txt_h_doc_5_TextChanged"></asp:TextBox>
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator23" CssClass="validator" Display="Dynamic"
                                                ControlToValidate="txt_h_doc_5" runat="server" ErrorMessage="*" ForeColor="Red" ValidationGroup="huesped5"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="4u 5u(small) 11u$(xsmall)">
                                            <label>Nombre:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-user fa-fw" aria-hidden="true">
                                                    <input runat="server" id="inp_h_nombre_5" type="text" value="" placeholder="Nombre" maxlength="100" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator24" CssClass="validator" Display="Dynamic" ValidationGroup="huesped5"
                                                ControlToValidate="inp_h_nombre_5" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="3u 5u$(small) 11u$(xsmall)">
                                            <label>Edad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-birthday-cake fa-fw">
                                                    <input runat="server" id="inp_h_edad_5" type="text" value="" placeholder="Edad" maxlength="2" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator25" CssClass="validator" Display="Dynamic" ValidationGroup="huesped5"
                                                ControlToValidate="inp_h_edad_5" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="inp_h_edad_5" CssClass="validator"
                                                MinimumValue="0" MaximumValue="99" Display="Dynamic" ValidationGroup="huesped5"
                                                Type="Integer" ErrorMessage="Valor entre 0 y 99" ForeColor="Red"></asp:RangeValidator>
                                        </div>
                                        <div class="3u 5u(small) 11u$(xsmall)">
                                            <label>Nacionalidad:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-globe fa-fw" style="margin-bottom: 2em;">
                                                    <input runat="server" id="inp_h_nac_5" type="text" value="" placeholder="Nacionalidad" maxlength="20" />
                                                </li>
                                            </ul>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator26" CssClass="validator" Display="Dynamic" ValidationGroup="huesped5"
                                                ControlToValidate="inp_h_nac_5" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </div>

                                        <div class="3u$ 5u$(small) 11u$(xsmall)">
                                             <label>Género:</label>
                                            <ul class="feature-icons">
                                                <li class="fa-venus-mars fa-fw" style="margin-bottom: 1em;">
                                                    <asp:DropDownList ID="ddl_h_genero_5" runat="server">
                                                        <asp:ListItem Selected="True" Value="Masculino">Masculino</asp:ListItem>
                                                        <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                    </asp:DropDownList>
                                                </li>
                                            </ul>
                                        </div>

                                    </div>

                                </asp:Panel>



                            </asp:Panel>
                            <div class="row uniform">
                                
                                <div class="3u 3u(small) 12u$(xsmall)">
                                    <asp:Button ID="btn_guardar" runat="server" Text="Guardar" OnClick="btn_guardar_Click" />
                                </div>

                                <div class="3u 3u(small) 12u$(xsmall)">
                                    <asp:Button ID="btn_borrar" runat="server" Text="Limpiar Campos" CausesValidation="false" OnClick="btn_borrar_Click" />
                                </div>
                                <div class="3u$ 3u$(small) 12u$(xsmall) offset">
                                    <asp:Button ID="btn_guardar_mod" runat="server" Text="Modificar Regisro" CausesValidation="false" OnClick="btn_guardar_mod_Click" Visible="false"/>&nbsp;
                                </div>


                            </div>

                            <div id="snackbar">
                                <asp:Label ID="Label1" runat="server" Text="Listo!"></asp:Label>
                            </div>

                        </div>
                        <!--Inner-->

                    </ContentTemplate>
                </asp:UpdatePanel>
			
			

		</div> <!--Main-->

            <div id="sidebar">
						<div class="inner">

							<!-- Menu -->
								<nav id="menu">
									<header class="major">
									<h2>Menu</h2>
									</header>
									<ul>
										<li><a href="Inicio.aspx">Inicio</a></li>
                                        <li id="admin" runat="server">
											<span  class="opener">Administración</span>
											<ul>
												<li id="a_usuarios" runat="server"><a href="Admin_Usuarios.aspx">Usuarios</a></li>
												<li id="a_habitaciones" runat="server"><a href="Admin_Habitaciones.aspx">Habitaciones</a></li>
												<li id="a_clientes" runat="server"><a href="Admin_Clientes.aspx">Clientes</a></li>
												<li id="a_perfil" runat="server"><a href="Mi_Perfil.aspx">Mi Perfil</a></li>
                                            </ul>
										</li>
                                        <li id="reservas" runat="server">
											<span class="opener">Reservas</span>
											<ul>
												<li id="res_confirmar" runat="server"><a href="Confirmar_Reservas.aspx">Confirmar</a></li>
												<li id="res_modificar" runat="server"><a href="Modificar_Reservas.aspx">Crear/Modificar</a></li>
                                            </ul>
										</li>
                                        <li id="registro" runat="server">
											<span  class="opener">Registro</span>
											<ul>
                                                <li id="reg_entrada" runat="server"><a href="Registro_Entrada.aspx">Entrada</a></li>
												<li id="reg_salida" runat="server"><a href="Registro_Salida.aspx">Salida</a></li>		
                                                <li id="reg_comprobante" runat="server"><a href="Comprobante.aspx">Comprobante</a></li>		
                                                
                                            </ul>
										</li>
                                        <li id="reporte" runat="server">
											<span class="opener">Reportes</span>
											<ul>
												<li id="rep_reservas" runat="server"><a href="Reporte_Reservas.aspx">Reservas</a></li>
												<li id="rep_registro" runat="server"><a href="Reporte_Registros.aspx">Registros</a></li>
                                            </ul>
										</li>
										<li><a href="Cerrar_Sesion.aspx">Cerrar Sesión</a></li>
									</ul>
								</nav>

							

							<!-- Footer -->
								<footer id="footer">
									<p class="copyright"> RobDav&copy;. All rights reserved.</p>
								</footer>

						</div>
					</div>
            
            
    </div>

		

		<!-- Scripts -->
		<script src="assets/js/jquery.min.js"></script>
		<script src="assets/js/skel.min.js"></script>
		<script src="assets/js/util.js"></script>
		<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
		<script src="assets/js/main.js"></script>        
        <script src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-1.8.0.js"></script>
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.22/jquery-ui.js"></script>
        <script src="assets/js/confirmar_reservas.js"></script>
    
        
    </form>
</body>
</html>

