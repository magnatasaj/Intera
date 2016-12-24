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


<!--------- tabela ------------------------------------------------------------------------------------------------------------------->
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
        <td><% out.print(d.getDebito_credito_st(d.getDebito_credito())); %></td>
        <td><% out.print(d.getVendido_recebido_st(d.getVendido_recebido())); %></td>

        <td><a href="#modal-editar-receita" onclick='valores("<% out.print(d.getId());%>","<% out.print(d.getDebito_credito()); %>","<% out.print(d.getVendido_recebido()); %>","<% out.print(d.getReceita_origem().getId()); %>","<% out.print(Data.MudarFormatoDeData(d.getData())); %>", "<% out.print(d.getDescricao()); %>","<% out.print(Valor.FormatarValor(d.getValor()).replace("R$", "").trim()); %>")' data-toggle="modal" data-target="#modal-editar-receita">editar</a></td>


    </tr>


    <% };%>

</tbody>
</table>




<!-- #Fecha js-->
<script>

    $(document).ready(function() {
        
        
        $('#tbniveis').DataTable({
            "ordering": true,
            "order": [[2, 'desc']],
            "autoWidth": true,
            "lengthMenu": [[10, 25, 50,100, -1], [10, 25, 50,100, "Todos"]],
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
        })


        




        function adddata(v) {
            $('.form-control').val(v);
            $('.form-control').focus();

        }
    })
</script>
</body>
</html>
<% ObDaoReceita.fechar(); %>
