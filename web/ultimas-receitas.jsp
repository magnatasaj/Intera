<%@page import="com.interativaconsultoria.objetos.Receita"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.funcao.Data"%>
<%@page import="com.interativaconsultoria.objetos.Despesa"%>
<%@page import="com.interativaconsultoria.dao.DaoReceita"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="java.util.List"%>
<% DaoReceita ObDaoReceita = new DaoReceita();
    request.setCharacterEncoding("UTF-8");    %>


<!--------- tabela ------>
<h1> Últimas entradas do mês</h1>
<table id="tbniveis" cellspacing="0" width="100%" class="table table-bordered table-hover dataTable" role="grid" >


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
        <th id="tt"></th>
        <th><--Total</th>
    </tr>
</tfoot>
<tbody>
    <% List<Receita> ls = ObDaoReceita.Consultar_Receita_mes_atual();
        BigDecimal total = new BigDecimal("0");
        for (Receita d : ls) {
            total = total.add(d.getValor());

    %>  
    <tr>
        <td><% out.print(Valor.FormatarValor(d.getValor())); %></td>
        <td><% out.print(Data.MudarFormatoDeData(d.getData())); %></td>
        <td><% out.print(d.getDescricao()); %></td>
        <td><% out.print(d.getReceita_origem().getNome()); %></td>
        <td><% out.print(d.getDebito_credito_st()); %></td>
        <td><% out.print(d.getVendido_recebido_st()); %></td>

        <td><a href="#modal-editar-receita" onclick='valores(<% out.print(d.getId());%>,<% out.print(d.getDebito_credito()); %>,<% out.print(d.getReceita_origem().getId()); %>,<% out.print(d.getData()); %>, "<% out.print(d.getDescricao()); %>")' data-toggle="modal" data-target="#modal-editar-receita">editar</a></td>


    </tr>


    <% };%>

</tbody>
</table>


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
                        <input type="hidden" class="form-control" id="idnivel">

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

<!-- #Fecha js-->
<script>

    $(document).ready(function() {
        $('#tbniveis').DataTable({
            "paging": true,
            "lengthChange": true,
            "searching": true,
            "ordering": true,
            "order": [[2, 'desc']],
            "info": true,
            "autoWidth": true,
            dom: 'Bfrtip',
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
        })








        function adddata(v) {
            $('.form-control').val(v);
            $('.form-control').focus();

        }
    })
</script>
</body>
</html>

