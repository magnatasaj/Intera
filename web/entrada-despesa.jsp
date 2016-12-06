<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>

<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<% DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel(); %>
<% DaoDespesa ObDaoDespesa = new DaoDespesa(); %>


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
                <div class="box">
                    <div class="box-header with-border">
                        <h1 class="box-title">Entrada das Despesas</h1>
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
                        <!--------- tabela ------>
                        <table id="tbniveis" class="table table-bordered" >


                            <thead>
                                <tr>
                                    <th  style="width: 1px">Ordem</th>
                                    <th>Nome</th>
                                    <th>Entradas Mês Atual</th>
                                    <th>Pertence</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<Despesa_Niveis> ls = ObDaoDespesaNivel.Consultar_Todos_Nivel();
                                    for (Despesa_Niveis d : ls) {
                                        if (d.getPai() == 0) {
                                %>  
                                <tr <% if (d.getPai() == 0) {
                                        out.print("style='background-color:#3c8dbc; color:#FFF'");
                                    }; %>>
                                    <td><b><% out.print(d.getOrdem()); %></b></td>
                                    <td><b><% out.print(d.getNome()); %></b></td>
                                    <td><b></b></td>

                                    <td><b></b></td>


                                </tr>

                                <!-- Consultar nível 2 -->
                                <%
                                    for (Despesa_Niveis d2 : ls) {
                                        if (d2.getPai() == d.getId()) {
                                %> 
                                <tr style='background-color:#F0FFFF; color:#000'>
                                    <td><% out.print(d.getOrdem() + "." + d2.getOrdem()); %></td>
                                    <td><% out.print(d2.getNome()); %></td>
                                    <td></td>
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
                                    <td><% out.print(Valor.FormatarValor(ObDaoDespesa.Consultar_Despesa_mes_atual(d3.getId()))); %></td>
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




            $('#tbniveis').DataTable({
                paging: false,
                lengthChange: true,
                searching: true,
                ordering: false,
                info: true,
                autoWidth: true,
                fixedHeader: {
                    header: true,
                    footer: true
                }

            });

            $('#ddata').datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
                language: 'pt-BR'
                
            });
                         $('#ddata').datepicker("update", new Date());

        </script>
    </body>
</html>

