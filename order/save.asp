<%
'================================================================
'=   文件名称：save.asp                                         =
'=   实现功能：提交订单                                         =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
%>
<!--#include file="conn.asp"-->
<%
	o_title = Request("o_title")
	o_body = Request("o_body")
	o_money = Request("o_money")
	o_paytype = Request("o_paytype")
	
	errMsg = ""
	if o_title = "" then errMsg = errMsg & "标题不能为空;"
	if o_body = "" then errMsg = errMsg & "描述不能为空;"
	if o_paytype <> "weixin" then errMsg = errMsg & "演示程序必须选择微信支付;"
	if not isnumeric(o_money) then
		errMsg = errMsg & "订单金额必须为数字;"
	else
		o_money = cSng(o_money)
		if o_money <= 0 then errMsg = errMsg & "订单金额必须大于0;"
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