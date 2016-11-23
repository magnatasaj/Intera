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
                <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
            </div>
            <div class="pull-left info">
                <p>Alexander Pierce</p>
                <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
            </div>
        </div>
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search...">
                <span class="input-group-btn">
                    <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                    </button>
                </span>
            </div>
        </form>
        <!-- /.search form -->
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li class="header">MENU DE NAVEGAÇÃO</li>
            <li class="active treeview">
                <a href="#">
                    <i class="fa fa-dashboard"></i> <span>Despesas</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li class="active"><a href="areas.jsp"><i class="fa fa-circle-o"></i>Áreas</a></li>
                    <li><a href="entrada-despesa.jsp"><i class="fa fa-circle-o"></i>Entrada de Despesas</a></li>
                    <li><a href="buscar-despesa.jsp"><i class="fa fa-circle-o"></i>Buscar Despesas</a></li>
                    <li><a href="despesa-grafico.jsp"><i class="fa fa-circle-o"></i>Gráfico</a></li>

                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-files-o"></i>
                    <span>Receita</span>
                </a>
                <ul class="treeview-menu">
                    <li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i></a></li>
                    <li><a href="pages/layout/boxed.html"><i class="fa fa-circle-o"></i> Boxed</a></li>
                    <li><a href="pages/layout/fixed.html"><i class="fa fa-circle-o"></i> Fixed</a></li>
                    <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
                </ul>
            </li>

        </ul>
    </section>
    <!-- /.sidebar -->
</aside>