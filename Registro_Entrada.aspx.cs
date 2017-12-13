using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaRegistro
{
    public partial class Registro_Entrada : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                try
                {

                    var u = db.sp_b_usuario_id(id).First();

                    if (u.Estado != 101)
                        Response.Redirect("Login.aspx");

                    if (u.Tipo_Usuario == 101)
                    {
                        MenuAdmin();
                        btn_mod_reg.Visible = true;
                    }
                    else if (u.Tipo_Usuario == 102)
                        MenuEncargado();
                    else if (u.Tipo_Usuario == 103)
                        MenuUsuario();
                    else
                    {
                        db.sp_m_estado_id(id);
                        Response.Redirect("Login.aspx");
                    }

                    
                    txt_h_ingreso.Text = DateTime.Now.ToLocalTime().ToString("HH:mm");
                    Session["id_cliente"] = 0;
                    RecargarValores();
                }
                catch (Exception ex)
                {
                    Response.Redirect("Login.aspx");
                }

            }

        }
        Int32 id = 0;
        private void MenuAdmin()
        {
            Session["tipo"] = 101;

        }

        private void MenuEncargado()
        {
            a_usuarios.Visible = false;
            a_habitaciones.Visible = false;

            Session["tipo"] = 102;

        }

        private void MenuUsuario()
        {
            a_usuarios.Visible = false;
            a_habitaciones.Visible = false;
            reporte.Visible = false;
            rep_registro.Visible = false;
            rep_reservas.Visible = false;

            Session["tipo"] = 103;
        }
        static objects.dbExternaDataContext db = new objects.dbExternaDataContext();
        protected void txt_documento_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var c = db.sp_b_cliente_doc(txt_documento.Text).First();

                Session["id_cliente"] = c.Id_Cliente;

                inp_nombre.Value = c.Nombre;
                inp_direccion.Value = c.Direccion;
                inp_email.Value = c.Correo;
                inp_telefono1.Value = c.Telefono1;
                inp_telefono2.Value = c.Telefono2;
                inp_nac.Value = c.Nacionalidad;
                ddl_gen.SelectedValue = c.Genero;
                int c_edad = DateTime.Now.Year - (Int32)c.F_Nacimiento;

                inp_edad.Value = Convert.ToString(c_edad);
                txt_h_doc_1.Text = txt_documento.Text;
                inp_h_nombre_1.Value = inp_nombre.Value;
                inp_h_edad_1.Value = inp_edad.Value;
                inp_h_nac_1.Value = inp_nac.Value;



            }
            catch (Exception ex)
            {
                
                inp_nombre.Focus();
            }

        }

        protected void RecargarValores()
        {
            ddl_b_cli.Items.Clear();
            ddl_b_cli.Items.Add(new ListItem("-Reservas-", "0"));     
            ddl_b_cli.DataSource = db.sp_b_rsv_ddl_c();
            ddl_b_cli.DataBind();
            ddl_b_cli.SelectedIndex = 0;
        }
        protected void ddl_b_cli_SelectedIndexChanged(object sender, EventArgs e)
        {
            ValoresDefault();
            LlenarCampos();
            
        }

        protected void LlenarCampos()
        {
           
            int id_rsv = 0;
            
            id_rsv = Convert.ToInt32(ddl_b_cli.SelectedValue);                    
            
            if (id_rsv != 0)
            {
                int existe_rsv = db.sp_b_rsv_id(id_rsv).Count();

                if (existe_rsv != 0)
                {
                    var rsv = db.sp_b_rsv_id(id_rsv).First();

                    DateTime f_desde = (DateTime)rsv.Fecha_Desde;
                    DateTime f_hasta = (DateTime)rsv.Fecha_Hasta;

                    txt_documento.Text = rsv.Documento;


                    txt_documento_TextChanged(null, EventArgs.Empty);

                    lbl_h_asignada.Text = rsv.Codigo_Habitacion;
                    txt_f_ingreso.Text = f_desde.Date.ToString("yyyy-MM-dd");
                    txt_h_ingreso.Text = DateTime.Now.ToLocalTime().ToString("HH:mm");    
                    lbl_f_salida.Text = f_hasta.Date.ToString("yyyy-MM-dd");
                    int cant_p =(Int32)(rsv.Cantidad_Adulto + rsv.Cantidad_Menor);
                    ddl_cant_p.SelectedIndex = cant_p - 1;
                    ddl_cant_p_SelectedIndexChanged(null, EventArgs.Empty);



                }
                else
                {
                    Label1.Text = "Error: No existe la reserva indicada.";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                }
            }
            else
            {
                Label1.Text = "Seleccione una reserva";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }


        }

        protected void custDate_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            try
            {
                DateTime f_ing = DateTime.Parse(txt_f_ingreso.Text);
                DateTime h_ing = DateTime.Parse(txt_h_ingreso.Text);
                
                if (f_ing >= DateTime.Now.AddDays(-15))
                    e.IsValid = true;
                else
                    e.IsValid = false;
            }
            catch (Exception ex)
            {
                e.IsValid = false;
            }

        }

        protected void btn_mas_Click(object sender, EventArgs e)
        {
            if (pnl_cliente.Visible)
            {
                btn_mas.Text = "Más";
                pnl_cliente.Visible = false;
            }
            else
            {
                btn_mas.Text = "Menos";
                pnl_cliente.Visible = true;
            }
        }
        protected void btn_cancelar_Click(object sender, EventArgs e)
        {
            btn_mas.Text = "Más";
            pnl_cliente.Visible = false;
        }
        protected void btn_guardar_cli_Click(object sender, EventArgs e)
        {
            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101)
                Response.Redirect("Login.aspx");

            if (Page.IsValid)
            {
                string documento = txt_documento.Text;

                GuardarCliente(documento);

            }
            else
            {
                Label1.Text = "Error: Revise los campos marcados";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }

        }
        protected void btn_nuevo_cli_Click(object sender, EventArgs e)
        {
            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101)
                Response.Redirect("Login.aspx");

            if (Page.IsValid)
            {
                string documento = txt_documento.Text;

                NuevoCliente(documento);

            }
            else
            {
                Label1.Text = "Error: Revise los campos marcados";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }



        }

        protected void GuardarCliente(string doc)
        {

            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101)
                Response.Redirect("Login.aspx");

            if (Page.IsValid)
            {
                string nombre = inp_nombre.Value;
                string direccion = inp_direccion.Value;
                string correo = inp_email.Value;
                string telf1 = inp_telefono1.Value;
                string telf2 = inp_telefono2.Value;
                string gen = ddl_gen.SelectedValue;
                string nac = inp_nac.Value;
                int id_cliente = 0;
                DateTime f_nac;
                if (Session["id_cliente"] != null)
                    id_cliente = (Int32)Session["id_cliente"];

                Byte edad;
                bool comp_e = Byte.TryParse(inp_edad.Value, out edad);



                if (id_cliente != 0)
                {

                    try
                    {
                        if (comp_e)
                        {
                            f_nac = DateTime.Now.AddYears(-edad);
                            db.sp_m_cliente(id_cliente, nombre, doc, direccion, correo, telf1, telf2, nac, gen,  (Int16)f_nac.Year);
                        }
                        else
                        {
                            db.sp_m_cliente(id_cliente, nombre, doc, direccion, correo, telf1, telf2, nac, gen, null);
                        }

                        Label1.Text = "Cliente modificado correctamente";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                    catch (Exception ex)
                    {
                        Label1.Text = "Error: El nombre ya está asignado a otro cliente";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                }
                else
                {
                    Label1.Text = "Error: Seleccione un cliente existente";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                }

            }
            else
            {
                Label1.Text = "Error: Revise los campos marcados";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }
        }
        protected void NuevoCliente(string doc)
        {

            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101)
                Response.Redirect("Login.aspx");

            if (Page.IsValid)
            {
                string nombre = inp_nombre.Value;
                string direccion = inp_direccion.Value;
                string correo = inp_email.Value;
                string telf1 = inp_telefono1.Value;
                string telf2 = inp_telefono2.Value;
                string gen = ddl_gen.SelectedValue;
                string nac = inp_nac.Value;
                DateTime f_nac;
                Byte edad;
                bool comp_e = Byte.TryParse(inp_edad.Value, out edad);

                int exi_u = db.sp_b_cliente_doc(doc).Count();

                if (exi_u > 0)
                {
                    Label1.Text = "El cliente ya existe en la base de datos";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                }
                else
                {
                    try
                    {
                        if (comp_e)
                        {
                            f_nac = DateTime.Now.AddYears(-edad);
                            db.sp_c_cliente(nombre, doc, direccion, correo, telf1, telf2, nac, gen, (Int16)f_nac.Year);
                        }
                        else
                        {
                            db.sp_c_cliente(nombre, doc, direccion, correo, telf1, telf2, nac, gen, null);
                        }

                        Label1.Text = "Cliente creado correctamente";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                    catch (Exception ex)
                    {
                        Label1.Text = "Error: El nombre ya está asignado a otro cliente";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                }

            }
            else
            {
                Label1.Text = "Error: Revise los campos marcados";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }
        }

        protected void btn_guardar_Click(object sender, EventArgs e)
        {
            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101)
                Response.Redirect("Login.aspx");

            int id_reg = 0;

            Validate("huesped1");
            Validate("huesped2");
            Validate("huesped3");
            Validate("huesped4");
            Validate("huesped5");

            if (Page.IsValid)
            {
                if (lbl_h_asignada.Text != string.Empty)
                {
                    DateTime f_ing = Convert.ToDateTime(txt_f_ingreso.Text);
                    DateTime h_ing = Convert.ToDateTime(txt_h_ingreso.Text);

                    DateTime aux = f_ing.Date.AddHours(h_ing.Hour).AddMinutes(h_ing.Minute);

                    DateTime f_salida = aux.AddDays(5);

                    if (lbl_f_salida.Text != string.Empty)
                        f_salida = Convert.ToDateTime(lbl_f_salida.Text);

                    string doc = txt_documento.Text;
                    int cli_exis = db.sp_b_cliente_doc(doc).Count();
                    if (cli_exis > 0)
                    {
                        int id_cli = db.sp_b_cliente_doc(doc).First().Id_Cliente;
                        int id_h = db.sp_b_id_h_cod(lbl_h_asignada.Text).First().Id_Habitacion;

                        id = (Int32)Session["id"];

                        id_reg = (Int32)db.sp_c_registro(id_cli, id_h, aux, f_salida, id).First().Id_Registro;

                        int id_rsv = Convert.ToInt32(ddl_b_cli.SelectedValue);
                        db.sp_m_rsv_estado(id_rsv);

                        if (id_reg != 0)
                        {

                            int cant_p = ddl_cant_p.SelectedIndex + 1;

                            string doc_h, nom, nac, gen;
                            byte edad;


                            doc_h = txt_h_doc_1.Text;
                            nom = inp_h_nombre_1.Value;
                            edad = Convert.ToByte(inp_h_edad_1.Value);
                            nac = inp_h_nac_1.Value;
                            gen = ddl_h_genero_1.SelectedValue;

                            db.sp_c_huesped(id_reg, doc_h, nom, edad, nac, gen);

                            if (cant_p > 1)
                            {
                                doc_h = txt_h_doc_2.Text;
                                nom = inp_h_nombre_2.Value;
                                edad = Convert.ToByte(inp_h_edad_2.Value);
                                nac = inp_h_nac_2.Value;
                                gen = ddl_h_genero_2.SelectedValue;

                                db.sp_c_huesped(id_reg, doc_h, nom, edad, nac, gen);

                            }
                            if (cant_p > 2)
                            {
                                doc_h = txt_h_doc_3.Text;
                                nom = inp_h_nombre_3.Value;
                                edad = Convert.ToByte(inp_h_edad_3.Value);
                                nac = inp_h_nac_3.Value;
                                gen = ddl_h_genero_3.SelectedValue;

                                db.sp_c_huesped(id_reg, doc_h, nom, edad, nac, gen);

                            }
                            if (cant_p > 3)
                            {
                                doc_h = txt_h_doc_4.Text;
                                nom = inp_h_nombre_4.Value;
                                edad = Convert.ToByte(inp_h_edad_4.Value);
                                nac = inp_h_nac_4.Value;
                                gen = ddl_h_genero_4.SelectedValue;

                                db.sp_c_huesped(id_reg, doc_h, nom, edad, nac, gen);

                            }
                            if (cant_p > 4)
                            {
                                doc_h = txt_h_doc_5.Text;
                                nom = inp_h_nombre_5.Value;
                                edad = Convert.ToByte(inp_h_edad_5.Value);
                                nac = inp_h_nac_5.Value;
                                gen = ddl_h_genero_5.SelectedValue;

                                db.sp_c_huesped(id_reg, doc_h, nom, edad, nac, gen);

                            }

                            Label1.Text = "Registro exitoso!";
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                            RecargarValores();
                            upnl_1.Update();
                        }
                        else
                        {
                            Label1.Text = "Error: Seleccione un registro!";
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                        }

                        
                    }
                    else
                    {
                        Label1.Text = "Error: El cliente no se encuentra registrado";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                }
                else
                {
                    Label1.Text = "Error: No se asignó una habitación";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                }

               
               
            }
        }

        protected void btn_borrar_Click(object sender, EventArgs e)
        {
            ValoresDefault();
            ddl_b_cli.SelectedIndex = 0;
        }

        private void ValoresDefault()
        {
            lbl_f_salida.Text = "aaaa-mm-dd";
            inp_direccion.Value = string.Empty;
            inp_email.Value = string.Empty;
            inp_nombre.Value = string.Empty;
            inp_telefono1.Value = string.Empty;
            inp_telefono2.Value = string.Empty;
            txt_documento.Text = string.Empty;
            ddl_gen.SelectedIndex = 0;
            inp_nac.Value = string.Empty;
            inp_edad.Value = string.Empty;
                      
            txt_f_ingreso.Text = string.Empty;
            txt_h_ingreso.Text = string.Empty;

            txt_h_doc_1.Text = string.Empty;
            txt_h_doc_2.Text = string.Empty;
            txt_h_doc_3.Text = string.Empty;
            txt_h_doc_4.Text = string.Empty;
            txt_h_doc_5.Text = string.Empty;
            inp_h_edad_1.Value = string.Empty;
            inp_h_edad_2.Value = string.Empty;
            inp_h_edad_3.Value = string.Empty;
            inp_h_edad_4.Value = string.Empty;
            inp_h_edad_5.Value = string.Empty;
            inp_h_nac_1.Value = string.Empty;
            inp_h_nac_2.Value = string.Empty;
            inp_h_nac_3.Value = string.Empty;
            inp_h_nac_4.Value = string.Empty;
            inp_h_nac_5.Value = string.Empty;
            inp_h_nombre_1.Value = string.Empty;
            inp_h_nombre_2.Value = string.Empty;
            inp_h_nombre_3.Value = string.Empty;
            inp_h_nombre_4.Value = string.Empty;
            inp_h_nombre_5.Value = string.Empty;
            ddl_h_genero_1.SelectedIndex = 0;
            ddl_h_genero_2.SelectedIndex = 0;
            ddl_h_genero_3.SelectedIndex = 0;
            ddl_h_genero_4.SelectedIndex = 0;
            ddl_h_genero_5.SelectedIndex = 0;

            ddl_cant_p.SelectedIndex = 0;
            pnl_h_2.Visible = false;
            pnl_h_3.Visible = false;
            pnl_h_4.Visible = false;
            pnl_h_5.Visible = false;
        }

       

       
       
        protected void ddl_cant_p_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddl_cant_p.SelectedIndex)
            {
                case 0:
                    pnl_h_2.Visible = false;
                    pnl_h_3.Visible = false;
                    pnl_h_4.Visible = false;
                    pnl_h_5.Visible = false;

                    break;
                case 1:
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = false;
                    pnl_h_4.Visible = false;
                    pnl_h_5.Visible = false;

                    break;

                case 2:
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = true;
                    pnl_h_4.Visible = false;
                    pnl_h_5.Visible = false;

                    break;
                case 3:
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = true;
                    pnl_h_4.Visible = true;
                    pnl_h_5.Visible = false;

                    break;
                case 4:
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = true;
                    pnl_h_4.Visible = true;
                    pnl_h_5.Visible = true;

                    break;
            }
        }

        protected void btn_mod_reg_Click(object sender, EventArgs e)
        {
            pnl_mod_reg.Visible = true;
            ddl_b_cli.Enabled = false;
            btn_guardar_mod.Visible = true;
            btn_guardar.Enabled = false;
            ddl_reg.Items.Clear();
            ddl_reg.Items.Add(new ListItem("-Registros-", "0"));
            ddl_reg.DataSource = db.sp_b_reg_ing();
            ddl_reg.DataBind();
            ddl_reg.SelectedIndex = 0; 
        }

        

        protected void ddl_reg_SelectedIndexChanged(object sender, EventArgs e)
        {
            int id_reg = Convert.ToInt32(ddl_reg.SelectedValue);

            var reg = db.sp_b_reg_ing_id(id_reg).First();
            var hues = db.sp_b_huesped_id(id_reg).ToList();
            int cant_H = hues.Count();


            lbl_h_asignada.Text = db.sp_b_habitacion_id(reg.Id_Habitacion).First().Codigo_Habitacion;


            ddl_cant_p.SelectedIndex = cant_H - 1;

            pnl_h_2.Visible = false;
            pnl_h_3.Visible = false;
            pnl_h_4.Visible = false;
            pnl_h_5.Visible = false;

            if (cant_H > 0)
            {
                pnl_h_1.Visible = true;
                txt_h_doc_1.Text = hues[0].Documento_H;
                inp_h_nombre_1.Value = hues[0].Nombre_H;
                inp_h_nac_1.Value = hues[0].Nacionalidad_H;
                inp_h_edad_1.Value = Convert.ToString(hues[0].Edad_H);
                ddl_h_genero_1.SelectedValue = hues[0].Genero_H;
            }
            if (cant_H > 1)
            {
                pnl_h_2.Visible = true;
                txt_h_doc_2.Text = hues[1].Documento_H;
                inp_h_nombre_2.Value = hues[1].Nombre_H;
                inp_h_nac_2.Value = hues[1].Nacionalidad_H;
                inp_h_edad_2.Value = Convert.ToString(hues[1].Edad_H);
                ddl_h_genero_2.SelectedValue = hues[1].Genero_H;
            }
            if (cant_H > 2)
            {
                pnl_h_3.Visible = true;
                txt_h_doc_3.Text = hues[2].Documento_H;
                inp_h_nombre_3.Value = hues[2].Nombre_H;
                inp_h_nac_3.Value = hues[2].Nacionalidad_H;
                inp_h_edad_3.Value = Convert.ToString(hues[2].Edad_H);
                ddl_h_genero_3.SelectedValue = hues[2].Genero_H;
            }
            if (cant_H > 3)
            {
                pnl_h_4.Visible = true;
                txt_h_doc_4.Text = hues[3].Documento_H;
                inp_h_nombre_4.Value = hues[3].Nombre_H;
                inp_h_nac_4.Value = hues[3].Nacionalidad_H;
                inp_h_edad_4.Value = Convert.ToString(hues[3].Edad_H);
                ddl_h_genero_4.SelectedValue = hues[3].Genero_H;
            }
            if (cant_H > 4)
            {
                pnl_h_5.Visible = true;
                txt_h_doc_5.Text = hues[4].Documento_H;
                inp_h_nombre_5.Value = hues[4].Nombre_H;
                inp_h_nac_5.Value = hues[4].Nacionalidad_H;
                inp_h_edad_5.Value = Convert.ToString(hues[4].Edad_H);
                ddl_h_genero_5.SelectedValue = hues[4].Genero_H;
            }

          
            if (reg.Fecha_Salida != null)
            {
                lbl_f_salida.Text = reg.Fecha_Salida.Value.Date.ToString("yyyy-MM-dd");
            }
            DateTime f = (DateTime)reg.Fecha_Ingreso;
            txt_f_ingreso.Text = f.Date.ToString("yyyy-MM-dd");
            txt_h_ingreso.Text = f.ToLocalTime().ToString("HH:mm");
            inp_direccion.Value = reg.Direccion;
            inp_email.Value = reg.Correo;
            inp_nombre.Value = reg.Nombre;
            inp_telefono1.Value = reg.Telefono1;
            inp_telefono2.Value = reg.Telefono2;
            txt_documento.Text = reg.Documento;
            ddl_gen.SelectedValue = reg.Genero;
            inp_nac.Value = reg.Nacionalidad;
           

            int c_edad = DateTime.Now.Year - (Int32)reg.F_Nacimiento;

            inp_edad.Value = Convert.ToString(c_edad);

        }

        protected void btn_guardar_mod_Click(object sender, EventArgs e)
        {
            if (Session["id"] != null)
                id = (Int32)Session["id"];
            else
                Response.Redirect("Login.aspx");

            var u = db.sp_b_usuario_id(id).First();

            if (u.Estado != 101 || u.Tipo_Usuario != 101)
                Response.Redirect("Login.aspx");
            
            int id_reg = 0;

            Validate("huesped1");
            Validate("huesped2");
            Validate("huesped3");
            Validate("huesped4");
            Validate("huesped5");

            if (Page.IsValid)
            {
                if (lbl_h_asignada.Text != string.Empty)
                {
                    DateTime f_ing = Convert.ToDateTime(txt_f_ingreso.Text);
                    DateTime h_ing = Convert.ToDateTime(txt_h_ingreso.Text);
                    
                    DateTime aux = f_ing.Date.AddHours(h_ing.Hour).AddMinutes(h_ing.Minute);
                    DateTime f_salida = aux.AddDays(5);

                    if (lbl_f_salida.Text != string.Empty)
                        f_salida = Convert.ToDateTime(lbl_f_salida.Text);

                    string doc = txt_documento.Text;
                    int cli_exis = db.sp_b_cliente_doc(doc).Count();
                    if (cli_exis > 0)
                    {
                        int id_cli = db.sp_b_cliente_doc(doc).First().Id_Cliente;
                        int id_h = db.sp_b_id_h_cod(lbl_h_asignada.Text).First().Id_Habitacion;

                        id = (Int32)Session["id"];
                        
                        id_reg = Convert.ToInt32(ddl_reg.SelectedValue);
                            
                        db.sp_m_registro(id_reg,id_cli, id_h, aux, f_salida, id);
                        
                        if (id_reg != 0)
                        {

                            var hues = db.sp_b_huesped_id(id_reg).ToList();

                            int cant_H = hues.Count();
                            int cant_H_n = ddl_cant_p.SelectedIndex + 1;
                            int id_H = 0;
                            int id_HR = 0;
                            Byte edad = 0;
                            if (cant_H == cant_H_n)
                            {
                                if (cant_H_n > 0)
                                {
                                    id_H = hues[0].Id_Huesped;
                                    id_HR = hues[0].Id_HR;
                                    edad = Convert.ToByte(inp_h_edad_1.Value);
                                    db.sp_m_huesped(id_H, id_HR, txt_h_doc_1.Text, inp_h_nombre_1.Value,edad, inp_h_nac_1.Value, ddl_h_genero_1.SelectedValue);
                                }
                                if (cant_H_n > 1)
                                {
                                    id_H = hues[1].Id_Huesped;
                                    id_HR = hues[1].Id_HR;
                                    edad = Convert.ToByte(inp_h_edad_2.Value);
                                    db.sp_m_huesped(id_H, id_HR, txt_h_doc_2.Text, inp_h_nombre_2.Value, edad, inp_h_nac_2.Value, ddl_h_genero_2.SelectedValue);
                                }
                                if (cant_H_n > 2)
                                {
                                    id_H = hues[2].Id_Huesped;
                                    id_HR = hues[2].Id_HR;
                                    edad = Convert.ToByte(inp_h_edad_3.Value);
                                    db.sp_m_huesped(id_H, id_HR, txt_h_doc_3.Text, inp_h_nombre_3.Value, edad, inp_h_nac_3.Value, ddl_h_genero_3.SelectedValue);
                                }
                                if (cant_H_n > 3)
                                {
                                    id_H = hues[3].Id_Huesped;
                                    id_HR = hues[3].Id_HR;
                                    edad = Convert.ToByte(inp_h_edad_4.Value);
                                    db.sp_m_huesped(id_H, id_HR, txt_h_doc_4.Text, inp_h_nombre_4.Value, edad, inp_h_nac_4.Value, ddl_h_genero_4.SelectedValue);
                                }
                                if (cant_H_n > 4)
                                {
                                    id_H = hues[4].Id_Huesped;
                                    id_HR = hues[4].Id_HR;
                                    edad = Convert.ToByte(inp_h_edad_5.Value);
                                    db.sp_m_huesped(id_H, id_HR, txt_h_doc_5.Text, inp_h_nombre_5.Value, edad, inp_h_nac_5.Value, ddl_h_genero_5.SelectedValue);
                                }
                            }
                            else if (cant_H > cant_H_n)
                            {
                                
                                if (cant_H > 0)
                                {
                                    if (cant_H_n > 0)
                                    {
                                        id_H = hues[0].Id_Huesped;
                                        id_HR = hues[0].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_1.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_1.Text, inp_h_nombre_1.Value, edad, inp_h_nac_1.Value, ddl_h_genero_1.SelectedValue);
                                    }
                                    
                                }
                                if (cant_H > 1)
                                {
                                    if (cant_H_n > 1)
                                    {
                                        id_H = hues[1].Id_Huesped;
                                        id_HR = hues[1].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_2.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_2.Text, inp_h_nombre_2.Value, edad, inp_h_nac_2.Value, ddl_h_genero_2.SelectedValue);

                                    }
                                    else
                                    {
                                        var elim = db.sp_e_huesped(hues[1].Id_Huesped);
                                    }

                                }
                                if (cant_H > 2)
                                {
                                    if (cant_H_n > 2)
                                    {
                                        id_H = hues[2].Id_Huesped;
                                        id_HR = hues[2].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_3.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_3.Text, inp_h_nombre_3.Value, edad, inp_h_nac_3.Value, ddl_h_genero_3.SelectedValue);
                                    }
                                    else
                                    {
                                        var elim = db.sp_e_huesped(hues[2].Id_Huesped);
                                    }

                                }
                                if (cant_H > 3)
                                {
                                    if (cant_H_n > 3)
                                    {
                                        id_H = hues[3].Id_Huesped;
                                        id_HR = hues[3].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_4.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_4.Text, inp_h_nombre_4.Value, edad, inp_h_nac_4.Value, ddl_h_genero_4.SelectedValue);

                                    }
                                    else
                                    {
                                        var elim = db.sp_e_huesped(hues[3].Id_Huesped);
                                    }

                                }
                                if (cant_H > 4)
                                {
                                    if (cant_H_n > 4)
                                    {
                                        id_H = hues[4].Id_Huesped;
                                        id_HR = hues[4].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_5.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_5.Text, inp_h_nombre_5.Value, edad, inp_h_nac_5.Value, ddl_h_genero_5.SelectedValue);

                                    }
                                    else
                                    {
                                        var elim = db.sp_e_huesped(hues[4].Id_Huesped);
                                    }

                                }

                            }
                            else //cant_H < cant_H_n
                            {
                                
                                if (cant_H_n > 0)
                                {
                                    if (cant_H > 0)
                                    {
                                        id_H = hues[0].Id_Huesped;
                                        id_HR = hues[0].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_1.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_1.Text, inp_h_nombre_1.Value, edad, inp_h_nac_1.Value, ddl_h_genero_1.SelectedValue);

                                    }
                                    else if (cant_H == 0)
                                    {
                                        edad = Convert.ToByte(inp_h_edad_1.Value);
                                        db.sp_c_huesped(id_reg, txt_h_doc_1.Text, inp_h_nombre_1.Value, edad, inp_h_nac_1.Value, ddl_h_genero_1.SelectedValue);
                                        
                                    }

                                }
                                if (cant_H_n > 1)
                                {
                                    if (cant_H > 1)
                                    {
                                        id_H = hues[1].Id_Huesped;
                                        id_HR = hues[1].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_2.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_2.Text, inp_h_nombre_2.Value, edad, inp_h_nac_2.Value, ddl_h_genero_2.SelectedValue);

                                    }
                                    else
                                    {
                                        edad = Convert.ToByte(inp_h_edad_2.Value);
                                        db.sp_c_huesped(id_reg, txt_h_doc_2.Text, inp_h_nombre_2.Value, edad, inp_h_nac_2.Value, ddl_h_genero_2.SelectedValue);
                                    }

                                }
                                if (cant_H_n > 2)
                                {
                                    if (cant_H > 2)
                                    {
                                        id_H = hues[2].Id_Huesped;
                                        id_HR = hues[2].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_3.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_3.Text, inp_h_nombre_3.Value, edad, inp_h_nac_3.Value, ddl_h_genero_3.SelectedValue);

                                    }
                                    else
                                    {
                                        edad = Convert.ToByte(inp_h_edad_3.Value);
                                        db.sp_c_huesped(id_reg, txt_h_doc_3.Text, inp_h_nombre_3.Value, edad, inp_h_nac_3.Value, ddl_h_genero_3.SelectedValue);
                                    }

                                }
                                if (cant_H_n > 3)
                                {
                                    if (cant_H > 3)
                                    {
                                        id_H = hues[3].Id_Huesped;
                                        id_HR = hues[3].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_4.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_4.Text, inp_h_nombre_4.Value, edad, inp_h_nac_4.Value, ddl_h_genero_4.SelectedValue);

                                    }
                                    else
                                    {
                                        edad = Convert.ToByte(inp_h_edad_4.Value);
                                        db.sp_c_huesped(id_reg, txt_h_doc_4.Text, inp_h_nombre_4.Value, edad, inp_h_nac_4.Value, ddl_h_genero_4.SelectedValue);
                                    }

                                }
                                if (cant_H_n > 4)
                                {
                                    if (cant_H > 4)
                                    {
                                        id_H = hues[4].Id_Huesped;
                                        id_HR = hues[4].Id_HR;
                                        edad = Convert.ToByte(inp_h_edad_5.Value);
                                        db.sp_m_huesped(id_H, id_HR, txt_h_doc_5.Text, inp_h_nombre_5.Value, edad, inp_h_nac_5.Value, ddl_h_genero_5.SelectedValue);

                                    }
                                    else
                                    {
                                        edad = Convert.ToByte(inp_h_edad_5.Value);
                                        db.sp_c_huesped(id_reg, txt_h_doc_5.Text, inp_h_nombre_5.Value, edad, inp_h_nac_5.Value, ddl_h_genero_5.SelectedValue);
                                    }

                                }

                            }



                            pnl_mod_reg.Visible = false;
                            btn_guardar.Enabled = true;
                            btn_guardar_mod.Visible = false;
                            ValoresDefault();
                            ddl_b_cli.Enabled = true;
                            ddl_b_cli.SelectedIndex = 0;
                            


                            Label1.Text = "Registro modificado correctamente!";
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);

                        }
                        else
                        {
                            Label1.Text = "Error: Seleccione un registro!";
                            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                        }


                    }
                    else
                    {
                        Label1.Text = "Error: El cliente no se encuentra registrado";
                        ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                    }
                }
                else
                {
                    Label1.Text = "Error: No se asignó una habitación";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
                }
            }

        }

        protected void btn_cancelar_mod_Click(object sender, EventArgs e)
        {
            pnl_mod_reg.Visible = false;
            btn_guardar_mod.Visible = false;
            btn_guardar.Enabled = true;
            ddl_b_cli.Enabled = true;
        }

        protected void txt_h_doc_1_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var hues = db.sp_b_huesped_doc(txt_h_doc_1.Text).First();
                inp_h_nombre_1.Value = hues.Nombre_H;
                inp_h_edad_1.Value = Convert.ToString(hues.Edad_H);
                inp_h_nac_1.Value = hues.Nacionalidad_H;
                ddl_h_genero_1.SelectedValue = hues.Genero_H;

            }
            catch (Exception ex)
            {

            }
        }
        protected void txt_h_doc_2_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var hues = db.sp_b_huesped_doc(txt_h_doc_2.Text).First();
                inp_h_nombre_2.Value = hues.Nombre_H;
                inp_h_edad_2.Value = Convert.ToString(hues.Edad_H);
                inp_h_nac_2.Value = hues.Nacionalidad_H;
                ddl_h_genero_2.SelectedValue = hues.Genero_H;

            }
            catch (Exception ex)
            {

            }
        }
        protected void txt_h_doc_3_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var hues = db.sp_b_huesped_doc(txt_h_doc_3.Text).First();
                inp_h_nombre_3.Value = hues.Nombre_H;
                inp_h_edad_3.Value = Convert.ToString(hues.Edad_H);
                inp_h_nac_3.Value = hues.Nacionalidad_H;
                ddl_h_genero_3.SelectedValue = hues.Genero_H;

            }
            catch (Exception ex)
            {

            }
        }
        protected void txt_h_doc_4_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var hues = db.sp_b_huesped_doc(txt_h_doc_4.Text).First();
                inp_h_nombre_4.Value = hues.Nombre_H;
                inp_h_edad_4.Value = Convert.ToString(hues.Edad_H);
                inp_h_nac_4.Value = hues.Nacionalidad_H;
                ddl_h_genero_4.SelectedValue = hues.Genero_H;

            }
            catch (Exception ex)
            {

            }

        }
        protected void txt_h_doc_5_TextChanged(object sender, EventArgs e)
        {
            try
            {
                var hues = db.sp_b_huesped_doc(txt_h_doc_5.Text).First();
                inp_h_nombre_5.Value = hues.Nombre_H;
                inp_h_edad_5.Value = Convert.ToString(hues.Edad_H);
                inp_h_nac_5.Value = hues.Nacionalidad_H;
                ddl_h_genero_5.SelectedValue = hues.Genero_H;

            }
            catch (Exception ex)
            {

            }
        }
        

    }


}