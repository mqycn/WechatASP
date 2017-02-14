<%	@codepage = 65001 %>
<%
'================================================================
'=   文件名称：wxapi.asp                                        =
'=   实现功能：微信对接（所有微信调用都通过这里实现）           =
'=   作者主页：http://www.miaoqiyuan.cn/index.html              =
'=   最新版本：http://git.oschina.net/mqycn/WechatASP           =
'=   联系邮箱：mqycn@126.com;                                   =
'================================================================
%>
<!--#include file="conn.asp"-->
<!--#include file="../core/WeChatPay.asp"-->
<!--#include file="payconfig.asp"-->
<%
	orderNo = Request.QueryString("order_no")
	if not isnumeric(orderNo) then orderNo = 0
	
	Select Case Request.QueryString("payType")
		Case "ajax"
			Response.ContentType = "text/javascript;charset=utf-8"
			'检查订单信息
			if GetOrderInfo(OrderRs, 1, orderNo) then
				o_title = OrderRs("o_title")
				o_body = OrderRs("o_body")
				o_money = OrderRs("o_money")
				OrderRs.close
				result = pay.Pay(orderNo, o_title, o_body, o_money)
				if left(result, 15) = "weixin://wxpay/" then
					response.write "{""status"":true, ""payUrl"":""" & result & """}"
				else
					response.write "{""status"":false, ""errMsg"":""" & result & """}"
				end if
			else
				response.write "{""status"":false, ""errMsg"":""订单不存在""}"
			end if
		Case "check"
			Response.ContentType = "text/javascript;charset=utf-8"
			'检查订单状态
			if GetOrderInfo(OrderRs, 2, orderNo) then
				OrderRs.close
				response.write "{""status"":true}"
			else
				response.write "{""status"":false}"
			end if
		Case Else
			'微信返回结果
			dim RESULT_XML	'将请求日志记录到文本文件，需要在GetNotify()之前定义
			set result = pay.GetNotify()
			if result.item("status") = false then
				response.write result.item("message")
			else
				out_trade_no = result.item("out_trade_no")
				total_fee = result.item("total_fee")
				trade_no = result.item("trade_no")
				if GetOrderInfo(OrderRs, 1, out_trade_no) then
					'调整订单状态为支付完成
					OrderRs("o_trade_no") = trade_no
					OrderRs("o_paytime") = now()
					OrderRs("o_status") = 2
					OrderRs.update
					OrderRs.close
					response.write "<return_code>SUCCESS</return_code><return_msg>OK</return_msg>"
				else
					'没有等待确认的订单，一般修改为成功，不让微信继续通知
					response.write "<return_code>SUCCESS</return_code><return_msg>OK</return_msg><info>OrderError:" & out_trade_no & "</info>"
				end if
			end if
			
			'记录日志
			set fso = server.createobject("Scripting.FileSystemObject")
			set fto = fso.createtextfile(server.mappath("/order/log/" & resultType & "_log_" & out_trade_no & "_" & timer() & ".txt"))
			fto.write(now() & vbCrlf & request.querystring & vbCrlf & RESULT_XML)
			fto.close
			set fso = nothing
			
	End Select
	
	Conn.Close
	
	'=============================================================================================
	function GetOrderInfo(byref orderRecordSet, byval orderStatus, byval orderNo)
		set orderRecordSet = Server.CreateObject("Adodb.RecordSet")
		orderRecordSet.open "select * from orderinfo where o_paytype='weixin' and o_status=" & orderStatus & " and o_order_no='" & orderNo & "'", Conn, 3, 2
		if orderRecordSet.eof then
			orderRecordSet.close
			GetOrderInfo = false
		else
			GetOrderInfo = true
		end if
	end function
%>