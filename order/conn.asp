<%
'================================================================
'=   �ļ����ƣ�conn.asp                                         =
'=   ʵ�ֹ��ܣ����ݿ�����                                       =
'=   ������ҳ��http://www.miaoqiyuan.cn/index.html              =
'=   ���°汾��http://git.oschina.net/mqycn/WechatASP           =
'=   ��ϵ���䣺mqycn@126.com;                                   =
'================================================================
	set conn = Server.CreateObject("Adodb.Connection")
	conn.open "provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("demo.mdb")
	
	set rs = Server.CreateObject("Adodb.RecordSet")
%>