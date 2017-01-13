<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>

<%@page import="java.util.TimeZone"%>
<%@page import="java.util.Locale"%>
<%@page import="com.interativaconsultoria.dao.DaoAno"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<% DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel(); %>
<% DaoDespesa ObDaoDespesa = new DaoDespesa(); %>
<%

    Calendar cal = GregorianCalendar.getInstance();
    String ano = "";
    int mes = 1;
    if (request.getParameter("ano") == null || request.getParameter("ano").isEmpty()) {
        ano = Integer.toString(cal.get(Calendar.YEAR));
    } else {
        ano = request.getParameter("ano");
    }
    if (request.getParameter("mes") == null || request.getParameter("mes").isEmpty()) {
        mes += cal.get(Calendar.MONTH);
        System.out.print("mes:" + mes);
                System.out.print("ano:" + ano);

    } else {
        mes = Integer.parseInt(request.getParameter("mes"));
    }

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- meta-data -->
<!DOCTYPE html>
<html>
    <%@include file="partes/meta-data.jsp" %>    
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
                <div class="box" style="border-top: 5px solid red">
                    <div class="box-header with-border">
                        <h1 class="box-title">Entrada das Despesas</h1>
                        <form action="entrada-despesa.jsp" method="get">

                            <div class="row">

                                <div class="col-lg-6" > 
                                    ANO:
                                    <select id="ano" name="ano" class="form-control">
                                        <option></option>
                                        <% DaoAno dano = new DaoAno();
                                            List<Integer> lano = dano.Lista_anos();
                                            for (int an : lano) { %>  
                                        <option><% out.println(an); %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="col-lg-6"> 
                                    MÊS:
                                    <select id="mes" name="mes" class="form-control">
                                        <option></option>
                                        <%

                                            for (int i = 1; i <= 12; i++) { %>  
                                        <option><% out.println(i); %></option>
                                        <% } %>
                                    </select>
                                </div>

                            </div>
                            <button style="margin-top: 5px;" type="submit"  id="buscar"  class="btn btn-primary">Alterar</button>

                        </form>           
                    </div>
                    <div class="box-tools pull-right">
                        <p>OBS: para filtrar nível 1 use "@"</p>
                    </div>
                    <!--------- tabela ------>
                    <table id="tbniveis" cellspacing="0" width="99%" class="table table-bordered table-striped" >


                        <thead>
                            <tr>
                                <th  style="width: 1px">Ordem</th>
                                <th>Nome</th>
                                <th>Entradas data:<%out.print(mes + "/" + ano);%></th>

                                <th>Pertence</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Despesa_Niveis> ls = ObDaoDespesaNivel.Consultar_Todos_Nivel();
                                String sg = "";
                                for (Despesa_Niveis d : ls) {
                                    if (d.getPai() == 0) {
                            %>  
                            <tr <% if (d.getPai() == 0) {
                                    out.print("style='background-color:red; color:#FFF'");
                                    sg = "@  ";
                                }; %>>
                                <td><b><% out.print(d.getOrdem()); %></b></td>
                                <td><b><% out.print(d.getNome()); %></b></td>
                                <td><b><% out.print(Valor.FormatarValor(ObDaoDespesa.Despesa_tabela_nivel1_total(d.getId(), ano, mes))); %></b></td>
                                <td><b style="color: red"><% out.print(sg); %></b></td>


                            </tr>

                            <!-- Consultar nível 2 -->
                            <%
                                for (Despesa_Niveis d2 : ls) {
                                    if (d2.getPai() == d.getId()) {
                            %> 
                            <tr style='background-color: #F7A6A6'>
                                <td><% out.print(d.getOrdem() + "." + d2.getOrdem()); %></td>
                                <td><% out.print(d2.getNome()); %></td>
                                <td><% out.print(Valor.FormatarValor(ObDaoDespesa.Despesa_tabela_nivel2_total(d2.getId(), ano, mes))); %></td>
                                <td><% out.print(d.getNome()); %></td>
                            </tr>
                            <!-- Consultar nivel 3 -->
                            <%
                                for (Despesa_Niveis d3 : ls) {
                                    if (d3.getPai() == d2.getId()) {
                            %> 
                            <tr>

                                <td>  -><% out.print(d.getOrdem() + "." + d2.getOrdem() + "." + d3.getOrdem()); %></td>
                                <td><a href="#modal-inserir-despesa"  onclick='valores(<% out.print(d3.getId());%>, "<% out.print(d3.getNome()); %>")' data-toggle="modal" data-target="#modal-inserir-despesa"><% out.print(d3.getNome()); %></a></td>
                                <td><% out.print(Valor.FormatarValor(ObDaoDespesa.Consultar_Despesa_mes_despesa_especifica(mes, ano, d3.getId()))); %></td>

                                <td>  <% out.print(d2.getNome()); %></td>
                            </tr>

                            <% }
                                }; %>
                            <% }
                                }; %>    

                            <% }
                                };%>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Modal editar -->
            <div class="modal fade" id="modal-inserir-despesa" role="dialog"   aria-labelledby="myModalLabel">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="#" target="_blank" id="edhistorico"><button type="button"   name="edfistorico" class="btn btn-adn">Histórico de Entrada</button></a>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                            <p id="edt"></p>

                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <input type="hidden" class="form-control" id="idnivel">

                                </div>
                                <div class="form-group">
                                    <label for="valor" class="control-label">Valor R$:</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">R$</span>
                                        <input  class="form-control" name="valor" id="valor" autofocus>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="input-group date">
                                        <div class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </div>
                                        <input type="text"  class="form-control pull-right" id="ddata">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="des" class="control-label">Descrição da despesa:</label>
                                    <div>

                                        <textarea rows="5"  class="form-control" name="desc" id="desc"></textarea>

                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <div class="col-lg-1">
                            </div>

                            <button type="button"  id="edsalvar" name="edsalvar" class="btn btn-primary">Salvar alterações</button>

                            <button type="button" id="edfecha"  class="btn btn-default" data-dismiss="modal">Fecha</button>

                        </div>
                    </div>
                </div>
            </div>
            <!--#fecha Modal Editar -->

        </div>
        <!-- #Fecha Conteúdo -->

        <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
        <%@include file="/partes/rodape.jsp" %> 
        <!-- #Fecha rodapé -->

    </div>
    <!-- js -->
    <%@include file="/partes/javascript.jsp" %> 
    <script type="text/javascript" >

        function valores(cod, nome) {

            document.getElementById("idnivel").value = "";
            document.getElementById("valor").value = "";
            document.getElementById("desc").value = "";
            document.getElementById("idnivel").value = cod;
            document.getElementById("myModalLabel").innerHTML = "Será inserido na categoria:<b>" + nome + "</b>";
            document.getElementById("edhistorico").href = "historio-despesa-especifica.jsp?id=" + cod + "&nome=" + nome;
            document.getElementById("valor").focus(true);

        }

        function ocultar() {
            $("#edt").slideUp("slow");
        }
        $(document).ready(function() {



            $('#edsalvar').click(function(event) {
                var idd = $('#idnivel').val();
                var valor = $('#valor').val();
                var data = $('#ddata').val();
                var desc = $('#desc').val();
                $.post('SvDespesas', {
                    id: idd,
                    valor: valor,
                    data: data,
                    desc: desc,
                    t: 'add'
                }, function(responseText) {


                    $("#edt").slideDown("slow");

                    $('#edt').html(responseText);
                    setTimeout("ocultar()", 5000);
                    $('#valor').val('');
                    $('#desc').val('');
                });

            });








            $("#valor").maskMoney({
                symbol: '',
                showSymbol: true,
                thousands: '.',
                decimal: ',',
                symbolStay: true
            });

            $('#modal-inserir-despesa').on('hidden.bs.modal', function() {
                var id = $('#edid').val();

                window.setTimeout('location.reload()', 10);
                location.hash = hash;
            })


        });

    </script>    
    <!-- #Fecha js-->
    <script>




        var tb = $('#tbniveis').DataTable({
            "paging": false,
            "scrollX": true,
            "lengthChange": true,
            "searching": true,
            
            "ordering": false,
            "info": true,
            "autoWidth": true,
            "language": {
                "decimal": ",",
                "thousands": "."
            },
            "lengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Todos"]],
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
        $('#ddata').datepicker({
            autoclose: true,
            format: 'dd/mm/yyyy',
            language: 'pt-BR'
             


        });

        $('#ddata').datepicker("update", new Date("<%out.print(ano+"/"+mes+"/01"); %>"));

    </script>
    
</body>
</html>
<% ObDaoDespesa.fechar(); %>

