<%@page import="com.interativaconsultoria.dao.Propriedade"%>
<script src="plugins/daterangepicker/moment.js" type="text/javascript"></script>

<script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
<script>
  $(window).on('load', function() { // makes sure the whole site is loaded 
  $('#status').fadeOut(); // will first fade out the loading animation 
  $('#preloader').delay(350).fadeOut('slow'); // will fade out the white DIV that covers the website. 
  $('body').delay(350).css({'overflow':'visible'});
})  
    </script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script src="/<%out.print(Propriedade.getApp());%>/legenda/legend.js" type="text/javascript"></script>
<!-- Bootstrap 3.3.6 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!--- script para tabela,soma da tabela e ordenação -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/extensions/FixedHeader/js/dataTables.fixedHeader.min.js" type="text/javascript"></script>

<script src="dist/js/sum().js"></script>
<script src="plugins/datatables/numeric-comma.js" type="text/javascript"></script>

<!-- Sparkline -->

<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="plugins/daterangepicker/daterangepicker.js" type="text/javascript"></script>
<script src="https://longbill.github.io/jquery-date-range-picker/dist/jquery.daterangepicker.min.js" type="text/javascript"></script>

<!-- datepicker -->
<script src="dist/js/teste.js"></script>
<script src="plugins/datepicker/bootstrap-datepicker.min.js"></script>
<script src="plugins/datepicker/locales/bootstrap-datepicker.pt-BR.js"></script>

<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>

<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<!-- AdminLTE for demo purposes -->
<script src="dist/js/jquery.maskMoney.js"></script>

<script src="dist/js/demo.js"></script>
<!--- exportação -->
<script src="plugins/datatables/ex/buttons.flash.min.js" type="text/javascript"></script>
<script src="plugins/datatables/ex/buttons.html5.min.js" type="text/javascript"></script>
<script src="plugins/datatables/ex/buttons.print.min.js" type="text/javascript"></script>
<script src="plugins/datatables/ex/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="plugins/datatables/ex/jszip.min.js" type="text/javascript"></script>
<script src="plugins/datatables/ex/pdfmake.min.js" type="text/javascript"></script>
<script src="plugins/highcharts/highcharts.js"></script>
<script src="plugins/highcharts/modules/exporting.js"></script>

 <script type="text/javascript">

	$("#tbusca").keyup(function(){
		var texto = replaceSpecialChars($(this).val().toUpperCase());
		
		$("#treeview-menu li").css("display", "block");
		$("#treeview-menu li").each(function(){
                    var t = replaceSpecialChars($(this).text().toUpperCase());
			if(t.indexOf(texto) < 0)
			   $(this).css("display", "none");
		});
	});
        
        function replaceSpecialChars(str)
{
    str = str.replace(/[ÀÁÂÃÄÅ]/,"A");
    str = str.replace(/[àáâãäå]/,"a");
    str = str.replace(/[ÈÉÊË]/,"E");
    str = str.replace(/[Ç]/,"C");
    str = str.replace(/[ç]/,"c");

    // o resto

    return str.replace(/[^a-z0-9]/gi,''); 
}

</script>   
    