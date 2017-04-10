
<%@page import="com.interativaconsultoria.objetos.App"%>
<%@include file="/sessao.jsp" %>

<head>
   <%
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setHeader("Expires", "0"); // Proxies.    
   App aa = new App();
   if(request.getSession().getAttribute("app") == null){
       aa.setNome("Sistema financeiro");
   }else{
       aa = (App) request.getSession().getAttribute("app");
   }
   %>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%out.print(aa.getNome()); %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="shortcut icon" href="http://interativaconsultoria.com/wp-content/uploads/2016/03/favicon-16x16.png" />
<link rel="apple-touch-icon" href="http://interativaconsultoria.com/wp-content/uploads/2016/03/favicon-57x57.png" />
<link rel="apple-touch-icon" sizes="114x114" href="http://interativaconsultoria.com/wp-content/uploads/2016/03/favicon-114x114.png" />
<link rel="apple-touch-icon" sizes="72x72" href="http://interativaconsultoria.com/wp-content/uploads/2016/03/favicon-72x72.png" />
<link rel="apple-touch-icon" sizes="144x144" href="http://interativaconsultoria.com/wp-content/uploads/2016/03/favicon-144x144.png" />
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link href="css/demo.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="plugins/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
    <!-- Morris chart -->
    <link rel="stylesheet" href="plugins/morris/morris.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
    <!-- Date Picker -->
    <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker.css">
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link href="plugins/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css"/>
    <link href="plugins/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css"/>
    <link href="plugins/datatables/extensions/FixedHeader/css/dataTables.fixedHeader.min.css" rel="stylesheet" type="text/css"/>
   
    <style>
    body {
  overflow: hidden;
}


/* Preloader */

#preloader {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #fff;
  /* change if the mask should have another color then white */
  z-index: 99;
  /* makes sure it stays on top */
}

#status {
  width: 40px;
  height: 107px;
  position: absolute;
  left: 55%;
  /* centers the loading animation horizontally one the screen */
  top: 50%;
  /* centers the loading animation vertically one the screen */
  background-image: url('../Interativaconsultoria/dist/img/caregador.gif');
  /* path to your loading animation */
  background-position: center;
  margin: -100px 0 0 -100px;
  /* is width and height divided by two */
}    
        </style>
    
</head>
<div id="preloader">
  <div id="status">&nbsp;</div>
</div>
