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
<% DaoDespesa ObDaoDespesa = new DaoDespesa();%>


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
                            <h3>Tipo:</h3>
                            <div class="form-group bg-olive ">
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="1" checked="true">
                                        Dinheiro
                                    </label>
                                </div>
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="2">
                                        Cheque
                                    </label>

                                </div>
                                <div class=" radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="3" >
                                        Cartão
                                    </label>

                                </div>
                                <div class=" radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="4" >
                                        Promissória
                                    </label>

                                </div>
                            </div>
                            <h3>Vendido/Recebido</h3>
                            <div class="form-group bg-olive ">
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="1" checked="true">
                                        Vendido
                                    </label>
                                </div>
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="2">
                                        Recebido
                                    </label>

                                </div>
                            </div>
                            <h3>Á vista/A prazo</h3>
                            <div class="form-group bg-olive ">
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="1" checked="true">
                                        Á vista/Debito
                                    </label>
                                </div>
                                <div class="radio-inline">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="2">
                                        A prazo/Credito
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
                            <div class="clearfix"></div>
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

    </body>
</html>

