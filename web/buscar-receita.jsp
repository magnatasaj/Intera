<%@page import="com.interativaconsultoria.objetos.ReceitaOrigem"%>
<%@page import="com.interativaconsultoria.dao.DaoReceitaOrigem"%>
<%@page import="com.interativaconsultoria.objetos.Receita"%>
<%@page import="com.interativaconsultoria.dao.DaoReceita"%>
<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.funcao.Data"%>
<%@page import="com.interativaconsultoria.objetos.Despesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% DaoReceita ObDaoReceita = new DaoReceita(); %>
<% DaoReceitaOrigem ObDaoReceitaOrigem = new DaoReceitaOrigem(); %>

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
                <div class="box bg-green-gradient">
                    <div class="box-header with-border"  style="color: #fff">
                        <h1 class="box-title">Buscar Receita</h1>
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
                                <label for="valor" class="control-label">Valor R$:</label>
                                <div class="input-group">
                                    <span class="input-group-addon">R$</span>
                                    <input onclick="radio(0);"  class="form-control" name="valor" id="valor" autofocus>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <input onclick="radio(1);" type="text"  class="form-control pull-right" name="ddata" id="ddata">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="des" class="control-label">Descrição da Receita:</label>
                                <div>

                                    <textarea onclick="radio(2);" rows="5"  class="form-control" name="desc" id="desc"></textarea>

                                </div>

                            </div>
                            <div class="form-group">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="1" checked="true">
                                        Buscar por valor:
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="2">
                                        Buscar por data:
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios" value="3" >
                                        Buscar por Descrição:
                                    </label>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <button type="submit"  id="buscar"  class="btn btn-primary">Buscar receita</button>

                        </form>

                    </div>
                </div>
                <div class="box">
                    <table id="tbniveis" cellspacing="0" width="100%" class="table table-bordered table-striped" >


                        <thead>
                        <th class="sorting">Valor</th>
                        <th class="sorting">Data</th>
                        <th class="sorting">Descrição</th>
                        <th class="sorting">For / pagamento</th>
                        <th class="sorting">Av ou Ap</th>
                        <th class="sorting">Vendi/Recebido</th>
                        <th class="sorting">Editar</th>

                        </thead>
                        <tfoot>
                            <tr>
                                
                                <th><span id="tt"></span> <--Total</th>
                            </tr>
                        </tfoot>
                        <tbody>
                            <%
                                String v = request.getParameter("valor") != null ? request.getParameter("valor") : "falso";
                                String data = request.getParameter("ddata") != null ? request.getParameter("ddata") : "falso";
                                String desc = request.getParameter("desc") != null ? request.getParameter("desc") : "falso";
                                String op = request.getParameter("optionsRadios") != null ? request.getParameter("optionsRadios") : "falso";
                                List<Receita> ls = new ArrayList();

                                if (op.equals("1") && !v.equals("falso")) {
                                    ls = ObDaoReceita.Consultar_Receita_all(v.trim(), 1);
                                }
                                if (op.equals("2") && !data.equals("falso")) {
                                    ls = ObDaoReceita.Consultar_Receita_all(data, 2);
                                }
                                if (op.equals("3") && !desc.equals("falso")) {
                                    ls = ObDaoReceita.Consultar_Receita_all(desc, 3);
                                }
                                ls = (List) ls;
                                BigDecimal total = new BigDecimal("0");

                                for (Receita d : ls) {

                                    total = total.add(d.getValor());

                            %>  
                            <tr>
                                <td><% out.print(Valor.FormatarValor(d.getValor())); %></td>
                                <td><% out.print(Data.MudarFormatoDeData(d.getData())); %></td>
                                <td id="tb<% out.print(d.getId()); %>"><% out.print(d.getDescricao()); %></td>
                                <td><% out.print(d.getReceita_origem().getNome()); %></td>
                                <td><% out.print(d.getDebito_credito_st(d.getDebito_credito())); %></td>
                                <td><% out.print(d.getVendido_recebido_st(d.getVendido_recebido())); %></td>

                                <td><a href="#modal-editar-receita" onclick='valores("<% out.print(d.getId());%>", "<% out.print(d.getDebito_credito()); %>", "<% out.print(d.getVendido_recebido()); %>", "<% out.print(d.getReceita_origem().getId()); %>", "<% out.print(Data.MudarFormatoDeData(d.getData())); %>", "", "<% out.print(Valor.FormatarValor(d.getValor()).replace("R$", "").trim()); %>")' data-toggle="modal" data-target="#modal-editar-receita">editar</a></td>


                            </tr>


                            <% };%>

                        </tbody>


                    </table>
                </div>
                <!-- modal editar -------------------------------------------------------------------------------------->
                <div class="modal fade" id="modal-editar-receita" role="dialog"   aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <a href="#" target="_blank" id="edhistorico"><button type="button"   name="edfistorico" class="btn btn-adn">Histórico de Entrada</button></a>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                <p id="re"></p>

                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <input type="hidden" class="form-control" id="edid">

                                    </div>
                                    <!-- Tipo de entrada-->
                                    <div class="row">
                                        <div id="tipo" class="callout callout-success"  style="font-size: 19px;">
                                            <h2>Formas de pagamento</h2>

                                            <%  for (ReceitaOrigem r : ObDaoReceitaOrigem.Consultar_Todas_Origens()) { %>
                                            <div class=" radio-inline">
                                                <label>
                                                    <input  type="radio" name="edtipoRadios" id="edtipoRadios" value="<%out.print(r.getId()); %>" >
                                                    <% out.print(r.getNome()); %>
                                                </label>

                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                    <!-- á vista e a prazo -->
                                    <div class="row">
                                        <div id="ap" class="callout callout-info"  style="font-size: 19px">
                                            <h2>Á vista/A prazo</h3>
                                                <div class="radio-inline">
                                                    <label >
                                                        <input  type="radio" name="edapRadios" id="edapRadios" value="1">
                                                        Á vista/Debito
                                                    </label>
                                                </div>
                                                <div class="radio-inline">
                                                    <label>
                                                        <input type="radio" name="edapRadios" id="edapRadios" value="2">
                                                        A prazo/Credito
                                                    </label>

                                                </div>
                                        </div>
                                    </div>
                                    <!--Se foi recebio ou não -->
                                    <div class="row">
                                        <div id="vr" class="callout callout-warning"  style="font-size: 19px">
                                            <h2>Recebido/Vendido</h2>
                                            <div class="radio-inline">
                                                <label>
                                                    <input type="radio" name="edvrRadios" id="edvrRadios" value="1">
                                                    Recebido
                                                </label>
                                            </div>
                                            <div class="radio-inline">
                                                <label>
                                                    <input type="radio" name="edvrRadios" id="edvrRadios" value="2">
                                                    Vendido
                                                </label>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="valor" class="control-label">Valor R$:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon">R$</span>
                                            <input  class="form-control" name="edvalor" id="edvalor" autofocus>
                                        </div>
                                    </div>
                                    <div class="form-group">

                                        <label for="eddata" class="control-label">Data:</label>

                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <input type="text"  class="form-control pull-right" id="eddata">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="des" class="control-label">Descrição da despesa:</label>
                                        <div>

                                            <textarea rows="5"  class="form-control" name="eddesc" id="eddesc"></textarea>

                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <div class="col-lg-1">
                                    <button type="button" id="edexcluir" name="edexcluir" class="btn btn-danger">Excluir</button>
                                </div>

                                <button type="button"  id="edsalvar" name="edsalvar" class="btn btn-primary">Salvar alterações</button>

                                <button type="button" id="edfecha"  class="btn btn-default" data-dismiss="modal">Fecha</button>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- modal editar  fecha-------------------------------------------------------------------------------------->

            </div>
            <!-- #Fecha Conteúdo -->

            <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
            <%@include file="/partes/rodape.jsp" %> 
            <!-- #Fecha rodapé -->

        </div>
        <!-- js -->
        <%@include file="/partes/javascript.jsp" %> 

        <!-- #Fecha js-->
        <script>

            function valida()
            {
                if (document.getElementById("valor").value === "" && document.getElementById("desc").value === "" && document.getElementById("ddata").value === "")
                {
                    alert("Não é possivel fazer uma busca com todos os campos vazios");
                    return false;
                } else {
                    return true;

                }
            }

            function radio(v) {
                var radios = document.getElementsByName("optionsRadios");

                radios[v].checked = true;
            }

            function valores(id, db, vr, or, data, desc, valor) {
                $("#edid").val(id);
                $("input[name='edtipoRadios'][value='" + or + "']").prop("checked", true);
                $("input[name='edapRadios'][value='" + db + "']").prop("checked", true);
                $("input[name='edvrRadios'][value='" + vr + "']").prop("checked", true);

                $('#edvalor').val(valor);
                $('#eddata').val(data);
                $('#eddesc').val($('#tb'+id).text());

            }
            ;

            $('#edsalvar').click(function(event) {
                var id = $('#edid').val();
                var tipoRadios = $("input[name='edtipoRadios']:checked").val();
                var apRadios = $("input[name='edapRadios']:checked").val();
                var vrRadios = $("input[name='edvrRadios']:checked").val();

                var valor = $('#edvalor').val();
                var data = $('#eddata').val();
                var desc = $('#eddesc').val();
                $.post('SvReceita', {
                    id: id,
                    tipoRadios: tipoRadios,
                    apRadios: apRadios,
                    vrRadios: vrRadios,
                    valor: valor,
                    data: data,
                    desc: desc,
                    t: 'edd'
                }, function(responseText) {


                    $("#re").slideDown("slow");
                    $('#re').html(responseText);
                    setTimeout("ocultar()", 5000);

                });
            });



            $('#edexcluir').click(function(event) {
                var id = $('#edid').val();

                $.post('SvReceita', {
                    id: id,
                    t: 'exc'
                }, function(responseText) {

                    $('#re').html(responseText);
                    $("#re").slideDown("slow");
                    setTimeout("ocultar()", 5000);
                    carregar();
                    $('#edvalor').val('');
                    $('#eddata').val('');
                    $('#eddesc').val('');

                });
            })

            function ocultar() {
                $("#edt").slideUp("slow");
            }
            ;


            $('#modal-editar-receita').on('hidden.bs.modal', function() {

                window.setTimeout('location.reload()', 10);
                location.hash = hash;
            });
            $("#valor2").maskMoney({
                symbol: '',
                showSymbol: true,
                thousands: '.',
                decimal: ',',
                symbolStay: true
            });
            $("#valor").maskMoney({
                symbol: '',
                showSymbol: true,
                thousands: '.',
                decimal: ',',
                symbolStay: true

            });



            $('#tbniveis').DataTable({
                "paging": true,
                "scrollX": true,
                "lengthChange": true,
                "searching": true,
                 "language": {
            "decimal": ",",
            "thousands": "."
        },
        "columnDefs": [
                 { type: "date-br", targets: 1 }
        
               ],
                "ordering": true,
                "info": true,
                "autoWidth": true,"oLanguage": {
                    "sEmptyTable": "Nenhum registro encontrado",
    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
    "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
    "sInfoFiltered": "(Filtrados de _MAX_ registros)",
    "sInfoPostFix": "",
    "sInfoThousands": ".",
    "sLengthMenu": "_MENU_ resultados por página",
    "sLoadingRecords": "Carregando...",
    "sProcessing": "Processando...",
    "sZeroRecords": "Nenhum registro encontrado",
    "sSearch": "Pesquisar",
    "oPaginate": {
        "sNext": "Próximo",
        "sPrevious": "Anterior",
        "sFirst": "Primeiro",
        "sLast": "Último"
    },
    "oAria": {
        "sSortAscending": ": Ordenar colunas de forma ascendente",
        "sSortDescending": ": Ordenar colunas de forma descendente"
    }},
                
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
                ],
                drawCallback: function() {
                    var api = this.api();
                    $('#tt').html(
                            "R$ " + api.column(0, {page: 'current'}).data().sum()
                            );
                }
            });


            $('#ddata').daterangepicker({
                      autoUpdateInput: false,
                          	language: 'pt-BR',

                locale: {
                    format: 'DD/MM/YYYY'
                }
                

            });
          
            $('#ddata').on('apply.daterangepicker', function(ev, picker) {
                $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
            });

            $('#ddata').on('cancel.daterangepicker', function(ev, picker) {
                $(this).val('');
            });

            $('#ddata2').datepicker({
                autoclose: true,
                format: 'dd/mm/yyyy',
                language: 'pt-BR',
                weekStart: 0
                });



        </script>
    </body>
</html>

