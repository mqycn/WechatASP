<%
'================================================================
'=   �ļ����ƣ�info.asp                                         =
'=   ʵ�ֹ��ܣ��鿴��������                                     =
'=   ������ҳ��http://www.miaoqiyuan.cn/                        =
'=   ���°汾��https://gitee.com/mqycn/WechatASP                =
'=   ��ϵ���䣺mqycn@126.com                                    =
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
		%><!DOCTYPE html><html lang="zh-CN"><head><meta charset="gb2312"><script>alert('����������');history.go(-1);</script></head></html><%
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
      <i>����״̬</i>
    </div>
    <div class="panel-body">
      <div class="row">
        <div class="col-sm-12">
          <form class="form-horizontal order-info">
            <div class="form-group">
              <label for="o_title" class="col-sm-2 control-label">������</label>
              <div class="col-sm-10">
                <i><% = orderNo %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_title" class="col-sm-2 control-label">��������</label>
              <div class="col-sm-10">
                <i><% = o_title %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_body" class="col-sm-2 control-label">��������</label>
              <div class="col-sm-10">
                <i><% = o_body %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-2 control-label">�������</label>
              <div class="col-sm-10">
                <i><span class="glyphicon glyphicon-yen"></span><b><%=o_money %></b>Ԫ</i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_money" class="col-sm-2 control-label">֧����ʽ</label>
              <div class="col-sm-10">
                <i><%=o_paytype %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_paytime" class="col-sm-2 control-label">֧��ʱ��</label>
              <div class="col-sm-10">
                <i><%=o_paytime %></i>
              </div>
            </div>
            <div class="form-group">
              <label for="o_trade_no" class="col-sm-2 control-label">֧������</label>
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
