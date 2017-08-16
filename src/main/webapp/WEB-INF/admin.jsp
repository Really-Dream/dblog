<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="/admin/assets/materialize/css/materialize.min.css" media="screen,projection" />
    <!-- Bootstrap Styles-->
    <link href="/admin/assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FontAwesome Styles-->
    <link href="/admin/assets/css/font-awesome.css" rel="stylesheet" />
    <!-- Morris Chart Styles-->
    <link href="/admin/assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
    <!-- Custom Styles-->
    <link href="/admin/assets/css/custom-styles.css" rel="stylesheet" />
    <!-- Google Fonts-->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" href="/admin/assets/js/Lightweight-Chart/cssCharts.css">
    <%--<link rel="stylesheet" href="/other/css/dialog.css">--%>

    <%--<link rel="stylesheet" href="/dialog/css/global.css">--%>
    <%--<link rel="stylesheet" href="/dialog/css/animate.css">--%>
    <%--<link rel="stylesheet" href="/dialog/css/dialog.css">--%>


    <style type="text/css">
        #bg{ display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.7;  opacity:.70;  filter: alpha(opacity=70);}
        #show{display: none;  position: absolute;  top: 25%;  left: 22%;  width: 53%;  height: 49%;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;  z-index:1002;  overflow: auto;}
        .dw-btn { cursor: pointer; border: none; outline: none; font-size: 14px; padding: 10px 32px; display: inline-block; vertical-align: middle;  *vertical-align: auto;
            *zoom: 1;
            *display: inline;
            -moz-border-radius: 4px; -webkit-border-radius: 4px; border-radius: 4px; background: #9e9e9e; color: #ffffff; -moz-border-radius: 4px; -webkit-border-radius: 4px; border-radius: 4px; overflow-wrap: break-word; }
        .dw-btn.has-hover:hover { background: #e1e1e1; }
        .dw-btn:disabled { background: #aaaaaa !important; color: #fff !important; border: none !important; }
    </style>
</head>

<body>
<div id="wrapper">
    <nav class="navbar navbar-default top-navbar" role="navigation">
        <div class="navbar-header">
                <a class="navbar-brand waves-effect waves-dark" href="/blog/index"><i class="large material-icons">insert_chart</i> <strong>Dream</strong></a>
                <div id="sideNav" href=""><i class="material-icons dp48" onclick="showdiv();">toc</i></div>
        </div>
    </nav>

    <!--/. NAV TOP  -->
    <nav class="navbar-default navbar-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav" id="main-menu">
                <li>
                    <a class="active-menu waves-effect waves-dark" onclick="setArticeList(0)"><i class="fa fa-dashboard"></i> HOME</a>
                </li>
                <c:forEach items="${list}" var="blog">
                    <li>
                        <a class="active-menu waves-effect waves-dark" onclick="setArticeList(${blog.id})"><i class="fa fa-dashboard"></i> ${blog.title}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </nav>
    <!-- /. NAV SIDE  -->

    <div id="page-wrapper" >
        <div class="header" style="height: 0px">
            <h1 class="page-header"></h1>
        </div>

        <div id="page-inner">

            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="card">
                        <div class="card-action" id="title"></div>
                        <div class="card-content">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                    <tr>
                                        <th>编号</th>
                                        <th>标题</th>
                                        <th>创建时间</th>
                                        <th>修改时间</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="article"></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
          </div>
        <!-- /. PAGE INNER  -->
    </div>
    <!-- /. PAGE WRAPPER  -->
    <div id="bg"></div>
    <div id="show" >
        <div class="row" style="margin-right:0;margin-left:0;margin-top: 10%" >
            <div class="input-field col s6" style="left: 25%;right: 25%">
                <input style="text-align:center;" placeholder="分类" id="parent_name" readonly type="text" class="validate">
                <input id="parent_id" hidden >
            </div>
        </div>
        <div class="row" style="margin:0 auto;">
            <div class="input-field col s6" style="left: 25%;right: 25%">
                <input style="text-align:center;" placeholder="标题" id="sub_name" type="text" class="validate">
                <input id="sub_id" hidden >
            </div>
        </div>
        <div style="text-align:center;">
            <input class="dw-btn has-hover disabled input-reverse-tofull" type="button" value="提交" onclick="submitTitle();"/>
            <input class="dw-btn has-hover disabled input-reverse-tofull" type="button" value="退出" onclick="hidediv();"/>
        </div>
    </div>
</div>



<script src="/markdown/jquery-3.2.1.min.js"></script>
<%--<script src="/dialog/js/dialog.js"></script>--%>


<script type="text/javascript">
    var parent_id;
    var parent_name;

    $(function(){
        setArticeList(0);
    });

    function setArticeList(id){
        parent_id = id;
        var html = "";
        $.ajaxSettings.async = false;
        $.getJSON("/blog/showChild?id="+id,function(data){
            for(var i=0; i<data.length ; i++){
                html += "<tr class='odd gradeX'>" +
                    "<td>"+data[i].id+"</td>" +
                    "<td>"+data[i].title+"</td>" +
                    "<td>"+data[i].create_time+"</td>" +
                    "<td>"+data[i].modify_time+"</td>" ;
                    if(data[i].parent_id == 0){
                        html += "<td ><a onclick='editParent("+data[i].id+")'>编辑</a>&nbsp;&nbsp;&nbsp;<a onclick='deleteBlog("+data[i].id+")'>删除</a></td></tr>";
                    }else{
                        html += "<td ><a href='/blog/editBlog?id="+data[i].id+"' target='_blank'>编辑</a>&nbsp;&nbsp;&nbsp;<a onclick='deleteBlog("+data[i].id+")'>删除</a></td></tr>";
                    }
            }
        })
        $("#article").html(html);

        $.ajaxSettings.async = false;
        $.getJSON("/blog/showTitle?id="+id,function(data){
            $("#title").html(data);
            parent_name = data;
        })
    }

    function setTitle(){
        var html = "<li><a class='active-menu waves-effect waves-dark' onclick='setArticeList(0)'><i class='fa fa-dashboard'></i> HOME</a><li>";
        $.ajaxSettings.async = false;
        $.getJSON("/blog/showParent",function(data){
            for(var i=0; i<data.length ; i++){
                html += "<li>" +
                    "<a class='active-menu waves-effect waves-dark' onclick='setArticeList("+data[i].id+")'><i class='fa fa-dashboard'></i> "+data[i].title+"</a>" +
                    "</li>";
            }
        })
        $("#main-menu").html(html);


    }

    function showdiv() {
        $("#parent_id").val(parent_id);
        $("#parent_name").val(parent_name);
        document.getElementById("bg").style.display ="block";
        document.getElementById("show").style.display ="block";
        document.getElementById("bg").style.height=document.documentElement.scrollHeight+'px';

    }
    function hidediv() {
        document.getElementById("bg").style.display ='none';
        document.getElementById("show").style.display ='none';
        $("#sub_name").val("");
    }

    function deleteBlog(id) {

        $.ajaxSettings.async = false;
        $.getJSON("/blog/delete?id="+id,function(data){
//            $("#title").html(data);
        })
        setArticeList(parent_id);
        setTitle();
    }

    function submitTitle(){
        var sub_name =   $("#sub_name").val();
        var sub_id =   $("#sub_id").val();
        if(sub_name.length<=0){
            alert("请输入标题！");
            return;
        }
        $.getJSON("/blog/insert?title="+sub_name+"&parent_id="+parent_id+"&sub_id="+sub_id,function(data){
//            $("#title").html(data);
        })
        hidediv();
        setArticeList(parent_id);
        setTitle();
    }

    function editParent(id){
        $.getJSON("/blog/getBlog?id="+id,function(data){
            showdiv();
            $("#sub_name").val(data.title);
            $("#sub_id").val(data.id);
        })
    }

</script>

</body>

</html>