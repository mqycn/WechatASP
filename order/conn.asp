<%
'================================================================
'=   文件名称：conn.asp                                         =
'=   实现功能：数据库连接                                       =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
	set conn = Server.CreateObject("Adodb.Connection")
	conn.open "provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("demo.mdb")
	
	set rs = Server.CreateObject("Adodb.RecordSet")
%>