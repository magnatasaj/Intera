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
      <div class="fundo">
          
      </div>    

  </div>
<!-- #Fecha Conteúdo -->

<!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
<div class="clearfix"></div>
<%@include file="/partes/rodape.jsp" %> 
<!-- #Fecha rodapé -->
  
</div>

<!-- js -->

<!-- #Fecha js-->
</body>
</html>

<%@include file="/partes/javascript.jsp" %> 
<% System.gc(); %>