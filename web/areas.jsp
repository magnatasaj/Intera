<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<% DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel();%>



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
                        <h1 class="box-title">Níveis Hierárquicos de Despesas</h1>
                        <div class="row">
                            <div class="col-lg-3" style="margin: 10px" >   
                                <button class="btn btn-block btn-primary btn-primary" data-toggle="modal" data-target="#modal-salvar-pai" >Adicionar área</button>
                            </div>
                        </div>
                        <div class="box-tools pull-right">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse" data-toggle="tooltip" title="Collapse">
                                <i class="fa fa-minus"></i></button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove" data-toggle="tooltip" title="Remove">
                                <i class="fa fa-times"></i></button>
                        </div>
                        <!--------- tabela ------>
                        <table id="tbniveis" width="99%" class="table table-bordered " >


                            <thead>
                            <th style="width: 5px">Edd</th><th  style="width: 1px">Ordem</th><th>Nome</th><th>Pertence</th><th style="width: 1px">Add</th>

                            </thead>
                            <tbody>
                                <% List<Despesa_Niveis> ls = ObDaoDespesaNivel.Consultar_Todos_Nivel();
                                    for(Despesa_Niveis d : ls){
                                        if(d.getPai() == 0){  
                                %>  
                                <tr <% if(d.getPai() == 0){out.print("style='background-color:#3c8dbc; color:#FFF'");}; %>>
                                    <td><button class="btn btn-primary" id="<% out.print(d.getId());%>" data-id="<% out.print(d.getId());%>" data-nome="<% out.print(d.getNome());%>" data-pai="<% out.print(d.getPai());%>" data-ordem="<% out.print(d.getOrdem());%>"  style="background-color:#3c8dbc "  data-toggle="modal" data-target="#modal-editar" ><b class="fa fa-pencil-square"></b></button></td>
                                    <td><b><% out.print(d.getOrdem()); %></b></td>
                                    <td><b><% out.print(d.getNome()); %></b></td>
                                    <td><b></b></td>
                                    <td><button   class="btn btn-primary"  data-nomepai="<% out.print(d.getNome());%>" data-pai="<% out.print(d.getId());%>" data-toggle="modal" data-target="#modal-salvar-nivel1" ><b class="fa fa-plus-square"></b></button></td>


                                </tr>

                                <!-- Consultar nível 2 -->
                                <% 
                                for(Despesa_Niveis d2 : ls){
                                  if(d2.getPai() == d.getId()){  
                                %> 
                                <tr style='background-color:#F0FFFF; color:#000'>
                                    <td><button class="btn btn-file" id="<% out.print(d2.getId());%>" data-id="<% out.print(d2.getId());%>" data-nome="<% out.print(d2.getNome());%>" data-pai="<% out.print(d2.getPai());%>" data-ordem="<% out.print(d2.getOrdem());%>"   data-toggle="modal" data-target="#modal-editar" ><b class="fa fa-pencil-square"></b></button></td>
                                    <td><% out.print(d.getOrdem()+"."+d2.getOrdem()); %></td>
                                    <td><% out.print(d2.getNome()); %></td>
                                    <td><% out.print(d.getNome()); %></td>
                                    <td><button   class="btn btn-primary"  data-nomepai="<% out.print(d2.getNome());%>" data-pai="<% out.print(d2.getId());%>" data-toggle="modal" data-target="#modal-salvar-nivel1" ><b class="fa fa-plus-square"></b></button></td>
                                </tr>
                                <!-- Consultar nivel 3 -->
                                <% 
                                for(Despesa_Niveis d3 : ls){
                                    if(d3.getPai() == d2.getId()){  
                                %> 
                                <tr>
                                    <td><button class="btn btn-flat" id="<% out.print(d3.getId());%>" data-id="<% out.print(d3.getId());%>" data-nome="<% out.print(d3.getNome());%>" data-pai="<% out.print(d3.getPai());%>" data-ordem="<% out.print(d3.getOrdem());%>"    data-toggle="modal" data-target="#modal-editar" ><b class="fa fa-pencil-square"></b></button></td> 
                                    <td>  -><% out.print(d.getOrdem()+"."+d2.getOrdem()+"."+d3.getOrdem()); %></td>
                                    <td>  <% out.print(d3.getNome()); %></td>
                                    <td>  <% out.print(d2.getNome()); %></td>
                                    <td><b class="ti-plus"></b></td>    
                                </tr>

                                <% }}; %>
                                <% }}; %>    

                                <% }}; %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Modal Paisalvar -->
                <div class="modal fade" id="modal-salvar-pai" tabindex="-1" role="dialog" onclose="location.reload();" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                <p id="d"></p>

                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label for="recipient-name" class="control-label">Nome:</label>
                                        <input type="text" class="form-control" id="pnome" name="pnome">
                                    </div>
                                    <div class="form-group">
                                        <label for="Ordem" class="control-label">Ordem:</label>
                                        <input class="form-control" name="pordem" id="pordem"></input>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button"  id="Paisalvar" name="Paisalvar" class="btn btn-primary">Salvar</button>
                                <button type="button"  class="btn btn-default" data-dismiss="modal">Fecha</button>

                            </div>
                        </div>
                    </div>
                </div>
                <!--#fecha Modal Paisalvar -->

                <!-- Modal N1salvar -->
                <div class="modal fade" id="modal-salvar-nivel1" tabindex="-1" role="dialog"   aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                <p id="n1"></p>

                            </div>
                            <div class="modal-body">
                                <form>
                                    <div class="form-group">
                                        <label for="recipient-name" class="control-labe0l">Nome:</label>
                                        <input type="text" class="form-control" id="n1nome" name="nome">
                                        <input type="hidden" class="form-control" id="n1idpai">

                                    </div>
                                    <div class="form-group">
                                        <label for="Ordem" class="control-label">Ordem:</label>
                                        <input class="form-control" name="ordem" id="n1ordem"></input>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button"  id="n1salvar" name="n1salvar" class="btn btn-primary">Salvar</button>
                                <button type="button" id="n1fecha"  class="btn btn-default" data-dismiss="modal">Fecha</button>

                            </div>
                        </div>
                    </div>
                </div>
                <!--#fecha Modal Paisalvar -->

                <!-- Modal editar -->
                <div class="modal fade" id="modal-editar" tabindex="-1" role="dialog"   aria-labelledby="myModalLabel">
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
                                        <label for="recipient-name" class="control-labe0l">Nome:</label>
                                        <input type="text" class="form-control" id="ednome" name="nome">
                                        <input type="hidden" class="form-control" id="edid">

                                    </div>
                                    <div class="form-group">
                                        <label for="Ordem" class="control-label">Ordem:</label>
                                        <input class="form-control" name="ordem" id="edordem"></input>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
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

            //script n1

            //abre modal n1
            $('#modal-salvar-nivel1').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget)
                var idpai = button.data('pai')
                var nomepai = button.data('nomepai')
                var modal = $(this)
                modal.find('.modal-title').text('Área a qual será incluida: ' + nomepai)
                modal.find('#n1idpai').val(idpai);
            })
            //salva n1
            $('#n1salvar').click(function (event) {
                var name = $('#n1nome').val();
                var ordem = $('#n1ordem').val();
                var idpai = $('#n1idpai').val();
                $.post('SvNiveis', {
                    n1nome: name,
                    n1ordem: ordem,
                    n1idpai: idpai,
                    t: 'n1sv'
                }, function (responseText) {
                    $('#n1').html(responseText);
                    $('#n1nome').val(" ")
                    $('#n1ordem').val(" ")

                });
            })
            //Atualiza página fechando modal n1
            $('#modal-salvar-nivel1').on('hidden.bs.modal', function () {
                window.setTimeout('location.reload()', 300);
            })

            //fecha n1



            //script Pai
            $('#modal-salvar-pai').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget)
                var id = button.data('id')
                var modal = $(this)
                modal.find('.modal-title').text('Cadastrar nova Área')
            })

            $('#Paisalvar').click(function (event) {
                var name = $('#pnome').val();
                var ordem = $('#pordem').val();
                $.post('SvNiveis', {
                    nome: name,
                    ordem: ordem,
                    t: 'psv'
                }, function (responseText) {
                    $('#d').html(responseText);
                    $('#pnome').val(" ")
                    $('#pordem').val(" ")

                });
            })
            //Atualiza página fechando modal pai
            $('#modal-salvar-pai').on('hidden.bs.modal', function () {
                var id = $('#edid').val()
                
                window.setTimeout('location.reload()', 10);
                location.hash = hash;
            })
            //fecha pai

            //Editar
            $('#modal-editar').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget)
                var id = button.data('id')
                var nome = button.data('nome')
                var ordem = button.data('ordem')
                var modal = $(this)
                modal.find('.modal-title').text('Item: ' + nome)
                modal.find('#edid').val(id);
                modal.find('#ednome').val(nome);
                modal.find('#edordem').val(ordem);
            })
            
            $('#edsalvar').click(function (event) {
                var id = $('#edid').val();
                var name = $('#ednome').val();
                var ordem = $('#edordem').val();
                $.post('SvNiveis', {
                    id: id,
                    nome: name,
                    ordem: ordem,
                    t: 'edt'
                }, function (responseText) {
                    $('#edt').html(responseText);
                    $('#edid').val(" ")
                    $('#ednome').val(" ")
                    $('#edordem').val(" ")

                });
            })
            //excluir
             $('#edexcluir').click(function (event) {
                var id = $('#edid').val();
                
                $.post('SvNiveis', {
                    id: id,
                    t: 'exc'
                }, function (responseText) {
                    $('#edt').html(responseText);
                    $('#edid').val(" ")
                    $('#ednome').val(" ")
                    $('#edordem').val(" ")

                });
            })
            
            
            $('#modal-editar').on('hidden.bs.modal', function () {
                var id = $('#edid').val()
                
                window.setTimeout('location.reload()', 10);
                location.hash = id;

            })
        
        
 
        </script>    
        <!-- #Fecha js-->
        <script>
  $(function () {
    
    $('#tbniveis').DataTable({
      "paging": false,
      "scrollX": true,
      "lengthChange": true,
      "searching": true,
      "ordering": true,
      "info": true,
      "autoWidth": true
    });
  });
</script>
    </body>
</html>
<% ObDaoDespesaNivel.fechar();%>

