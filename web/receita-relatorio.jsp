<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>

<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.interativaconsultoria.dao.DaoReceita"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% DaoReceita ObDaoReceita = new DaoReceita(); %>
<%
                            String data_in = request.getParameter("dinicial") != null ? request.getParameter("dinicial") : "falso";
                            String data_fi = request.getParameter("dfinal") != null ? request.getParameter("dfinal") : "falso";

                            String dinheiro = "0";
                            String cheque_prazo_v = "0";
                            String cheque_prazo_r = "0";
                            String cheque_avista = "0";

                            String cartao_avista = "0";
                            String cartao_prazo_v = "0";
                            String cartao_prazo_r = "0";

                            String promissoria_v = "0";
                            String promissoria_r = "0";

                            BigDecimal vendido = new BigDecimal("0");
                            BigDecimal recebido = new BigDecimal("0");
                            BigDecimal futuro = new BigDecimal("0");

                            if (!data_fi.equals("falso") && !data_in.equals("falso")) {
                                DateFormat formatter;
                                Date date1;
                                Date date2;
                                formatter = new SimpleDateFormat("dd/MM/yyyy");
                                date1 = (Date) formatter.parse(data_in);
                                date2 = (Date) formatter.parse(data_fi);

                                dinheiro = ObDaoReceita.Consultar_Receita_data(date1, date2, 1, 1, 1).toString();
                                cheque_prazo_v = ObDaoReceita.Consultar_Receita_data(date1, date2, 3, 2, 2).toString();
                                cheque_prazo_r = ObDaoReceita.Consultar_Receita_data(date1, date2, 3, 2, 1).toString();
                                cheque_avista = ObDaoReceita.Consultar_Receita_data(date1, date2, 3, 1, 1).toString();

                                cartao_avista = ObDaoReceita.Consultar_Receita_data(date1, date2, 2, 1, 1).toString();
                                cartao_prazo_v = ObDaoReceita.Consultar_Receita_data(date1, date2, 2, 2, 2).toString();
                                cartao_prazo_r = ObDaoReceita.Consultar_Receita_data(date1, date2, 2, 2, 1).toString();

                                promissoria_v = ObDaoReceita.Consultar_Receita_data(date1, date2, 4, 2, 2).toString();
                                promissoria_r = ObDaoReceita.Consultar_Receita_data(date1, date2, 4, 2, 1).toString();

                                BigDecimal soma_v = new BigDecimal("0");
                                BigDecimal soma_r = new BigDecimal("0");
                                BigDecimal soma_f = new BigDecimal("0");

                                vendido = vendido.add(soma_v.add(new BigDecimal(dinheiro)));
                                vendido = vendido.add(soma_v.add(new BigDecimal(cheque_avista)));
                                vendido = vendido.add(soma_v.add(new BigDecimal(cheque_prazo_v)));
                                vendido = vendido.add(soma_v.add(new BigDecimal(cartao_avista)));
                                vendido = vendido.add(soma_v.add(new BigDecimal(cartao_prazo_v)));
                                vendido = vendido.add(soma_v.add(new BigDecimal(promissoria_v)));

                                recebido = recebido.add(soma_r.add(new BigDecimal(dinheiro)));
                                recebido = recebido.add(soma_r.add(new BigDecimal(cheque_avista)));
                                recebido = recebido.add(soma_r.add(new BigDecimal(cheque_prazo_r)));
                                recebido = recebido.add(soma_r.add(new BigDecimal(cartao_avista)));
                                recebido = recebido.add(soma_r.add(new BigDecimal(cartao_prazo_r)));
                                recebido = recebido.add(soma_r.add(new BigDecimal(promissoria_r)));

                                futuro = futuro.add(soma_f.add(new BigDecimal(cartao_prazo_v)));
                                futuro = futuro.add(soma_f.add(new BigDecimal(cheque_prazo_v)));
                                futuro = futuro.add(soma_f.add(new BigDecimal(promissoria_v)));

                            }

                        %>

