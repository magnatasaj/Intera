
<%@page import="java.util.Properties"%>
<%@page import="com.interativaconsultoria.dao.Propriedade"%>
<%@page import="com.interativaconsultoria.objetos.User"%>

<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel" >
            <div class="pull-left image" style="min-height: 40px">
          <img src="/<%out.print(Propriedade.getApp()); %>/dist/img/<%out.print(Propriedade.getApp()); %>.png" class="img-thumbnail" alt="User Image">
        </div>
            <div class="pull-left info" style="color: #FFF">
                 <p>APP: <%out.print(Propriedade.getNome()); %></p>

                <p>Olá, <% User al = new User();
            al = (User)session.getAttribute("nome");
    out.print(al.getNome()); %></p>
            </div>
           
        </div>
        
          <input type="text" id="tbusca" name="q" class="form-control" placeholder="Buscar...">
              
        
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul id="treeview-menu" class="sidebar-menu">
            <li class="header">MENU DE NAVEGAÇÃO</li>
            <li class="active treeview " >
                <a style="border-left-color: #f00" href="#">
                    <i class="fa fa-arrow-circle-down" style="color: #f00"></i> <span>Despesas</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul id="treeview-menu" class="treeview-menu">
                    <li><a href="areas.jsp"><i class="fa fa-angle-right"></i>Áreas</a></li>
                    <li><a href="entrada-despesa.jsp"><i class="fa fa-angle-right"></i>Entrada de Despesas</a></li>
                    <li><a href="buscar-despesa.jsp"><i class="fa fa-angle-right"></i>Buscar Despesas</a></li>

                </ul>
            </li>
            <li class="active treeview">
                <a style="border-left-color: green" href="#">
                    <i class="fa fa-arrow-circle-up" style="color: green"></i>
                    <span>Receita</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul id="treeview-menu" class="treeview-menu">
                    <li><a href="entrada-receita.jsp"><i class="fa fa-angle-right"></i>Entrada de Receita</a></li>
                    <li><a href="buscar-receita.jsp"><i class="fa fa-angle-right"></i>Buscar Receita</a></li>

                </ul>
            </li>
            <% if(al.getTipo() == 1){ %>
            <li class="active treeview">
                <a style="border-left-color: #005983" href="#">
                    <i class="fa  fa-area-chart" style="color: #005983"></i>
                    <span>Resultados</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul id="treeview-menu" class="treeview-menu">
                    <li><a href="despesa-grafico.jsp"><i class="fa fa-angle-right"></i>Gráfico despesas</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gráfico receitas</a></li>
                    <li><a href="de_x_re-grafico.jsp"><i class="fa fa-angle-right"></i>Gráfico receitas x despesas</a></li>




                </ul>
            </li>
             <li class="active treeview">
                <a style="border-left-color: #FF7E00" href="#">
                    <i class="fa  fa-area-chart" style="color: #FF7E00"></i>
                    <span>Relatórios</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul id="treeview-menu" class="treeview-menu">
                    <li><a href="despesa-grafico.jsp"><i class="fa fa-angle-right"></i>Gráfico despesas</a></li>
                    <li><a href="receita-relatorio.jsp"><i class="fa fa-angle-right"></i>Receita</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gráfico receita</a></li>




                </ul>
            </li>
            <% };%>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>