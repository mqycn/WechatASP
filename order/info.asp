<%
'================================================================
'=   文件名称：info.asp                                         =
'=   实现功能：查看订单详情                                     =
'=   作者主页：http://www.miaoqiyuan.cn/                        =
'=   最新版本：https://gitee.com/mqycn/WechatASP                =
'=   联系邮箱：mqycn@126.com                                    =
'================================================================
%>
<!--#include file="conn.asp"-->
<%
	orderNo = Request.QueryString("order_no")
	if not isnumeric(orderNo) then orderNo = 0
	
	rs.open "select * from orderinfo where o_order_no='" & orderNo & "'", conn, 1, 1
	if rs.eof then
		rs.close
		conn.close
		%><!DOCTYPE html><html lang="zh-CN"><head><meta charset="gb2312"><script>alert('订单不存在');history.go(-1);</script></head></html><%
		response.end
	end if
	o_title = rs("o_title")
	o_body = rs("o_body")
	o_money = rs("o_money")
	o_paytype = rs("o_paytype")
	o_status = rs("o_status")
	o_paytime = rs("o_paytime")
	o_trade_no = rs("o_trade_no")
	rs.close
	conn.close
	
	if o_status = 1 then
		response.redirect "pay.asp?order_no=" & orderNo
	end if
%>
<!--#include file="header.asp"-->
<div class="container">
  <div class="panel panel-primary">
    <div class="panel-heading">
      <i>订单状态</i>
    </div>
    <div class="panel-body">
      <div class="row">
        <div class="col-sm-12">
          <form class="form-horizontal order-info">
            <div class="form-group">
              <label for="o_title" class="col-sm-2 control-label">订单号</label>
              <div class="col-sm-10">
                <i><% = orderNo %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_title" class="col-sm-2 control-label">订单标题</label>
              <div class="col-sm-10">
                <i><% = o_title %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_body" class="col-sm-2 control-label">订单描述</label>
              <div class="col-sm-10">
                <i><% = o_body %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-2 control-label">订单金额</label>
              <div class="col-sm-10">
                <i><span class="glyphicon glyphicon-yen"></span><b><%=o_money %></b>元</i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-2 control-label">支付方式</label>
              <div class="col-sm-10">
                <i><%=o_paytype %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_paytime" class="col-sm-2 control-label">支付时间</label>
              <div class="col-sm-10">
                <i><%=o_paytime %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_trade_no" class="col-sm-2 control-label">支付单号</label>
              <div class="col-sm-10">
                <i><%=o_trade_no %></i>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<!--#include file="footer.asp"-->
