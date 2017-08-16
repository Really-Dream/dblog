<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en-US" data-version="3.0.7">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
    <meta name="description" content="Vedad Siljak’s Portfolio">
    <title>D丶ream</title>

    <link type="text/css" rel="stylesheet" href="http://vedadsiljak.com/wp-content/themes/semplice/css/reset.css">
    <link href='http://fonts.googleapis.com/css?family=Playfair+Display:400,700,900,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
    <link  href='http://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>


    <link type="text/css" rel="stylesheet" href="http://vedadsiljak.com/wp-content/themes/semplice/style.css">
    <link type="text/css" rel="stylesheet" href="/other/css/index.css">


    <!-- <link rel="shortcut icon" href="http://vedadsiljak.com/wp-content/uploads/2016/03/favicon.png"> 				 -->

    <script type='text/javascript' src='http://vedadsiljak.com/wp-includes/js/jquery/jquery.js?ver=1.11.3'></script>

</head>

<body class="single single-work postid-542 is-work start-at-content">

<header >
    <div id="navbar">
        <a id="logo" data-logo-height="37" class="has-logo" href="https://github.com/Really-Dream/dblog" title="GitHub">
            <image style="width: 150px" src="/other/photo/dreamlogo.png"/>
        </a>
        <div class="container">
            <div class="row">
                <div class="span12 navbar-inner">
                    <div class="nav-wrapper">
                        <div class="controls">
                            <a class="open-nav">
                                <span class="nav-icon"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<div id="fullscreen-menu" class="full-height">
    <div class="menu-inner">
        <nav class="fs-46px light">
            <ul id="menu-hamburger" class="menu menu-container">
                <li class="menu-item menu-item-type-post_type menu-item-object-work menu-item-558"><a href="/blog/index">HOME</a></li>
                <c:forEach var="item" items="${parent_title}">
                    <c:if test="${id != undefined && id == item.id}">
                        <li class="menu-item menu-item-type-post_type menu-item-object-work current-menu-item menu-item-559"><a href="/blog/index">${item.title}</a></li>
                    </c:if>
                    <c:if test="${id == undefined || id != item.id}">
                        <li class="menu-item menu-item-type-post_type menu-item-object-work menu-item-${item.id}"><a href="/blog/index?id=${item.id}">${item.title}</a></li>
                    </c:if>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>

<div id="wrapper">
    <div id="content">
        <!-- content fade -->
        <div class="fade-content">
            <div id="content-holder" class="">
                <div id="content_pkogaqi0u" class="content-p" >
                    <div class="content-container" style="padding-top: 20px; display: block; background-color: transparent;" >
                        <div class="container">
                            <div class="row">
                                <div >
                                    <p data-font-size="96px" data-line-height="88px" id="title">${title}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="content_mjknog0gu" class="content-p">
                    <div class="content-container" style="padding-top: 120px;background-color: transparent;" >
                        <div class="container">
                            <div class="row">
                                <div class="wysiwyg-ce no-offset span10" id="parent_title">
                                    <c:forEach var="item" items="${list}">
                                        <c:if test="${item.parent_id == 0}">
                                            <p data-font-size="44px" data-line-height="88px"><a href="/blog/index?id=${item.id}"><font color='#333'>${item.title}</font></a></p>
                                        </c:if>
                                        <c:if test="${item.parent_id != 0}">
                                            <p data-font-size="44px" data-line-height="88px"><a target="_blank" href="/blog/readBlog?id=${item.id}"><font color='#333'>${item.title}</font></a></p>
                                        </c:if>
                                    </c:forEach>
                                    <%--<p data-font-size="20px" data-line-height="44px">--%>
                                        <%--<span style="color:222;"><span class="regular">Designed at COBE in 2016.</span></span>--%>
                                    <%--</p>--%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type='text/javascript' src='http://vedadsiljak.com/wp-content/themes/semplice/js/scripts.min.js?ver=4.4.2'></script>
<script src="/markdown/jquery-3.2.1.min.js"></script>
</body>
</html>