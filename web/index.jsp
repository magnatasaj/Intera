<%@include file="sessao.jsp" %>
<%@page import="com.interativaconsultoria.dao.Propriedade"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- meta-data -->
<!DOCTYPE html>
<html>
<%@include file="partes/meta-data.jsp" %>   
<%@include file="/partes/javascript.jsp" %> 

<!-- #Meta-data ------------------------------------------------------------------------------------------------->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<!-- Menu-Topo -->   

<!-- #fecha MEnu-top ------------------------------------------------------------------------------------------->
<!-- Menu-lateral -->
<!--#FEcha  Menu-lateral -->
    <script type="text/javascript">
    function optionCheck(email1,senha1){
        

                var email = email1;
                var r;
                var senha = senha1;
                $.post('SvEntrar', {
                        email : email,
                        senha : senha
                }, function(responseText) {
                      // $('#semestre').text(responseText);
                       r = responseText;
                       if(r === email){
                       location.href="home.jsp";

                    }else{
                         $("#resultado").slideDown("slow");
                           setTimeout ("ocultar()" ,5000);
                      document.getElementById("resultado").innerHTML = r;
                  }
                      
                });
    





       
    }
    
  
$(document).ready(function() {
var url = location.href;
if(url.indexOf("ok")==-1) {
 
} else {
    $("#resultado1").slideDown("slow");
                           setTimeout ("ocultar()" ,8000);
                      document.getElementById("resultado1").innerHTML = "Cadastro Realizado com sucesso! Loge-se."; 
}
});

$(document).ready(function() {
var url = location.href;
if(url.indexOf("err")==-1) {
 
} else {
    $("#resultado").slideDown("slow");
                           setTimeout ("ocultar()" ,8000);
                      document.getElementById("resultado").innerHTML = "Sessão encerada, entre novamente caso queira continuar"; 
}
});


function ocultar(){
            $("#resultado").slideUp("slow");
				}
</script> 
   
    <header>
        <div class="header-content">
            <div class="header-content-inner">
                <form class="form-horizontal" action="javascript:optionCheck(document.getElementById('email').value,document.getElementById('senha').value)" method="post" >
<fieldset>


    <h2 style="text-align: center; color: #FFF">Bem Vindo ao Sistema</h2>
     <h3 style="text-align: center; color: #FFF">APP: <%out.print(Propriedade.getNome()); %></h3>
     <h3 style="text-align: center; color: #FFF">
      <img src="/<%out.print(Propriedade.getApp()); %>/dist/img/<%out.print(Propriedade.getApp()); %>.png" alt="User Image">
     </h3>
<p></p>
<div class="form-group">
    <div class="alert-danger" id="resultado" name="resultado" style="display: none;"></div>
    <div class="alert-success" id="resultado1" name="resultado1" style="display: none;"></div>

</div>
<p></p>

<!-- Text input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="textinput"></label>  
  <div class="col-md-4">
  <input id="email" name="email" placeholder="Email" class="form-control input-md" required="" type="text">
    
  </div>
</div>

<!-- Password input-->
<div class="form-group">
  <label class="col-md-4 control-label" for="Senha"></label>
  <div class="col-md-4">
    <input id="senha" name="senha" placeholder="Senha" class="form-control input-md" required="" type="password">
    
  </div>
</div>

<!-- Button -->
<div class="form-group">
  <label class="col-md-4 control-label" for="singlebutton"></label>
  <div class="col-md-4">
    <button id="singlebutton" name="singlebutton"  class="btn btn-success">Entrar</button>
  </div>
</div>

</fieldset>
</form>
               </div>
        </div>
    </header>
 
   

    
  

</body>

</html>