<!-- meta-data -->
<!DOCTYPE html>
<html>
    <%@include file="partes/meta-data.jsp" %>  
    <style id="Base Controle Receitas 2016_10571_Styles">
        <!--table
        {mso-displayed-decimal-separator:"\,";
         mso-displayed-thousand-separator:"\.";}
        .xl1510571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:400;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri, sans-serif;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:general;
         vertical-align:bottom;
         mso-background-source:auto;
         mso-pattern:auto;
         white-space:nowrap;}
        .xl6610571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:400;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri, sans-serif;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:general;
         vertical-align:middle;
         border:.5pt solid windowtext;
         mso-background-source:auto;
         mso-pattern:auto;
         white-space:nowrap;}
        .xl6710571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:400;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri, sans-serif;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:general;
         vertical-align:middle;
         border:.5pt solid windowtext;
         background:#EBF1DE;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl6810571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:Standard;
         text-align:center;
         vertical-align:bottom;
         border:.5pt solid windowtext;
         background:#EBF1DE;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl6910571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:Standard;
         text-align:center;
         vertical-align:bottom;
         border:.5pt solid windowtext;
         mso-background-source:auto;
         mso-pattern:auto;
         white-space:nowrap;}
        .xl7010571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:center;
         vertical-align:bottom;
         border:.5pt solid windowtext;
         background:#DDD9C4;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl7110571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:center;
         vertical-align:middle;
         border-top:.5pt solid windowtext;
         border-right:.5pt solid windowtext;
         border-bottom:none;
         border-left:.5pt solid windowtext;
         background:#DDD9C4;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl7210571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:center;
         vertical-align:middle;
         border-top:none;
         border-right:.5pt solid windowtext;
         border-bottom:.5pt solid windowtext;
         border-left:.5pt solid windowtext;
         background:#DDD9C4;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl7310571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:16.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri, sans-serif;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:center;
         vertical-align:middle;
         border:.5pt solid windowtext;
         background:#C5D9F1;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl7410571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:12.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri, sans-serif;
         mso-font-charset:0;
         mso-number-format:General;
         text-align:center;
         vertical-align:middle;
         border:.5pt solid windowtext;
         background:#C5D9F1;
         mso-pattern:black none;
         white-space:nowrap;}
        .xl7510571
        {padding-top:1px;
         padding-right:1px;
         padding-left:1px;
         mso-ignore:padding;
         color:black;
         font-size:11.0pt;
         font-weight:700;
         font-style:normal;
         text-decoration:none;
         font-family:Calibri;
         mso-generic-font-family:auto;
         mso-font-charset:0;
         mso-number-format:Standard;
         text-align:center;
         vertical-align:middle;
         border:.5pt solid windowtext;
         mso-background-source:auto;
         mso-pattern:auto;
         white-space:nowrap;}
        -->
    </style>

    <!-- #Meta-data ------------------------------------------------------------------------------------------------->
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <!-- Menu-Topo -->   
            <%@include file="partes/menu-topo.jsp" %>    

            <!-- #fecha MEnu-top ------------------------------------------------------------------------------------------->
            <!-- Menu-lateral -->
            <%@include file="/partes/menu-lateral.jsp" %> 
            <!--#FEcha  Menu-lateral -->

            <!-- Conteúdo ------------------------------------------------------------------------------------------------->
            <div class="content-wrapper">
                <div class="box bg-red-active" >
                    <div class="box-header with-border" style="color: #fff">
                        <h1 class="box-title">Relatório Receita</h1>
                        <div class="row">
                            <div class="col-lg-3" style="margin: 10px" >   

                            </div>
                        </div>
                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                <i class="fa fa-minus"></i></button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
                                <i class="fa fa-times"></i></button>
                        </div>
                          
                        <form id="f1"  method="get" onSubmit="return valida()">
                            <div class="form-group">
                                <input type="hidden" class="form-control" id="idnivel">

                            </div>

                            <div class="form-group">
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>Data início:
                                    </div>
                                    <input  type="text"  class="form-control pull-right" name="dinicial" id="dinicial">
                                </div>
                                </br>
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>Data final:
                                    </div>
                                    <input type="text"  class="form-control pull-right" name="dfinal" id="dfinal">
                                </div>
                            </div>


                            <div class="clearfix"></div>
                            <button type="submit"  id="buscar"  class="btn btn-primary">Gerar relatório</button>

                        </form>

                    </div>
                </div>
                <!-- relatórios receita -->
                <div class="box">
                    <div class="box-header">
                        <p>Para imprimir selecione toda a tabela e presione o botão direito do mouse, em seguida imprimir.</p>
                        <table id="tbniveis" class="table table-responsive table-hover dataTable" >
                            <col width=29 >
                            <col width=58 >
                            <col class=xl1510571 width=79 >
                            <col width=83 span=7 style='mso-width-source:userset;mso-width-alt:3035;
                                 width:62pt'>
                            <tr height="6">
                                <td height=6 class=xl1510571 width=29 style='height:5.1pt;width:22pt'></td>
                                <td class=xl1510571 width=58 style='width:44pt'></td>
                                <td class=xl1510571 width=79 style='width:59pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                                <td class=xl1510571 width=83 style='width:62pt'></td>
                            </tr>
                            <tr class="xl1510571">
                                <td height=26 class=xl1510571 style='height:20.1pt'></td>
                                <td colspan=2 rowspan=2 class=xl7310571><p>Data início: <% out.print(data_in); %></p><p>Data final: <% out.print(data_fi); %></p></td>

                                <td rowspan=2 class=xl7110571 style='border-bottom:.5pt solid black'>Dinheiro</td>
                                <td colspan=2 class=xl7010571 style='border-left:none'>Cheque</td>
                                <td colspan=2 class=xl7010571 style='border-left:none'>Cartão</td>
                                <td rowspan=2 class=xl7110571 style='border-bottom:.5pt solid black'>Promissórias</td>
                                <td rowspan=2 class=xl7110571 style='border-bottom:.5pt solid black'>TOTAIS</td>
                            </tr>
                            <tr class=xl1510571 >
                                <td height=26 class=xl1510571 style='height:20.1pt'></td>
                                <td class=xl7010571 style='border-top:none;border-left:none'>à vista</td>
                                <td class=xl7010571 style='border-top:none;border-left:none'>a prazo</td>
                                <td class=xl7010571 style='border-top:none;border-left:none'>débito</td>
                                <td class=xl7010571 style='border-top:none;border-left:none'>crédito</td>
                            </tr>
                            <tr height=26>
                                <td height=26 class=xl1510571 style='height:20.1pt'></td>
                                <td rowspan=2 class=xl7410571 style='border-top:none'>TOTAIS</td>
                                <td class=xl6710571 style='border-top:none;border-left:none'>Vendido</td>
                                <td rowspan=2 class=xl7510571 style='border-top:none'><% out.print(Valor.FormatarValor(new BigDecimal(dinheiro)));%></td>
                                <td rowspan=2 class=xl7510571 style='border-top:none'><% out.print(Valor.FormatarValor(new BigDecimal(cheque_avista)));%></td>
                                <td class=xl6810571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(cheque_prazo_v)));%></td>
                                <td rowspan=2 class=xl7510571 style='border-top:none'><% out.print(Valor.FormatarValor(new BigDecimal(cartao_avista)));%></td>
                                <td class=xl6810571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(cartao_prazo_v)));%></td>
                                <td class=xl6810571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(promissoria_v)));%></td>
                                <td class=xl6810571 style='border-top:none;border-left:none'></td>
                            </tr>
                            <tr height=26 >
                                <td height=26 class=xl1510571 style='height:20.1pt'></td>
                                <td class=xl6610571 style='border-top:none;border-left:none'>Recebido</td>
                                <td class=xl6910571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(cheque_prazo_r)));%></td>
                                <td class=xl6910571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(cartao_prazo_r)));%></td>
                                <td class=xl6910571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(new BigDecimal(promissoria_r)));%></td>
                                <td class=xl6910571 style='border-top:none;border-left:none'></td>
                            </tr>
                            <tr height=28 >
                                <td height=28 class=xl1510571 style='height:21.0pt'></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                            </tr>
                            <tr height=28 >
                                <td height=28 class=xl1510571 style='height:21.0pt'></td>
                                <td rowspan=3 class=xl7410571>TOTAIS</td>
                                <td class=xl6710571 style='border-left:none'>Vendido</td>
                                <td class=xl6810571 style='border-left:none'><% out.print(Valor.FormatarValor(vendido));%></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                            </tr>
                            <tr height=28 >
                                <td height=28 class=xl1510571 style='height:21.0pt'></td>
                                <td class=xl6610571 style='border-top:none;border-left:none'>Recebido</td>
                                <td class=xl6910571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(recebido));%></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                            </tr>
                            <tr height=28 >
                                <td height=28 class=xl1510571 style='height:21.0pt'></td>
                                <td class=xl6710571 style='border-top:none;border-left:none'>Futuro</td>
                                <td class=xl6810571 style='border-top:none;border-left:none'><% out.print(Valor.FormatarValor(futuro));%></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                                <td class=xl1510571></td>
                            </tr>
                            <![if supportMisalignedColumns]>
                            <tr height=0 >
                                <td width=29 style='width:22pt'></td>
                                <td width=58 style='width:44pt'></td>
                                <td width=79 style='width:59pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                                <td width=83 style='width:62pt'></td>
                            </tr>
                            <![endif]>
                        </table>

                    </div>
                </div>
                <!-- #relatórios receita -->

            </div>
            <!-- #Fecha Conteúdo -->

            <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
            <%@include file="/partes/rodape.jsp" %> 
            <!-- #Fecha rodapé -->

        </div>
        <!-- js -->
        <%@include file="/partes/javascript.jsp" %> 

        <!-- #Fecha js-->
    </body>
</html>
<script>
    $('#dinicial,#dfinal').datepicker({
        autoclose: true,
        format: 'dd/mm/yyyy',
        language: 'pt-BR',
        weekStart: 0


    });
    
     $('#tbniveis').DataTable({
                
                dom: 'l,Bfrtip',
                buttons: [
                    {extend: 'copy',
                        text: 'Copiar',
                        footer: true},
                    {extend: 'csv',
                        text: 'Salvar CSV',
                        footer: true},
                    {extend: 'excel',
                        text: 'Salvar em Excel',
                        footer: true},
                    {extend: 'pdf',
                        text: 'Salvar PDF',
                        footer: true},
                    {extend: 'print',
                        text: 'Imprimir',
                        footer: true}
                ]
            });
</script>    
