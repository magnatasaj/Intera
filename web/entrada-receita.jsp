<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>

<%@page import="com.interativaconsultoria.objetos.ReceitaOrigem"%>
<%@page import="com.interativaconsultoria.objetos.Receita"%>
<%@page import="com.interativaconsultoria.dao.DaoReceitaOrigem"%>
<%@page import="com.interativaconsultoria.dao.DaoReceita"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<% DaoReceitaOrigem ObDaoReceitaOrigem = new DaoReceitaOrigem(); %>


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
                        <h1 class="box-title">Entrada de Receita</h1>
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

                        <form id="form_receita">
                            <!-- Tipo de entrada-->
                            <div class="row">
                                <div class="col-lg-5">
                                    <div id="tipo" class="callout callout-success" style="font-size: 19px">
                                        <h2>Formas de pagamento</h2>

                                        <%  for (ReceitaOrigem r : ObDaoReceitaOrigem.Consultar_Todas_Origens()) { %>
                                        <div class=" radio-inline">
                                            <label>
                                                <input onclick="apmostrar();
                                                        vrocular();" type="radio" name="tipoRadios" id="tipoRadios" value="<%out.print(r.getId()); %>" >
                                                <% out.print(r.getNome()); %>
                                            </label>

                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                                <!-- á vista e a prazo -->
                                <div class="col-lg-4">
                                    <div id="ap" class="callout callout-info" hidden="true" style="font-size: 19px">
                                        <h2>Á vista/A prazo</h3>
                                            <div class="radio-inline">
                                                <label >
                                                    <input onclick="vrocular();" type="radio" name="apRadios" id="apRadios" value="1">
                                                    Á vista/Debito
                                                </label>
                                            </div>
                                            <div class="radio-inline">
                                                <label>
                                                    <input onclick="vrmostrar();" type="radio" name="apRadios" id="apRadios" value="2">
                                                    A prazo/Credito
                                                </label>

                                            </div>
                                    </div>
                                </div>
                                <!--Se foi recebio ou não -->
                                <div class="col-lg-3">
                                    <div id="vr" class="callout callout-warning" hidden="true" style="font-size: 19px">
                                        <h2>Recebido/Vendido</h2>
                                        <div class="radio-inline">
                                            <label>
                                                <input type="radio" name="vrRadios" id="vrRadios" value="1">
                                                Recebido
                                            </label>
                                        </div>
                                        <div class="radio-inline">
                                            <label>
                                                <input type="radio" name="vrRadios" id="vrRadios" value="2">
                                                Vendido
                                            </label>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <p id="edt"></p>
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
                            <button type="button"  id="edsalvar"  class="btn btn-primary">Salvar</button>
                        </form>
                       <!-- modal editar -->
                       <div class="modal fade" id="modal-editar-receita" role="dialog"   aria-labelledby="myModalLabel">
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
                       <!-- model editar fechar -->
                        <%@include file="/partes/javascript.jsp" %> 

                        <div id="conteudo">
                            <%@include file="ultimas-receitas.jsp" %> 

                        </div>     
                    </div>
                </div>


            </div>
            <!-- #Fecha Conteúdo -->

            <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
            <%@include file="/partes/rodape.jsp" %> 
            <!-- #Fecha rodapé -->

        </div>
        <!-- js -->
        <script>
            $('#edsalvar').click(function(event) {
                var tipoRadios = $("input[name='tipoRadios']:checked").val();
                var apRadios = $("input[name='apRadios']:checked").val();
                var vrRadios = $("input[name='vrRadios']:checked").val();

                var valor = $('#valor').val();
                var data = $('#ddata').val();
                var desc = $('#desc').val();
                $.post('SvReceita', {
                    tipoRadios: tipoRadios,
                    apRadios: apRadios,
                    vrRadios: vrRadios,
                    valor: valor,
                    data: data,
                    desc: desc,
                    t: 'add'
                }, function(responseText) {


                    $("#edt").slideDown("slow");
                    carregar();
                    $('#edt').html(responseText);
                    setTimeout("ocultar()", 5000);
                    

                });

            });

            function ocultar() {
                $("#edt").slideUp("slow");
            }
            //á vista e a prazo 
            function apmostrar() {

                $("#ap").slideDown();
                $("#apRadios").prop('checked', true);
                $("#vrRadios").prop('checked', true);
            }
            function apocular() {
                $("#ap").slideUp();
            }
            // vendido e recebido
            function vrmostrar() {
                $("#vr").slideDown();
                $("#vrRadios").prop('checked', true);
            }
            function vrocular() {
                $("#vr").slideUp();
            }
            function carregar() {
                $("#conteudo").load('ultimas-receitas.jsp');

            }
            //maskaras
            $("#valor").maskMoney({
                symbol: '',
                showSymbol: true,
                thousands: '.',
                decimal: ',',
                symbolStay: true
            });
            $('#ddata').datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
                language: 'pt-BR',
                weekStart: 0
            });


        </script>

    </body>
</html>

