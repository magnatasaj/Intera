<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.interativaconsultoria.dao.DaoAno"%>
<%@page import="com.interativaconsultoria.dao.DaoReceita"%>

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
<%@page import="com.interativaconsultoria.dao.DaoAno"%>
<%@page import="com.interativaconsultoria.dao.DaoDespesaNivel"%>
<%@page import="com.interativaconsultoria.objetos.Despesa_Niveis"%>
<%@page import="java.util.List"%>
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
<% DaoReceita ObDaoReceita = new DaoReceita(app.getPrefixo_tb()); %>
<% DaoDespesa ObDaoDespesa = new DaoDespesa(app.getPrefixo_tb()); %>

<% DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel(app.getPrefixo_tb()); %>
<%
    Calendar cal = GregorianCalendar.getInstance();
    String ano = "";
    if (request.getParameter("ano") == null) {
        ano = Integer.toString(cal.get(Calendar.YEAR));
    } else {
        ano = request.getParameter("ano");
    }


%>

            <!-- Conteúdo ------------------------------------------------------------------------------------------------->
            <div class="content-wrapper">
                <div class="box bg-red-gradient">
                    <div class="box-header with-border"  style="color: #fff">

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
                        <form action="de_x_re-grafico.jsp" method="get">
                            <h1 class="box-title">Escolha o ano para geração dos gráficos</h1>
                            <select id="ano" name="ano" class="form-control">
                                <option></option>
                                <% DaoAno dano = new DaoAno(app.getPrefixo_tb());
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
                </div>
                <!-- /.box-body -->
                <div class="box" >
                    <div class="box-header" style="height: 100px" >
                        <h3 class="box-title">Anual por Área 2</h3>

                        <div class="box-tools pull-right" >
                            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
                        </div>
                    </div>


                    <div class="box-body">
                        <div id="container1" style="width:100%; height: 100%;"></div>

                    </div>

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


                    <div class="box-body">
                        <div id="container2" style="width:100%; height: 100%;"></div>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- fecha gratifo teste -->

            </div>
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
            // padrão valor em br            
            Highcharts.setOptions({
            lang: {
            decimalPoint: ',',
                    thousandsSep: '.'

            }
            });
                    // primeiro gráfico  
                    var categories = [
                            "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez"
                    ];
                    var d = Highcharts.chart('container', {
                    chart: {
                    type: 'column'
                    },
                            title: {
                            text: 'Resultado'
                            },
                            subtitle: {
                            text: ''
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
                            series: [<%out.print(ObDaoReceita.Receita_Grafico_vendido(1, ano));%>
                            , {
                            name: 'Despesa',
            <% out.print("data: [" + ObDaoDespesa.Gerar_Grafico_despesa(ano) + "]");%>
                            },
            <%out.print(ObDaoReceita.Receita_Grafico_vendido_menos_despesas(1, ano));%>
                            ]
                    });
                    //gráfico 1               
                    var d1 = Highcharts.chart('container1', {
                    chart: {
                    type: 'column'
                    },
                            title: {
                            text: 'Despesas x Receitas'
                            },
                            subtitle: {
                            text: ''
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
                            series: [<%out.print(ObDaoReceita.Receita_Grafico_vendido(1, ano));%>
                            , {
                            name: 'Despesa',
            <% out.print("data: [" + ObDaoDespesa.Gerar_Grafico_despesa(ano) + "]");%>
                            }

                            ]
                    });
                    //gráfico 2

                    var d2 = Highcharts.chart('container2', {
                    chart: {
                    type: 'column'
                    },
                            title: {
                            text: 'Receita detalhada'
                            },
                            subtitle: {
                            text: ''
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
            <% String v = ObDaoReceita.Receita_Grafico_vendido(2, ano);
                if (!v.equals("")) {
                    v += ",";
                }
                out.print(v);
                out.print(ObDaoReceita.Receita_Grafico_vendido(1, ano) + ",");
                out.print(ObDaoReceita.Receita_Grafico_Credito_futuro(2, ano));%>

                            ]
                    });















        </script>    
    </body>
</html>
<%ObDaoReceita.fechar();  %>
<% ObDaoDespesa.fechar(); 
 %>

<% ObDaoDespesaNivel.fechar(); %>
<% dano.fechar(); v = null; System.gc(); %> 
