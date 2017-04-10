<%@page import="com.interativaconsultoria.objetos.App"%>
<%@page import="com.interativaconsultoria.objetos.User"%>
<%@page import="com.interativaconsultoria.dao.DaoUser"%>
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
<% App app2 = (App)request.getSession().getAttribute("app");
    DaoReceita ObDaoReceita = new DaoReceita(app2.getPrefixo_tb());
    DaoUser daoUser = new DaoUser(app2.getPrefixo_tb());
    request.setCharacterEncoding("UTF-8");    %>


<!--------- tabela ------------------------------------------------------------------------------------------------------------------->
<h1> Últimas entradas do mês</h1>
<table id="tbniveis" cellspacing="0" width="99%" class="table table-bordered table-hover dataTable" role="grid" >


    <thead>
    <th class="sorting">Id</th>
    <th class="sorting">Nome</th>
    <th class="sorting">E-mail</th>
    <th class="sorting">Senha</th>
    <th class="sorting">Tipo</th>
    <th class="sorting">Editar</th>

</thead>
<tfoot>
    <tr>

    </tr>
</tfoot>
<tbody>
    <% List<User> ls = daoUser.Aluno_Listar();
        for (User d: ls) {

    %>  
    <tr>
        <td><% out.print(d.getId()); %></td>
        <td><% out.print(d.getNome()); %></td>
        <td><% out.print(d.getEmail()); %></td>
        <td><% out.print(d.getSenha()); %></td>
        <td><% out.print(d.getTipo()); %></td>
        <td><a href="#modal-editar-usuarios" onclick='valores("<% out.print(d.getId());%>", "<% out.print(d.getNome()); %>", "<% out.print(d.getEmail()); %>", "<% out.print(d.getSenha()); %>", "<% out.print(d.getTipo()); %>")' data-toggle="modal" data-target="#modal-editar-usuarios">editar</a></td>


    </tr>


    <% };%>

</tbody>
</table>




<!-- #Fecha js-->
<script>

    $(document).ready(function() {
        $('#tbniveis').DataTable({
            "ordering": true,
            "scrollX": true,
            "order": [[2, 'desc']],
            "autoWidth": true,
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







      
    })
</script>
