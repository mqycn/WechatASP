<%
'================================================================
'=   文件名称：header.asp                                       =
'=   实现功能：公共头部                                         =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WeChatASP演示</title>
<link href="../static/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
body{padding-top:15px;}
#logo{z-index:999;cursor:help;background:#337AB7;width:240px;color:#FFF;margin-top:-5px;padding:10px;text-align:center;border-radius:5px;border-top-left-radius:25px;border-bottom-right-radius:25px;}
.order-info i{display:block;background:#EEE;border:solid 1px #CCC;border-radius:5px;padding:3px 8px;color:#333;font-size:1.2em;font-style:normal;}
.paycode{text-align:center;width:200px;margin:0 auto;border:solid 10px #CCC;border-radius:5px;}
.paycode img{width:100%;}
.paymsg{background:#CCC;}
</style>
<script src="../static/js/jquery.min.js"></script>
<!--[if lt IE 9]>
  <script src="../static/js/html5shiv.min.js"></script>
  <script src="../static/js/respond.min.js"></script>
<![endif]-->
</head>

<body>
<div class="container">
  <div class="header clearfix">
    <nav>
      <ul class="nav nav-pills pull-right">
        <li role="presentation" class="active"><a href="#">程序演示</a></li>
        <li role="presentation"><a href="http://www.miaoqiyuan.cn/p/asp-wechat-pay-vip">部署说明</a></li>
        <li role="presentation"><a href="https://gitee.com/mqycn/WechatASP/">最新源码</a></li>
      </ul>
    </nav>
    <h3 class="text-muted" id="logo">WeChatASP演示</h3>
  </div>
</div>