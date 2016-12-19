<%-- 
    Document   : menu-lateral
    Created on : 25/10/2016, 15:15:34
    Author     : Lamara
--%>
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- Sidebar user panel -->
        <div class="user-panel">
            <div class="pull-left image">
                <img src="dist/img/user2-160x160.png" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>Rodrigo Silva</p>
            </div>
        </div>
        
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">MENU DE NAVEGA��O</li>
            <li class="active treeview " >
                <a style="border-left-color: #f00" href="#">
                    <i class="fa fa-arrow-circle-up" style="color: #f00"></i> <span>Despesas</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="areas.jsp"><i class="fa fa-angle-right"></i>�reas</a></li>
                    <li><a href="entrada-despesa.jsp"><i class="fa fa-angle-right"></i>Entrada de Despesas</a></li>
                    <li><a href="buscar-despesa.jsp"><i class="fa fa-angle-right"></i>Buscar Despesas</a></li>

                </ul>
            </li>
            <li class="active treeview">
                <a style="border-left-color: green" href="#">
                    <i class="fa fa-arrow-circle-down" style="color: green"></i>
                    <span>Receita</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="entrada-receita.jsp"><i class="fa fa-angle-right"></i>Entrada de Receita</a></li>
                    <li><a href="buscar-receita.jsp"><i class="fa fa-angle-right"></i>Buscar Receita</a></li>

                </ul>
            </li>
            <li class="active treeview">
                <a style="border-left-color: #005983" href="#">
                    <i class="fa  fa-area-chart" style="color: #005983"></i>
                    <span>Resultados</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="despesa-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico despesas</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico receita</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico receita</a></li>




                </ul>
            </li>
             <li class="active treeview">
                <a style="border-left-color: #FF7E00" href="#">
                    <i class="fa  fa-area-chart" style="color: #FF7E00"></i>
                    <span>Relat�rios</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="despesa-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico despesas</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico receita</a></li>
                    <li><a href="receita-grafico.jsp"><i class="fa fa-angle-right"></i>Gr�fico receita</a></li>




                </ul>
            </li>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>