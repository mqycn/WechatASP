<%
'================================================================
'=   �ļ����ƣ�conn.asp                                         =
'=   ʵ�ֹ��ܣ����ݿ�����                                       =
'=   ������ҳ��http://www.miaoqiyuan.cn/                        =
'=   ���°汾��https://gitee.com/mqycn/WechatASP                =
'=   ��ϵ���䣺mqycn@126.com                                    =
'================================================================
	set conn = Server.CreateObject("Adodb.Connection")
	conn.open "provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("demo.mdb")
	
	set rs = Server.CreateObject("Adodb.RecordSet")
%>