<%
'================================================================
'=   �ļ����ƣ�save.asp                                         =
'=   ʵ�ֹ��ܣ��ύ����                                         =
'=   ������ҳ��http://www.miaoqiyuan.cn/                        =
'=   ���°汾��https://gitee.com/mqycn/WechatASP                =
'=   ��ϵ���䣺mqycn@126.com                                    =
'================================================================
%>
<!--#include file="conn.asp"-->
<%
	o_title = Request("o_title")
	o_body = Request("o_body")
	o_money = Request("o_money")
	o_paytype = Request("o_paytype")
	
	errMsg = ""
	if o_title = "" then errMsg = errMsg & "���ⲻ��Ϊ��;"
	if o_body = "" then errMsg = errMsg & "��������Ϊ��;"
	if o_paytype <> "weixin" then errMsg = errMsg & "��ʾ�������ѡ��΢��֧��;"
	if not isnumeric(o_money) then
		errMsg = errMsg & "����������Ϊ����;"
	else
		o_money = cSng(o_money)
		if o_money <= 0 then errMsg = errMsg & "�������������0;"
		o_money = formatnumber(o_money,2)
	end if
	
	if errMsg <> "" then
		%><!DOCTYPE html><html lang="zh-CN"><head><meta charset="gb2312"><script>alert('<% =replace(errMsg, ";", "\n") %>');history.go(-1);</script></head></html><%
		response.end
	end if
	randomize
	o_order_no = year(now()) & month(now()) & day(now()) & hour(now()) & minute(now()) & second(now()) & cLng(rnd() * 10000)
	o_status = 1
	rs.Open "select * from orderinfo", conn, 3, 2
	rs.addnew
	rs("o_title") = o_title
	rs("o_body") = o_body
	rs("o_money") = o_money
	rs("o_status") = o_status
	rs("o_order_no") = o_order_no
	rs("o_paytype") = o_paytype
	rs.update
	rs.close
	conn.close
	
	Response.Redirect "pay.asp?order_no=" & o_order_no
%>