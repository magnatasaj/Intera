<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>

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
                <div class="box bg-green-active">
                    <div class="box-header with-border"  style="color: #fff">
                        <h1 class="box-title">Cadastrar Usúarios</h1>
                        <div class="row">
                            <div class="col-lg-3" style="margin: 10px" >   

                            </div>
                        </div>


                        <form id="form_receita">
                            <!-- Tipo de entrada-->

                            <p id="edt"></p>
                            <div class="form-group">
                                <label for="valor" class="control-label">Nome</label>
                                <div>

                                    <input type="text" class="form-control" name="nome" id="nome" autofocus>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="valor" class="control-label">E-mail:</label>
                                <div>

                                    <input type="text" class="form-control" name="email" id="email" autofocus>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="des" class="control-label">Senha:</label>
                                <div>
                                    <input type="password"  class="form-control" name="senha" id="senha">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="des" class="control-label">Tipo: 1 = Administrador / 2 = Usuário</label>
                                <div>
                                    <input type="text"  class="form-control" name="tipo" id="tipo">
                                </div>
                            </div>

                            <div class="clearfix"></div>
                            <button type="button"  id="salvar"  class="btn btn-primary">Salvar</button>
                        </form>
                        <!-- modal editar -------------------------------------------------------------------------------------->
                        <div class="modal fade" id="modal-editar-usuarios" role="dialog"   aria-labelledby="myModalLabel">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content" style="color: #000">

                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>

                                    <p id="re"></p>


                                    <div class="modal-body">
                                        <form>
                                            <div class="form-group">
                                                <input type="hidden" class="form-control" id="edid">

                                            </div>
                                            <div class="form-group">
                                                <label for="valor" class="control-label">Nome</label>
                                                <div>

                                                    <input type="text" class="form-control" name="ednome" id="ednome" autofocus>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="edemail" class="control-label">E-mail:</label>
                                                <div>

                                                    <input type="text" class="form-control" name="edemail" id="edemail" autofocus>
                                                </div>
                                            </div>                
                                            <div class="form-group">
                                                <label for="des" class="control-label">Senha:</label>
                                                <div>
                                                    <input type="text"  class="form-control" name="edsenha" id="edsenha">
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label for="des" class="control-label">Tipo: 1 = Administrador / 2 = Usuário</label>
                                                <div>
                                                    <input type="text"  class="form-control" name="edtipo" id="edtipo">
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

                        <%@include file="/partes/javascript.jsp" %> 


                    </div>
                </div>
                <div class="box">
                    <div class="box-header with-border">
                        <div id="conteudo">
                            <%@include file="lista-usuarios.jsp" %> 

                        </div>  
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
    <%@include file="/partes/javascript.jsp" %> 

    <!-- #Fecha js-->
</body>
</html>
<script>
    function valores(id, nome, email, senha, tipo) {
        $("#edid").val(id);
        $('#ednome').val(nome);
        $('#edemail').val(email);
        $('#edsenha').val(senha);
        $('#edtipo').val(tipo);

    }

    $('#salvar').click(function(event) {

        var nome = $('#nome').val();
        var email = $('#email').val();
        var senha = $('#senha').val();
        var tipo = $('#tipo').val();
        $.post('SvUser', {
            nome: nome,
            email: email,
            senha: senha,
            tipo: tipo,
            t: 'add'
        }, function(responseText) {


            $("#edt").slideDown("slow");
            carregar();
            $('#edt').html(responseText);
            setTimeout("ocultar()", 5000);
            carregar();

        });

    });

    $('#edsalvar').click(function(event) {
        var id = $('#edid').val();
        var nome = $('#ednome').val();
        var email = $('#edemail').val();
        var senha = $('#edsenha').val();
        var tipo = $('#edtipo').val();
        $.post('SvUser', {
            id: id,
            nome: nome,
            email: email,
            senha: senha,
            tipo: tipo,
            t: 'edd'
        }, function(responseText) {


            $("#re").slideDown("slow");
            $('#re').html(responseText);
            setTimeout("ocultar()", 5000);
            carregar();

        });
    });
    
    
     $('#edexcluir').click(function(event) {
                var id = $('#edid').val();

                $.post('SvUser', {
                    id: id,
                    t: 'exc'
                }, function(responseText) {

                    $('#re').html(responseText);
                    $("#re").slideDown("slow");
                    setTimeout("ocultar()", 5000);
                    carregar();
                    $('#edid').val('');
                    $('#ednome').val('');
                    $('#edemail').val('');
                    $('#edsenha').val('');
                    $('#edtipo').val('');

                });
            });

    function carregar() {
        $("#conteudo").load('lista-usuarios.jsp');

    }
</script>    

