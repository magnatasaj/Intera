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
                        <form>
                            <!-- Tipo de entrada-->

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
                            <!-- á vista e a prazo -->
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
                            <!--Se foi recebio ou não -->
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
                            <div id="conteudo"></div>
                            <div class="clearfix"></div>
                            <button type="submit"  id="buscar"  class="btn btn-primary">Salvar</button>

                        </form>

                    </div>
                </div>

            </div>
            <!-- #Fecha Conteúdo -->

            <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
            <%@include file="/partes/rodape.jsp" %> 
            <!-- #Fecha rodapé -->

        </div>
        <!-- js -->
        <%@include file="/partes/javascript.jsp" %> 
        <script>

            //á vista e a prazo 
            function apmostrar() {

                $("#ap").slideDown();
                $("#apRadios").prop('checked', true);
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
                $("#conteudo").load('base.jsp');
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

