<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.interativaconsultoria.dao.DaoAno"%>
<%-- 
    Document   : index
    Created on : 25/10/2016, 15:08:38
    Author     : Lamara
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.interativaconsultoria.funcao.Valor"%>
<%@page import="com.interativaconsultoria.funcao.Data"%>
<%@page import="com.interativaconsultoria.objetos.Despesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesa"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% DaoDespesa ObDaoDespesa = new DaoDespesa(); %>
<% DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel(); %>
<%
    Calendar cal = GregorianCalendar.getInstance();
    String ano = "";
    if (request.getParameter("ano") == null) {
        ano = Integer.toString(cal.get(Calendar.YEAR));
    } else {
        ano = request.getParameter("ano");
    }


%>

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
                <div class="box bg-red-active">
                    <div class="box-header with-border">
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
                        <form action="despesa-grafico.jsp" method="get">
                            <h1 class="box-title">Escolha o ano para geração dos gráficos</h1>
                            <select id="ano" name="ano" class="form-control">
                                <option></option>
                                <% DaoAno dano = new DaoAno();
                                    List<Integer> lano = dano.Lista_anos();
                                    for (int an : lano) { %>  
                                <option><% out.println(an); %></option>
                                <% } %>
                            </select>
                            </br>
                            <button type="submit"  id="buscar"  class="btn btn-primary">Alterar Ano</button>

                        </form>
                        </br>

                        <div class="callout callout-info">
                            <h4>Ano base para os gráficos: <% out.print(ano);%></h4>

                        </div>
                    </div>

                </div>
                <!--- Graficos testes -->
                <div class="box" >
                    <div class="box-header" style="height: 100px" >
                        <h3 class="box-title">Anual Despesas</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <div class="box-body">
                        <button onclick="img('barChart')" id="save-btn">Save gráfico como imagem</button>

                        <div class="chart">
                            <div id="barsLegend"></div>
                            <canvas id="barChart"></canvas>


                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header" style="height: 100px" >
                        <h3 class="box-title">Anual por Área 1</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <button onclick="img('barChart1')" id="save-btn">Save gráfico como imagem</button>

                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend1"></div>
                            <canvas id="barChart1"></canvas>

                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header" style="height: 100px" >
                        <h3 class="box-title">Anual por Área 2</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <button onclick="img('barChart2')" id="save-btn">Save gráfico como imagem</button>

                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend2"></div>
                            <canvas id="barChart2"></canvas>

                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header" style="height: 100px" >
                        <h3 class="box-title">Anual por Área 3</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                    <button onclick="img('barChart3')" id="save-btn">Save gráfico como imagem</button>

                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend3"></div>
                            <canvas id="barChart3"></canvas>

                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- fecha gratifo teste -->

                <!-- #Fecha Conteúdo -->

                <!-- Abrir Rodapé -------------------------------------------------------------------------------------------->  
                <%@include file="/partes/rodape.jsp" %> 
                <!-- #Fecha rodapé -->

            </div>
            <!-- js -->
            <%@include file="/partes/javascript.jsp" %> 

            <!-- #Fecha js-->
            <script>


            </script>

            <script>
                        $(function() {

                        //data um
                        var areaChartData = {
                        labels: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
                                datasets: [
                                {
                                label: "Despesas",
                                        fillColor: "rgba(210, 214, 222, 1)",
                                        strokeColor: "rgba(210, 214, 222, 1)",
                                        pointColor: "rgba(210, 214, 222, 1)",
                                        pointStrokeColor: "#c1c7d1",
                                        pointHighlightFill: "#fff",
                                        pointHighlightStroke: "rgba(220,220,220,1)",
                <% out.print("data: [" + ObDaoDespesa.Gerar_Grafico_despesa(ano) + "]");%>
                                }
                                ]
                        };
                                //data um
                                var areaChartData1 = {
                                labels: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
                                        datasets: [<% out.print(ObDaoDespesa.Despesa_Grafico_nivel1(ano));%>]
                                };
                                //data dois
                                var areaChartData2 = {
                                labels: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
                                        datasets: [<% out.print(ObDaoDespesa.Despesa_Grafico_nivel2(ano));%>]
                                };
                                // data três
                                var areaChartData3 = {
                                labels: ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"],
                                        datasets: [<% out.print(ObDaoDespesa.Despesa_Grafico_nivel(ano));%>]
                                };
                                //formatar para real
                                        function formatar(valor) {
                                        var moeda = 'R$';
                                                valor = ('' + valor).split('.');
                                                var parteInteira = valor[0];
                                                var parteDecimal = valor[1];
                                                // tratar a parte inteira
                                                var rx = /(\d+)(\d{3})/;
                                                parteInteira = parteInteira.replace(/^\d+/, function(w) {
                                                while (rx.test(w)) {
                                                w = w.replace(rx, '$1.$2');
                                                }
                                                return w;
                                                });
                                                // tratar a parte decimal
                                                var formatoDecimal = 2;
                                                if (parteDecimal)
                                                parteDecimal = parteDecimal.slice(0, formatoDecimal);
                                                else if (!parteDecimal && formatoDecimal) {
                                        parteDecimal = '';
                                                while (parteDecimal.length < formatoDecimal) {
                                        parteDecimal = '0' + parteDecimal;
                                        }
                                        }
                                        if (parteDecimal.length < formatoDecimal) {
                                        while (parteDecimal.length < formatoDecimal) {
                                        parteDecimal = parteDecimal + '0';
                                        }
                                        }
                                        var string = moeda + (parteDecimal ? [parteInteira, parteDecimal].join(',') : parteInteira);
                                                return string;
                                        }
                                //---------------------------------------------

                                //grafico 
                                var barChartCanvas = $("#barChart").get(0).getContext("2d");
                                        var barChart = new Chart(barChartCanvas);
                                        var barChartData = areaChartData;
                                        barChartData.datasets[0].fillColor = "#00a65a";
                                        barChartData.datasets[0].strokeColor = "#00a65a";
                                        barChartData.datasets[0].pointColor = "#00a65a";
                                        //grafico 1
                                        var barChartCanvas1 = $("#barChart1").get(0).getContext("2d");
                                        var barChart1 = new Chart(barChartCanvas1);
                                        var barChartData1 = areaChartData1;
                                        //grafico 2
                                        var barChartCanvas2 = $("#barChart2").get(0).getContext("2d");
                                        var barChart2 = new Chart(barChartCanvas2);
                                        var barChartData2 = areaChartData2;
                                        // grafico 3 
                                        var barChartCanvas3 = $("#barChart3").get(0).getContext("2d");
                                        var barChart3 = new Chart(barChartCanvas3);
                                        var barChartData3 = areaChartData3;
                                        var barChartOptions = {
                                        responsive: true,
                                                // maintainAspectRatio: true,
                                                barStrokeWidth: 3,
                                                stacked: true,
                                                showAllTooltips: true,

                                                multiTooltipTemplate: function(chartData) {
                                                return chartData.datasetLabel + " : " + formatar(chartData.value);
                                                },
                                                tooltipTemplate: function(data) {
                                                return   formatar(data.value);
                                                },
                                                scaleLabel: function(data) {
                                                return   formatar(data.value);
                                                }


                                        };
                                        barChart1.Bar(barChartData1, barChartOptions);
                                        barChart.Bar(barChartData, barChartOptions);
                                        barChart2.Bar(barChartData2, barChartOptions);
                                        barChart3.Bar(barChartData3, barChartOptions);
                                        legend(document.getElementById("barsLegend1"), barChartData1);
                                        legend(document.getElementById("barsLegend"), barChartData);
                                        legend(document.getElementById("barsLegend2"), barChartData2);
                                        legend(document.getElementById("barsLegend3"), barChartData3);
                                });
                                function img(grafico) {

                                $("#" + grafico + "").get(0).toBlob(function(blob) {
                                saveAs(blob, "grafico.png");
                                });
                                }


            </script>    
    </body>
</html>

