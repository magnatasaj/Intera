<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.funcao.Data"%>
<%@page import="com.interativaconsultoria.objetos.Despesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<% DaoDespesa ObDaoDespesa = new DaoDespesa();
    request.setCharacterEncoding("UTF-8");    %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- meta-data -->
<!DOCTYPE html>
<html>
    <%@ include file="partes/meta-data.jsp" %>    
    <!-- #Meta-data ------------------------------------------------------------------------------------------------->
    <body class="hold-transition skin-blue sidebar-mini">
        <div class="wrapper">
            <!-- Menu-Topo -->   
            <%@include file="partes/menu-topo.jsp" %>    

            <!-- #fecha MEnu-top ------------------------------------------------------------------------------------------->
            <!-- Menu-lateral -->
            <%@include file="/partes/menu-lateral.jsp"%> 
            <!--#FEcha  Menu-lateral -->

            <!-- Conteúdo ------------------------------------------------------------------------------------------------->
            <div class="content-wrapper">
                <div class="box">
                    <div class="box-header with-border">
                        <h3 > Histórico da categoria: <b><% out.print(request.getParameter("nome").toUpperCase());%></b></h3>
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
                        <div class="box">
                            <h4>Escolha o mês e aperte [ENTER]</h4>
                            <%Calendar cal = GregorianCalendar.getInstance();   %>
                            <button type="button" onclick="adddata('01/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Jan</button>
                            <button type="button" onclick="adddata('02/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Fev</button>
                            <button type="button" onclick="adddata('03/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Mar</button>
                            <button type="button" onclick="adddata('04/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Abr</button>
                            <button type="button" onclick="adddata('05/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Mai</button>
                            <button type="button" onclick="adddata('06/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Jun</button>
                            <button type="button" onclick="adddata('07/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Jul</button>
                            <button type="button" onclick="adddata('08/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Ago</button>
                            <button type="button" onclick="adddata('09/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Set</button>
                            <button type="button" onclick="adddata('10/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Out</button>
                            <button type="button" onclick="adddata('11/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Nov</button>
                            <button type="button" onclick="adddata('12/<% out.print(cal.get(Calendar.YEAR));%>')"   id="mes" name="mes" class="btn btn-primary">Dez</button>
                        </div>
                        <!--------- tabela ------>

                        <table id="tbniveis" cellspacing="0" width="100%" class="table table-bordered table-striped" >


                            <thead>
                            <th>Valor</th><th>Data</th><th>Descrição</th><th>Editar</th>

                            </thead>
                            <tfoot>
                                <tr>
                                    <th id="tt"></th>
                                    <th><--Total</th>
                                </tr>
                            </tfoot>
                            <tbody>
                                <% List<Despesa> ls = ObDaoDespesa.Consultar_Despesa_pelo_nivel(Integer.parseInt(request.getParameter("id")));
                                    BigDecimal total = new BigDecimal("0");
                                    for (Despesa d : ls) {
                                        total = total.add(d.getValor());

                                %>  
                                <tr>
                                    <td><% out.print(Valor.FormatarValor(d.getValor())); %></td>
                                    <td><% out.print(Data.MudarFormatoDeData(d.getData())); %></td>
                                    <td><% out.print(d.getDescricao()); %></td>
                                    <td><button class="btn btn-flat" id="<% out.print(d.getId());%>" data-id="<% out.print(d.getId());%>" data-valor="<% out.print(Valor.FormatarValor(d.getValor()).replace("R$", ""));%>"  data-data="<% out.print(Data.MudarFormatoDeData(d.getData()));%>" data-descricao="<% out.print(d.getDescricao()); %>"   data-toggle="modal" data-target="#modal-editar-despesa" ><b class="fa fa-pencil-square"></b></button></td>


                                </tr>


                                <% };%>

                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Modal editar -->
                <div class="modal fade" id="modal-editar-despesa" role="dialog"   aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                <p id="edt"></p>

                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <input type="hidden"  id="idnivel">

                                    </div>
                                    <div class="form-group">
                                        <label for="valor" class="control-label">Valor R$:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon">R$</span>
                                            <input class="form-control" name="valor" id="valor" autofocus></input>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="input-group date">
                                            <div class="input-group-addon">
                                                <i class="fa fa-calendar"></i>
                                            </div>
                                            <input type="text" class="form-control pull-right" id="ddata">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="des" class="control-label">Descrição da despesa:</label>
                                        <div>

                                            <textarea rows="5" class="form-control" name="desc" id="desc"></textarea>

                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <div class="col-lg-1">
                                </div>
                                <div class="col-lg-1">
                                    <button type="button"  id="edexcluir" name="edexcluir" class="btn btn-danger">Excluir</button>
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


            //da entrada em uma despesa

            $('#modal-editar-despesa').one('show.bs.modal', function(event) {
                var button = $(event.relatedTarget)

                var id = button.data('id')
                var data = button.data('data')
                var valor = button.data('valor')
                var de = button.data('descricao')
                var modal = $(this)
                modal.find('.modal-title').text('Editar item')
                modal.find('#idnivel').val(id);
                modal.find('#ddata').val(data);
                modal.find('#desc').val(de);

                $('#valor').val(valor);
                $('#valor').focus()
            });


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
                    t: 'edd'
                }, function(responseText) {


                    $("#edt").slideDown("slow");

                    $('#edt').html(responseText);
                    setTimeout('ocultar()', 5000);
                });

            })

            function ocultar() {
                $("#edt").slideUp("slow");
            }


            $('#modal-editar-despesa').on('hidden.bs.modal', function() {
                var id = $('#edid').val();

                window.setTimeout('location.reload()', 10);
                location.hash = hash;
            })

            $('#edexcluir').click(function(event) {
                var id = $('#idnivel').val();

                $.post('SvDespesas', {
                    id: id,
                    t: 'exc'
                }, function(responseText) {
                    $('#edt').html(responseText);
                    $('#valor').val("");
                    $('#ddata').val("");
                    $('#desc').val("");

                });
            })

            $("#valor").maskMoney({symbol: '',
                showSymbol: true, thousands: '.', decimal: ',', symbolStay: true});




        </script>    
        <!-- #Fecha js-->
        <script>

            $(document).ready(function() {
                $('#tbniveis').DataTable({
                    "paging": true,
                    "scrollX": true,
                    "lengthChange": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "autoWidth": true,
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






                $('#ddata').datepicker({
                    autoclose: true,
                    format: 'dd/mm/yyyy',
                    language: 'pt-BR',
                    weekStart: 0


                });

            });
            function adddata(v) {
                $('#bb').val(v);
                $('#bb').focus();

            }
            ;
        </script>
    </body>
</html>
<% ObDaoDespesa.fechar(); %>

