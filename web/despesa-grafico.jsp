<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.interativaconsultoria.dao.DaoAno"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
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
                <div class="box" style="border-top: 10px solid red">
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

                        
                            <div id="container" style="width:100%; height: 100%;"></div>


                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header" >
                        <h3 class="box-title">Anual por Área 1</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>


                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend1"></div>
                            <div id="container1" style="min-width: 310px; margin: 0 auto"></div>


                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header"  >
                        <h3 class="box-title">Anual por Área 2</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>


                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend2"></div>
                            <div id="container2" style="min-width: 310px;  margin: 0 auto"></div>

                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>

                <div class="box" >
                    <div class="box-header"  >
                        <h3 class="box-title">Anual por Área 3</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>

                    <div class="box-body">
                        <div class="chart">
                            <div id="barsLegend3"></div>
                            <div id="container3" style="min-width: 310px; margin: 0 auto"></div>

                        </div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- fecha gratifo teste -->

            </div>
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
// padrão valor em br            
Highcharts.setOptions({
		lang: {
            decimalPoint: ',',
            thousandsSep: '.'
            
		}
	});
// primeiro gráfico                                        
            var d = Highcharts.chart('container', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Monthly Average Rainfall'
                },
                subtitle: {
                    text: 'Source: WorldClimate.com'
                },
                xAxis: {
                    categories: [
                        "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
                    ],
                    crosshair: true
                },
                yAxis: {
                    labels: {
                        format: 'R$ {value}',
                        style: {
                            color: '#89A54E'
                        }
                    }
                },
                tooltip: {
                    valueDecimals: 2,
                    valuePrefix: 'R$ ',
                    shared: true,
                },
                 plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            format: "R$ {y:,3.2f}"
                            
                        }


                    }},
                series: [{
                        name: 'Despesa',
            <% out.print("data: [" + ObDaoDespesa.Gerar_Grafico_despesa(ano) + "]");%>
                    }
                ]
            });

//grafico 1

            var d1 = Highcharts.chart('container1', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Monthly Average Rainfall'
                },
                subtitle: {
                    text: 'Source: WorldClimate.com'
                },
                xAxis: {
                    categories: [
                        "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
                    ],
                    crosshair: true
                },
                yAxis: {
                    labels: {
                        format: 'R$ {value}',
                        style: {
                            color: '#89A54E'
                        }
                    }
                },
                 tooltip: {
                    valueDecimals: 2,
                    valuePrefix: 'R$ ',
                    shared: true

                },
                 plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            format: "R$ {y:,3.2f}"
                            
                        }


                    }},
                series: [
            <% out.print(ObDaoDespesa.Despesa_Grafico_nivel1(ano));%>

                ]
            });

//grafico 2

            var d2 = Highcharts.chart('container2', {
                chart: {
                    type: 'column'
                    
                },
                title: {
                    text: 'Monthly Average Rainfall'
                },
                subtitle: {
                    text: 'Source: WorldClimate.com'
                },
                xAxis: {
                    categories: [
                        "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
                    ],
                    crosshair: true
                },
                yAxis: {
                    labels: {
                        format: 'R$ {value}',
                        style: {
                            color: '#89A54E'
                        }
                    }
                },
                tooltip: {
                    valueDecimals: 2,
                    valuePrefix: 'R$ ',
                    shared: true
                                  

                },
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            format: "R$ {y:,3.2f}"
                            
                            
                            
                        }


                    }},
                series: [
            <% out.print(ObDaoDespesa.Despesa_Grafico_nivel2(ano));%>

                ]
            });
//grafico 3

            var d3 = Highcharts.chart('container3', {
                chart: {
                    type: 'column'
                },
                title: {
                    text: 'Monthly Average Rainfall'
                },
                subtitle: {
                    text: 'Source: WorldClimate.com'
                },
                xAxis: {
                    categories: [
                        "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
                    ],
                    crosshair: true
                },
                yAxis: {
                    labels: {
                        format: 'R$ {value}',
                        style: {
                            color: '#89A54E'
                        }
                    }
                },
                tooltip: {
                    valueDecimals: 2,
                    valuePrefix: 'R$ ',
                    shared: true

                },
                 plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        
                        dataLabels: {
                            enabled: true,
                            crop: false,
                            overflow: 'none',
                            format: "R$ {y:,3.2f}"
                            
                        }


                    }},
                series: [
            <% out.print(ObDaoDespesa.Despesa_Grafico_nivel(ano));%>
                ]
            });



        </script>    
    </body>
</html>

