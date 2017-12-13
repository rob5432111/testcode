using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;

namespace SistemaRegistro
{
    public partial class Reservas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void custDate_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            try
            {
                DateTime f_desde = DateTime.Parse(inp_f_desde.Value);
                DateTime f_hasta = DateTime.Parse(inp_f_hasta.Value);
                TimeSpan dias = f_hasta - f_desde;
                
                if (f_hasta > f_desde && dias.Days <= 20)
                   e.IsValid = true;
                else
                   e.IsValid = false;

                if (f_desde.Date < DateTime.Now.Date)
                    e.IsValid = false;

            }
            catch (Exception ex)
            {
                e.IsValid = false;
            }

        }
        protected void custCant1_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            int a = ddl_a_1.SelectedIndex;
            int m = ddl_m_1.SelectedIndex;

            if ((a + m) >= 1)
                e.IsValid = true;
            else
                e.IsValid = false;
        }

        protected void custCant2_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            int a = ddl_a_2.SelectedIndex;
            int m = ddl_m_2.SelectedIndex;

            if ((a + m) >= 1)
                e.IsValid = true;
            else
                e.IsValid = false;
        }
        protected void custCant3_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            int a = ddl_a_3.SelectedIndex;
            int m = ddl_m_3.SelectedIndex;

            if ((a + m) >= 1)
                e.IsValid = true;
            else
                e.IsValid = false;
        }
        protected void custCant4_ServerValidate(object sender, ServerValidateEventArgs e)
        {
            int a = ddl_a_4.SelectedIndex;
            int m = ddl_m_4.SelectedIndex;

            if ((a + m) >= 1)
                e.IsValid = true;
            else
                e.IsValid = false;
        }

        objects.dbExternaDataContext db = new objects.dbExternaDataContext();

        protected void btn_reservar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                DateTime f_desde = DateTime.Parse(inp_f_desde.Value);
                DateTime f_hasta = DateTime.Parse(inp_f_hasta.Value);
                string f_ahora = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                Byte tipo_h = 0;


                DateTime f_realizacion = Convert.ToDateTime(f_ahora);
                string nombre, correo, telf1, telf2, comentario;
                Byte cant_a = 0, cant_m = 0;
                nombre = inp_nombre.Value.Trim();
                correo = inp_email.Value.Trim();
                telf1 = inp_telf_1.Value;
                telf2 = inp_telf_2.Value;
                comentario = txt_comentario.Text.Trim();
                int cant_h = ddl_cant_h.SelectedIndex;

                int h_disp = db.sp_b_h_disponibles_f(f_desde, f_hasta).Count();

                if (h_disp != 0)
                {

                    if (cant_h >= 0 && cant_h < 4)
                    {
                        cant_a = (Byte)ddl_a_1.SelectedIndex;
                        cant_m = (Byte)ddl_m_1.SelectedIndex;
                        tipo_h = (Byte)rbtn_tipo_h_1.SelectedIndex;
                        db.sp_c_posible_reserva(f_realizacion, f_desde, f_hasta, tipo_h, cant_a, cant_m, nombre, correo, telf1, telf2, comentario);

                    }
                    if (cant_h >= 1 && cant_h < 4)
                    {
                        cant_a = (Byte)ddl_a_2.SelectedIndex;
                        cant_m = (Byte)ddl_m_2.SelectedIndex;
                        tipo_h = (Byte)rbtn_tipo_h_2.SelectedIndex;
                        db.sp_c_posible_reserva(f_realizacion, f_desde, f_hasta, tipo_h, cant_a, cant_m, nombre, correo, telf1, telf2, comentario);

                    }
                    if (cant_h >= 2 && cant_h < 4)
                    {
                        cant_a = (Byte)ddl_a_3.SelectedIndex;
                        cant_m = (Byte)ddl_m_3.SelectedIndex;
                        tipo_h = (Byte)rbtn_tipo_h_3.SelectedIndex;
                        db.sp_c_posible_reserva(f_realizacion, f_desde, f_hasta, tipo_h, cant_a, cant_m, nombre, correo, telf1, telf2, comentario);

                    }
                    if (cant_h == 3)
                    {
                        cant_a = (Byte)ddl_a_4.SelectedIndex;
                        cant_m = (Byte)ddl_m_4.SelectedIndex;
                        tipo_h = (Byte)rbtn_tipo_h_4.SelectedIndex;
                        db.sp_c_posible_reserva(f_realizacion, f_desde, f_hasta, tipo_h, cant_a, cant_m, nombre, correo, telf1, telf2, comentario);

                    }
                    if (cant_h == 4)
                    {
                        string aux = comentario;
                        comentario = "5H! ";
                        comentario = comentario + aux;

                        db.sp_c_posible_reserva(f_realizacion, f_desde, f_hasta, 0, 0, 0, nombre, correo, telf1, telf2, comentario);
                    }


                    

                    Label1.Text = "Reserva creada correctamente!";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);

                    var tickets = db.sp_b_pos_rsv_fnom(f_realizacion,nombre);
                    string t_correo = string.Empty;

                    foreach (var item in tickets)
                    {
                        t_correo = t_correo + " - " + item.Id_Posible_Reserva;
                    }

                    cant_h = cant_h + 1;

                    EnviarCorreo(correo, cant_h ,f_desde, f_hasta, t_correo);

                }
                else
                {
                    Label2.Text = "Lo sentimos no existen habitaciones disponibles en las fechas seleccionadas";                   
                }

            }
            else
            {
                Label1.Text = "Error!: Revisa los campos marcados";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ShowMessage()", true);
            }
        }

        protected void ddl_cant_h_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddl_cant_h.SelectedIndex)
            {
                case 0:
                    pnl_h_1.Visible = true;
                    pnl_h_2.Visible = false;
                    pnl_h_3.Visible = false;
                    pnl_h_4.Visible = false;
                    lbl_5h.Visible = false;

                    break;
                case 1:
                    pnl_h_1.Visible = true;
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = false;
                    pnl_h_4.Visible = false;
                    lbl_5h.Visible = false;
                    break;
                case 2:
                    pnl_h_1.Visible = true;
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = true;
                    pnl_h_4.Visible = false;
                    lbl_5h.Visible = false;
                    break;
                case 3:
                    pnl_h_1.Visible = true;
                    pnl_h_2.Visible = true;
                    pnl_h_3.Visible = true;
                    pnl_h_4.Visible = true;
                    lbl_5h.Visible = false;
                    break;
                case 4:
                    pnl_h_1.Visible = false;
                    pnl_h_2.Visible = false;
                    pnl_h_3.Visible = false;
                    pnl_h_4.Visible = false;
                    lbl_5h.Visible = true;
                    break;
            }
        }

       

        protected void Ddl_a_Changed(DropDownList ddl_a, DropDownList ddl_m, RadioButtonList rbtn)
        {
            int a = ddl_a.SelectedIndex;
            int r = rbtn.SelectedIndex;
            int m = ddl_m.SelectedIndex;
            switch (a)
            {
                case 0:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    ddl_m.Items.Add(new ListItem("1"));
                    ddl_m.Items.Add(new ListItem("2"));
                    if (r == 0)
                    {
                        ddl_m.Items.Add(new ListItem("3"));
                        ddl_m.Items.Add(new ListItem("4"));
                        ddl_m.Items.Add(new ListItem("5"));
                        ddl_m.SelectedIndex = m;
                    }
                    else
                        ddl_m.SelectedIndex = 0;
                    break;
                case 1:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    ddl_m.Items.Add(new ListItem("1"));
                    if (r == 0)
                    {
                        ddl_m.Items.Add(new ListItem("2"));
                        ddl_m.Items.Add(new ListItem("3"));
                        ddl_m.Items.Add(new ListItem("4"));
                        if (m < 5)
                            ddl_m.SelectedIndex = m;
                        else
                            ddl_m.SelectedIndex = 0;
                    }                   
                    else
                        ddl_m.SelectedIndex = 0;
                    break;
                case 2:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    if (r == 0)
                    {
                        ddl_m.Items.Add(new ListItem("1"));                    
                        ddl_m.Items.Add(new ListItem("2"));
                        ddl_m.Items.Add(new ListItem("3"));
                        if (m < 4)
                            ddl_m.SelectedIndex = m;
                        else
                            ddl_m.SelectedIndex = 0;
                    }
                    else
                        ddl_m.SelectedIndex = 0;
                    break;
                case 3:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    if (r == 0)
                    {
                        ddl_m.Items.Add(new ListItem("1"));
                        ddl_m.Items.Add(new ListItem("2"));
                        if (m < 3)
                            ddl_m.SelectedIndex = m;
                        else
                            ddl_m.SelectedIndex = 0;
                    }                    
                    else
                        ddl_m.SelectedIndex = 0;
                    break;
                case 4:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    if (r == 0)
                    {
                        ddl_m.Items.Add(new ListItem("1"));
                        if (m < 2)
                            ddl_m.SelectedIndex = m;
                        else
                            ddl_m.SelectedIndex = 0;
                    }
                    else
                        ddl_m.SelectedIndex = 0;
                    break;
                case 5:
                    ddl_m.Items.Clear();
                    ddl_m.Items.Add(new ListItem("0"));
                    ddl_m.SelectedIndex = 0;
                    break;

            }

        }

        protected void EnviarCorreo(string correo, int cant_h, DateTime f_desde, DateTime f_hasta, string ticket)
        {
            

            MailMessage mail = new MailMessage();
            SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
            //Especificamos el correo desde el que se enviará el Email y el nombre de la persona que lo envía
            mail.From = new MailAddress("roberto.pozo.andrade@gmail.com", "Playa Cristal", Encoding.UTF8);
            //Aquí ponemos el asunto del correo
            mail.Subject = "Reserva realizada correctamente";
            //Aquí ponemos el mensaje que incluirá el correo

            //mail.Body = "Factura electronica" + cliente.Nombre;

            mail.Body = "PlayaCristal Body";

           
            //Configuracion del SMTP
            SmtpServer.Port = 25; //Puerto que utiliza Gmail para sus servicios
            //Especificamos las credenciales con las que enviaremos el mail
            SmtpServer.Credentials = new System.Net.NetworkCredential("roberto.pozo.andrade@gmail.com", "Benzin004!");
            SmtpServer.EnableSsl = true;



            string text = "Creación de la reserva para las fechas: " + f_desde.ToShortDateString() + " - " + f_hasta.ToShortDateString();


            AlternateView plainView =
                AlternateView.CreateAlternateViewFromString(text,
                                        Encoding.UTF8,
                                        MediaTypeNames.Text.Plain);
            

            string f_desde_s = f_desde.ToShortDateString();
            string f_hasta_s = f_hasta.ToShortDateString();
            string html = @"<img src='cid:imagen' />
                          <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Reserva Confirmada</h1>
                          <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Su reserva de " + cant_h + " habitaciones <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;para el día: " + f_desde_s +
                          " hasta el día: " + f_hasta_s + " se ha sido realizado correctamente</p>"
                          + "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cualquier reclamo puede realizarlo con el numero de ticket: " + ticket + "</p><br />"
                          + "<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Para confirmar la reserva es necesario realizar el pago del 50% del total <br /> "
                          + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;a la cuenta 12345678-9 del BancoPrueba a nombre de PalmaResorts</p><br />"
                          + "<p>Telf: 0987654132 / 02 345 654</p><br />";

            AlternateView htmlView =
                AlternateView.CreateAlternateViewFromString(html,
                                        Encoding.UTF8,
                                        MediaTypeNames.Text.Html);

            // Creamos el recurso a incrustar. Observad
            // que el ID que le asignamos (arbitrario) está
            // referenciado desde el código HTML como origen
            // de la imagen (resaltado en amarillo)...

            LinkedResource img =
                new LinkedResource(Server.MapPath("~/images/Logo.JPG"), MediaTypeNames.Image.Jpeg);

            img.ContentId = "imagen";

            // Lo incrustamos en la vista HTML...

            htmlView.LinkedResources.Add(img);

            // Por último, vinculamos ambas vistas al mensaje...

            mail.AlternateViews.Add(plainView);
            mail.AlternateViews.Add(htmlView);

            mail.To.Clear();
            mail.Headers.Remove("to");
            mail.To.Add(correo);
            SmtpServer.Send(mail);




        }


        protected void ddl_a_1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ddl_a_Changed(ddl_a_1, ddl_m_1,rbtn_tipo_h_1);
        }
        
        protected void ddl_a_2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ddl_a_Changed(ddl_a_2, ddl_m_2, rbtn_tipo_h_2);
        }
        
        protected void ddl_a_3_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ddl_a_Changed(ddl_a_3, ddl_m_3, rbtn_tipo_h_3);
        }
       
        protected void ddl_a_4_SelectedIndexChanged(object sender, EventArgs e)
        {
            Ddl_a_Changed(ddl_a_4, ddl_m_4, rbtn_tipo_h_4);
        }
        

        protected void Rbtn_Changed(RadioButtonList rbtn, DropDownList ddl_a, DropDownList ddl_m)
        {
            int a = ddl_a.SelectedIndex;
            switch (rbtn.SelectedIndex)
            {
                case 0:

                    ddl_a.Items.Clear();
                    ddl_a.Items.Add(new ListItem("0"));
                    ddl_a.Items.Add(new ListItem("1"));
                    ddl_a.Items.Add(new ListItem("2"));
                    ddl_a.Items.Add(new ListItem("3"));
                    ddl_a.Items.Add(new ListItem("4"));
                    ddl_a.Items.Add(new ListItem("5"));
                    ddl_a.SelectedIndex = 0;


                    break;

                case 1:
                    ddl_a.Items.Clear();
                    ddl_a.Items.Add(new ListItem("0"));
                    ddl_a.Items.Add(new ListItem("1"));
                    ddl_a.Items.Add(new ListItem("2"));

                    if (a > 2)
                    {
                        ddl_a.SelectedIndex = 0;
                        ddl_m.Items.Clear();
                        ddl_m.Items.Add(new ListItem("0"));
                        ddl_m.Items.Add(new ListItem("1"));
                        ddl_m.Items.Add(new ListItem("2"));
                        ddl_m.SelectedIndex = 0;
                    }
                    else
                    {
                        ddl_a.SelectedIndex = a;
                        switch (a)
                        {
                            case 0:
                                ddl_m.Items.Clear();
                                ddl_m.Items.Add(new ListItem("0"));
                                ddl_m.Items.Add(new ListItem("1"));
                                ddl_m.Items.Add(new ListItem("2"));
                                ddl_m.SelectedIndex = 0;
                                break;
                            case 1:
                                ddl_m.Items.Clear();
                                ddl_m.Items.Add(new ListItem("0"));
                                ddl_m.Items.Add(new ListItem("1"));                               
                                ddl_m.SelectedIndex = 0;
                                break;
                            case 2:
                                ddl_m.Items.Clear();
                                ddl_m.Items.Add(new ListItem("0"));                               
                                ddl_m.SelectedIndex = 0;
                                break;
                        }
                    }
                    

                    break;
            }
        }

        protected void rbtn_tipo_h_1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Rbtn_Changed(rbtn_tipo_h_1,ddl_a_1,ddl_m_1);
        }

        protected void rbtn_tipo_h_2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Rbtn_Changed(rbtn_tipo_h_2, ddl_a_2, ddl_m_2);
        }

        protected void rbtn_tipo_h_3_SelectedIndexChanged(object sender, EventArgs e)
        {
            Rbtn_Changed(rbtn_tipo_h_3, ddl_a_3, ddl_m_3);
        }

        protected void rbtn_tipo_h_4_SelectedIndexChanged(object sender, EventArgs e)
        {
            Rbtn_Changed(rbtn_tipo_h_4, ddl_a_4, ddl_m_4);
        }
    }
}